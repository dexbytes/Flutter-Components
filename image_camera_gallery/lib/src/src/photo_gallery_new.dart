import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_camera_gallery/src/image_gallery_widget/camera_option_image_widget.dart';
import 'package:image_camera_gallery/src/image_gallery_widget/clicked_image_layer_view.dart';
import 'package:image_camera_gallery/src/image_gallery_widget/photo_picker_option.dart';
import 'package:image_camera_gallery/src/src/selected_photo_gallery_new.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'package:image_camera_gallery/src/state/notification_stream.dart';
import 'package:image_camera_gallery/src/utils/asset_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../photo_gallery_main.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:image_camera_gallery/src/src/custom_image_cropping.dart';

import 'camera_screen_new.dart';

class PhotoGalleryNew extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final Function(List<ImageListBean>) resultList;
  final ImageSelectionType selectionType;
  final backToMainApp;
  PhotoGalleryNew(
      {Key key,
      this.controllerImageSelectState,
      this.resultList,
      this.backToMainApp,
      this.selectionType = ImageSelectionType.SINGLE})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryNewState();
  }
}

class _PhotoGalleryNewState extends State<PhotoGalleryNew>
    with TickerProviderStateMixin {
  Directory directory;
  int selectedCount = 0;
  int receivedFilesCount = 0;
  List allFetchedFileCorList = new List();
  List allFetchedFileCorListOk = new List();
  List<AssetPathEntity> fileListIos = List();
  String appBarTitle = "Selected";
  ImageSelectState controllerImageSelectState;
  bool isLoadingNewPage = false;
  ScrollController _scrollController = new ScrollController();
  Stream<dynamic> _notificationsStream;
  bool filesAvailable = false;
  bool navigateBack = false;
  bool isShowSelectionFromOption = true;
  // RequestType typeTemp;
  int _tabSelected = 0;
  _PhotoGalleryNewState({this.controllerImageSelectState});
  int currentPageIndex = 0;
  List<ImageGroupListBean> allImageGridListData = new List();
  List<ImageGroupListBean> allImageGroupList = new List();
  bool isDataReady = false;
  RequestType typeTemp = RequestType.common;
  //Update state of object
  setEmptyState() {
    if (mounted) {
      // setState(() {});
    }
  }

  //File Details
  ImageGroupListBean getImageListBean(
      {ImageGroupListBean mImageGroupListBean,
      Uint8List compressedFilePath,
      FileTypeToFetch fileType = FileTypeToFetch.IMAGE,
      bool isSelected = false}) {
    mImageGroupListBean.isSelected = isSelected;
    mImageGroupListBean.fileType = fileType;
    mImageGroupListBean.imageResized = compressedFilePath;
    return mImageGroupListBean;
  }

  //Update image grid view
  updateListData(ImageGroupListBean mImageGroupListBean) {
    try {
      String filePath = mImageGroupListBean.groupImage;
      //Check images total counts
      if (filePath != null && filePath.trim() != "") {
        receivedFilesCount = receivedFilesCount + 1;
        setEmptyState();
        //Check file type is video
        if (projectUtils.isVideoFile(item: filePath)) {
          try {
            VideoThumbnail.thumbnailData(
              video: filePath,
              imageFormat: ImageFormat.JPEG,
              maxWidth:
                  128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
              quality: appSetting.listRowImageQuality,
            ).then((Uint8List value) {
              if (mounted) {
                controllerImageSelectState.setAllImageGroupList =
                    getImageListBean(
                  mImageGroupListBean: mImageGroupListBean,
                  isSelected: false,
                  compressedFilePath: value,
                  fileType: FileTypeToFetch.VIDEO,
                );
                setEmptyState();
              }
            });
          } catch (e) {
            print(e);
          }
        }
        //Check file type is video
        else if (projectUtils.isImageFile(item: filePath)) {
          try {
            /*projectUtils.compressImageUint8List(
                          File(filePath), quality: appSetting.listRowImageQuality)*/
            int rotate = 0;
            int quality = 90;
            int minWidth = 200;
            int minHeight = 200;
            FlutterImageCompress.compressWithFile(
              filePath,
              minWidth: minWidth,
              minHeight: minHeight,
              quality: quality,
              rotate: rotate,
            ).then((Uint8List value) {
              if (mounted && value != null) {
                controllerImageSelectState.setAllImageGroupList =
                    getImageListBean(
                        mImageGroupListBean: mImageGroupListBean,
                        isSelected: false,
                        compressedFilePath: value,
                        fileType: FileTypeToFetch.IMAGE);
                setEmptyState();
              }
            });
          } catch (e) {
            print(e);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //User permission
  getPermissionOfStorage() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) {
      return true;
    } else {
      bool permissionEnabled = false;
      Map<Permission, PermissionStatus> permissionData =
          await [Permission.storage].request();
      if (permissionData != null &&
          permissionData[Permission.storage].isGranted) {
        permissionEnabled = true;
        _getDeviceImages();
      } else {
        if (Platform.isIOS) {
          /*AppWidgetFilesLink().appCustomUiWidget.errorDialog(
            context,
            true,
            AppValuesFilesLink().appValuesString.appName,
            AppValuesFilesLink().appValuesString.beforeCameraPermission, (
            context1) async {
          permissionEnabled = false;
          Navigator.pop(context1);
          Navigator.pop(context, true);
          if (Platform.isIOS) {
            AppSettings.openInternalStorageSettings();
          }
        }, maxLines: 4);*/
        }
      }
      return permissionEnabled;
    }
  }

  //Selected files from directory
  Future<Directory> _getDeviceImages({RequestType typeTemp1}) async {
    try {
      getPermissionOfStorage().then((permissionGranted) {
        if (permissionGranted) {
          getLocalPath().then((value) async {
            print(
                "Ended of grid view getApplicationDocumentsDirectory >>> $value");
            if (value != null) {
              directory = value;
              //("Ended of grid view getApplicationDocumentsDirectory directory >>> $directory");
              try {
                if (typeTemp1 == null) {
                  typeTemp = RequestType.common;
                  if (appSetting.fileTypeFilter == FileTypeFilter.IMAGE_ONLY) {
                    typeTemp = RequestType.image;
                  } else if (appSetting.fileTypeFilter ==
                      FileTypeFilter.VIDEO_ONLY) {
                    typeTemp = RequestType.video;
                  }
                } else {
                  typeTemp = typeTemp1;
                }

                fileListIos =
                    await PhotoManager.getAssetPathList(type: typeTemp);
                print(" assetEntity Directory Path >>> $fileListIos");
                if (fileListIos != null && fileListIos.length > 0) {
                  fileListIos =
                      await PhotoManager.getAssetPathList(type: typeTemp);
                  print(" assetEntity Directory Path >>> $fileListIos");
                  if (fileListIos != null && fileListIos.length > 0) {
                    resetProviderValues();
                    fileListIos.map((assetPathEntity) {
                      try {
                        /* List<AssetEntity> pathFileList =
                            await assetPathEntity.assetList;*/
                        assetPathEntity.assetList.then((pathFileList) {
                          AssetEntity mAssetEntity = pathFileList[0];
                          mAssetEntity.file.then((mAssetEntityLocalStr) {
                            double fileSize =
                                fileSizeCalculator(mFile: mAssetEntityLocalStr);
                            updateListDataIos("filePath",
                                mAssetEntity: mAssetEntity,
                                fileSize: fileSize,
                                dataFile: mAssetEntityLocalStr);
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    }).toList();
                    // int k = 0;
                    /*for (int i = 0; i < fileListIos.length; i++) {
                      try {
                        List<AssetEntity> pathFileList =
                        await fileListIos[i].assetList;
                        AssetEntity mAssetEntity = pathFileList[0];
                        updateListDataIos("filePath",
                            mAssetEntity: mAssetEntity);
                      } catch (e) {
                        print(e);
                      }
                    }*/
                  }
                } else {
                  Fluttertoast.showToast(msg: "No media file available");
                  Navigator.pop(context);
                }
              } catch (e) {
                print(e);
              }
            }
          });
        } else {
          Navigator.pop(context);
        }
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  //Get directory path
  Future<Directory> getLocalPath() async {
    Directory directoryTemp;
    try {
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        directoryTemp = directory;
        if (directoryTemp != null) {
          String pathTemp = directoryTemp.path;
          if (pathTemp != null && pathTemp.trim() != "") {
            pathTemp = pathTemp.substring(0, pathTemp.lastIndexOf("/0") + 2);
            directory = new Directory("$pathTemp");
          }
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
        //var/mobile/Media/DCIM/100APPLE/IMG_0913.PNG
        directory = new Directory("/var/mobile");
      }
    } catch (e) {
      print(e);
    }

    return directory;
  }

  //Remove all selected files
  removeAllSelected() {
    controllerImageSelectState.removeAllSelectedImage = true;
    controllerImageSelectState.setSelectedImageCounts = 0;
  }

  ////////////////////////// New Code /////////////////////
  Future<void> resetProviderValues() {
    controllerImageSelectState.removeAllSelectedImage = true;
    controllerImageSelectState.removeAllGalleryImage = true;
    controllerImageSelectState.reSetData = true;
    return null;
  }

  updateListDataIos(String filePath,
      {AssetEntity mAssetEntity, double fileSize = 0.0, File dataFile}) {
    try {
      receivedFilesCount = receivedFilesCount + 1;
      if (mounted) {
        controllerImageSelectState.setAllImageList = getImageListBeanNew(
            isSelected: false,
            compressedFilePath: null,
            fileType: mAssetEntity.type == AssetType.image
                ? FileTypeToFetch.IMAGE
                : FileTypeToFetch.VIDEO,
            originalFilePath: null,
            fileSize: fileSize,
            dataFile: dataFile,
            iOSAssetEntity: mAssetEntity);
        setEmptyState();
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  //File Details
  ImageListBean getImageListBeanNew(
      {String originalFilePath,
      Uint8List compressedFilePath,
      File dataFile,
      FileTypeToFetch fileType = FileTypeToFetch.IMAGE,
      bool isSelected = false,
      AssetEntity iOSAssetEntity,
      double fileSize = 0.0}) {
    ImageListBean mImageListBean = new ImageListBean();
    if (originalFilePath != null && originalFilePath.trim() != "") {
      mImageListBean.imageFile = new File(originalFilePath);
    }

    if (compressedFilePath != null) {
      mImageListBean.imageResized = compressedFilePath;
    }
    mImageListBean.isSelected = isSelected;
    mImageListBean.fileType = fileType;
    mImageListBean.iOSAssetEntity = iOSAssetEntity;
    mImageListBean.fileSize = fileSize;
    mImageListBean.dataFile = dataFile;
    return mImageListBean;
  }

  @override
  void initState() {
    super.initState();
    _getDeviceImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_updateFileListByPageIndex(isScrollEnd: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageSelectState _imageSelectStateUpdated =
        Provider.of<ImageSelectState>(context);
    if (mounted &&
        _imageSelectStateUpdated != null &&
        controllerImageSelectState == null) {
      controllerImageSelectState = _imageSelectStateUpdated;
      try {
        if (mounted) {
          ImageSelectState _imageSelectStateUpdated =
              Provider.of<ImageSelectState>(context);
          if (_imageSelectStateUpdated != null) {
            _imageSelectStateUpdated.selectionType = widget.selectionType;
            //If user select camera
            /* if (widget.openType == optionToOpen.CAMERA) {
              _imageSelectStateUpdated.selectionType = ImageSelectionType.SINGLE;
            }*/
          }
        }
      } catch (e) {
        print(e);
      }
    }
    //Back Press
    _onBackPressed() {
      if (selectedCount > 0 && mounted) {
        removeAllSelected();
        setEmptyState();
      } else {
        //Navigator.pop(context, true);
        widget.backToMainApp(null, true);
        //print("BackPress Clicked");
      }
      return Future.value(true);
    }

    selectedCount = _imageSelectStateUpdated.getSelectedImageCounts;

    Widget singleImageNew({value, bool isSelected}) => new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AssetThumbnail(asset: value, isSelected: isSelected),
            ),
          ],
        );

    Widget imageViewFileNew({ImageListBean listRowRawData, int index = 0}) {
      return Padding(
        padding: EdgeInsets.only(
            left: appSetting.gridImageAllSideMargin,
            right: appSetting.gridImageAllSideMargin,
            top: index == 0 ? 0 : 0,
            bottom: appSetting.gridImageBottomSideMargin),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    /* fileClickedNew(
                        listRowRawData: listRowRawData, index: index);*/
                  },
                  onLongPress: () {
                    /*fileClickedNew(
                        listRowRawData: listRowRawData, index: index);*/
                  },
                  child: singleImageNew(
                      value: listRowRawData.iOSAssetEntity,
                      isSelected: listRowRawData.isSelected)),
            ),
            ClickedImageLayerView(({bool isSelected, int itemIndex}) {
              print("Selected ");
              fileClickedNew(listRowRawData: listRowRawData, index: index);
              selectedCount = _imageSelectStateUpdated.getSelectedImageCounts;
              print(
                  "Selected Done $selectedCount  ${controllerImageSelectState.getSelectedImageCounts}");
            },
                itemIndex: index,
                controllerImageSelectState: controllerImageSelectState,
                listRowRawData: listRowRawData)
          ],
        ),
      );
    }

    Widget gridViewNew() {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // A grid view with 3 items per row
            crossAxisCount: appSetting.imageGridCount),
        itemCount: _imageSelectStateUpdated.getAllImageList.length,
        itemBuilder: (_, index) {
          return imageViewFileNew(
              index: index,
              listRowRawData: _imageSelectStateUpdated.getAllImageList[index]);
          //AssetThumbnail(asset: filePathList[index]);
        },
      );
    }

    Future<List<ImageListBean>> getListData() async {
      return _imageSelectStateUpdated.getAllImageList;
    }

    //Grid view of files
    Widget gridViewFutureBuilder() {
      return FutureBuilder<List<ImageListBean>>(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              )),
            );
          }
          return (projectSnap.data != null && projectSnap.data.length > 0)
              ? gridViewNew()
              : Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  )),
                );
        },
        future: getListData(),
      );
    }

    // Selected photo view with crop option
    Widget selectedPhotoWithCrop() {
      bool showCropView = false;
      ImageListBean mImageListBean;
      File imageFile;
      if (_imageSelectStateUpdated.selectedImageList != null &&
          _imageSelectStateUpdated.selectedImageList.length > 0) {
        mImageListBean = _imageSelectStateUpdated.selectedImageList[0];
        imageFile = mImageListBean.imageFile;
        showCropView = true;
      }
      if (mImageListBean != null &&
          mImageListBean.fileType != null &&
          mImageListBean.fileType == FileTypeToFetch.VIDEO) {
        showCropView = false;
      }
      return Container(
        height: MediaQuery.of(context).size.height / 2.5,
        child:
            //SelectedPhotoGalleryNew(
            showCropView == false
                ? Container()
                : CustomImageCropping(
                    imageListBean: mImageListBean,
                    isShowAddMoreOption: false,
                    controllerImageSelectState: controllerImageSelectState,
                    resultList: (imageListBean) {
                      print("Done $imageListBean");
                      //Back to main screen
                      List<ImageListBean> selectedList = [];
                      selectedList.add(imageListBean);
                      try {
                        widget.resultList(selectedList);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
      );
    }

    //Common view of gallery
    Widget galleryView = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PhotoPickerOptionWidget(
          selectPhotoOptionCallback: ({String selectedOption, int itemIndex}) {
            print("$selectedOption & $itemIndex");
            //RequestType typeTemp = RequestType.common;
            if (itemIndex == 1) {
              typeTemp = RequestType.image;
            } else if (itemIndex == 2) {
              typeTemp = RequestType.video;
            }
            removeAllSelected();
            // setEmptyState();
            _getDeviceImages(typeTemp1: typeTemp);
          },
        ),
        Expanded(
            child: Container(
                color: appStyle.screenBgColor,
                child: Padding(
                    padding: appSetting.photoGridOutSidePadding,
                    child: gridViewFutureBuilder()))),
      ],
    );

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Material(
            color: Colors.black,
            child: isShowSelectionFromOption
                ? Column(
                    children: [
                      !appSetting.isShowPhotoCropView
                          ? Container()
                          : selectedPhotoWithCrop(),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(kToolbarHeight),
                              child: Container(
                                color: appStyle.appBarColorBg,
                                height: kToolbarHeight,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: kToolbarHeight,
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: TabBar(
                                        indicatorColor:
                                            appStyle.toolBarIndicatorColor,
                                        onTap: (index) {
                                          print("$index");
                                          setState(() {
                                            if (index == 1) {
                                              removeAllSelected();
                                              _getDeviceImages(
                                                  typeTemp1: typeTemp);
                                            }
                                            _tabSelected = index;
                                          });
                                        },
                                        automaticIndicatorColorAdjustment: true,
                                        tabs: [
                                          Text(
                                            "From Device", //your text here
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: _tabSelected == 0
                                                  ? Colors.blueAccent
                                                  : Colors
                                                      .white, //your textColor
                                            ),
                                          ),
                                          Text(
                                            "Camera", //your text here
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: _tabSelected == 1
                                                  ? Colors.blueAccent
                                                  : Colors
                                                      .white, //your textColor
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            body: Stack(
                              children: [
                                galleryView,
                                _tabSelected == 0
                                    ? Container()
                                    : Container(
                                        //width: double.infinity,
                                        color: appStyle.screenBgColor,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () {
                                              showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (BuildContext
                                                          buildContext,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return SafeArea(
                                                      child: Builder(
                                                          builder: (context) {
                                                        return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Container(
                                                                    height: double.infinity,
                                                                    width: double.infinity,
                                                                    color: Colors.white,
                                                                    child: CameraScreenNew(
                                                                      controllerImageSelectState:
                                                                          controllerImageSelectState,
                                                                      resultList:
                                                                          (List<ImageListBean>
                                                                              clickedImageList) {
                                                                        if (widget.resultList !=
                                                                            null) {
                                                                          widget
                                                                              .resultList(clickedImageList);
                                                                        }
                                                                        print(
                                                                            "Image clicked");
                                                                        Navigator.pop(
                                                                            buildContext);
                                                                      },
                                                                    ))));
                                                      }),
                                                    );
                                                  },
                                                  barrierDismissible: true,
                                                  barrierLabel:
                                                      MaterialLocalizations.of(
                                                              context)
                                                          .modalBarrierDismissLabel,
                                                  barrierColor: null,
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 150));
                                            },
                                            child: CameraOptionImageWidget(),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Scaffold(
                    backgroundColor: Colors.white,
                    /*appBar: PreferredSize(
                  preferredSize: Size(100, 56),
                  child: Container(
                      color: Colors.green,
                      child: AppBarGallery(
                        title: "$appBarTitle",
                        backPress: () => _onBackPressed(),
                        okPress: donePress,
                        selectedItemCount: selectedCount,
                        controllerImageSelectState: controllerImageSelectState,
                      ))),*/
                    body: galleryView,
                  )));
  }

  Future<void> donePress() {
    print("Done Clicked");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectedPhotoGallery(
              controllerImageSelectState: controllerImageSelectState)),
    ).then((value) {
      setEmptyState();
      //Back to main screen
      if (value != null && value) {
        Navigator.pop(context, true);
      }
    });
    return null;
  }

  //Update Gallery title
  void updateAppBarTitle(int selectedCount) {
    // appBarTitle = selectedCount>0?"($selectedCount/${controllerImageSelectState.getTotalNumberOfImage}) Selected":"Gallery";
    String galleryTitle = "Gallery";
    switch (appSetting.fileTypeFilter) {
      case FileTypeFilter.IMAGE_ONLY:
        galleryTitle = "Photo Gallery";
        break;
      case FileTypeFilter.VIDEO_ONLY:
        galleryTitle = "Video Gallery";
        break;
      case FileTypeFilter.ALL:
        galleryTitle = "Gallery";
        break;
    }
    appBarTitle =
        selectedCount > 0 ? "$selectedCount Selected" : "$galleryTitle";
  }

  double fileSizeCalculator({File mFile}) {
    int bytes = mFile.lengthSync();
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb;
  }

  Future<void> fileClickedNew({ImageListBean listRowRawData, int index}) async {
    //Select multi image after long press
    if (controllerImageSelectState.getSelectionType ==
        ImageSelectionType.MULTI) {
      if (!listRowRawData.isSelected) {
        File mAssetEntityLocalStr = listRowRawData.dataFile;
        listRowRawData.imageFile = mAssetEntityLocalStr;
        //User allow to select max number of image selected
        if (controllerImageSelectState.getSelectedImageCounts <
            appSetting.maxFileAllowToSelect) {
          controllerImageSelectState.setSelectedImageList(listRowRawData, index,
              itemFile: mAssetEntityLocalStr);
          controllerImageSelectState.setSelectedImageCounts = 1;
          controllerImageSelectState.refreshDataOnUi();
          //Back to main screen
          var selectedList = controllerImageSelectState.getFinalImageList;
          selectedList = controllerImageSelectState.getSelectedImageList;
          try {
            widget.resultList(selectedList);
          } catch (e) {
            print(e);
          }
          //setEmptyState();
        }
      } else if (listRowRawData.isSelected &&
          controllerImageSelectState.selectedImageCounts > 0) {
        listRowRawData.imageFile = listRowRawData.dataFile;
        controllerImageSelectState.removeSelectedImage(listRowRawData, index);
        controllerImageSelectState.setSelectedImageCounts = -1;
        controllerImageSelectState.refreshDataOnUi();
        //Back to main screen
        var selectedList = controllerImageSelectState.getFinalImageList;
        selectedList = controllerImageSelectState.getSelectedImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
      }
    }
    //Select only single image
    else if (controllerImageSelectState.getSelectionType ==
        ImageSelectionType.SINGLE) {
      removeAllSelected();
      File mAssetEntityLocalStr = listRowRawData.dataFile;
      listRowRawData.imageFile = mAssetEntityLocalStr;
      controllerImageSelectState.setSelectedImageList(listRowRawData, index,
          itemFile: mAssetEntityLocalStr);
      controllerImageSelectState.setSelectedImageCounts = 1;
      controllerImageSelectState.refreshDataOnUi();

      //Back to main screen
      var selectedList = controllerImageSelectState.getFinalImageList;
      selectedList = controllerImageSelectState.getSelectedImageList;
      try {
        widget.resultList(selectedList);
      } catch (e) {
        print(e);
      }
    }
  }
}
