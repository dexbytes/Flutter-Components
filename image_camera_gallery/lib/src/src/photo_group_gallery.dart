import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_camera_gallery/src/image_gallery_widget/clicked_image_layer_view.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'package:image_camera_gallery/src/state/notification_stream.dart';
import 'package:image_camera_gallery/src/utils/asset_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../photo_gallery_main.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PhotoGroupGallery extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final Function(List<ImageListBean>) resultList;
  final ImageSelectionType selectionType;
  final backToMainApp;
  PhotoGroupGallery(
      {Key key,
      this.controllerImageSelectState,
      this.resultList,
      this.backToMainApp,
      this.selectionType = ImageSelectionType.SINGLE})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryState();
  }
}

class _PhotoGalleryState extends State<PhotoGroupGallery> {
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
  _PhotoGalleryState({this.controllerImageSelectState});
  int currentPageIndex = 0;
  List<ImageGroupListBean> allImageGridListData = new List();
  List<ImageGroupListBean> allImageGroupList = new List();
  bool isDataReady = false;
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

  //Update image index by index
  Future<void> _updateFileListByPageIndex({bool isScrollEnd = false}) async {
    //Check file count max limit to show user
    try {
      if (receivedFilesCount != appSetting.maxSearchedFile) {
        if (!isLoadingNewPage) {
          //Update current page index if page scrolled
          if (isScrollEnd) {
            currentPageIndex = currentPageIndex + 1;
          }
          List fileList;
          if (allImageGridListData != null && allImageGridListData.length > 0) {
            fileList = new List();
            int itemIndexTo = receivedFilesCount + appSetting.filePerPage;
            //Add file till end length of fetched file list
            if (itemIndexTo < allImageGridListData.length) {
              fileList.addAll(allImageGridListData.sublist(
                  receivedFilesCount, itemIndexTo));
            }
            //Add all remaining file from fetched file list
            else {
              fileList.addAll(allImageGridListData.sublist(
                  receivedFilesCount, allImageGridListData.length));
            }
          }
          if (fileList != null && fileList.length > 0) {
            isLoadingNewPage = true;
            try {
              int loopCount = 0;
              fileList.map((item) {
                loopCount++;
                if (loopCount == fileList.length) {
                  isLoadingNewPage = false;
                }
                //Check images total counts
                File fileData = File(item.groupImage);
                FileSystemEntity file = fileData;
                //print("File Name >> ${file.path}");
                if (file is Directory) {}
                if (file is File) {
                  if (projectUtils.isFileAddToShow(item: file.path)) {
                    filesAvailable = true;
                    //Add new image file in list
                    updateListData(item);
                    // setState(() {

                    // });
                  }
                }
                if (file is Link) {}
              }).toList(growable: false);
            } catch (e) {
              print(e);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //Selected files from directory
  Future<Directory> _getDeviceImages() async {
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
                RequestType typeTemp = RequestType.common;
                if (appSetting.fileTypeFilter == FileTypeFilter.IMAGE_ONLY) {
                  typeTemp = RequestType.image;
                } else if (appSetting.fileTypeFilter ==
                    FileTypeFilter.VIDEO_ONLY) {
                  typeTemp = RequestType.video;
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
                    int k = 0;
                    for (int i = 0; i < fileListIos.length; i++) {
                      try {
                        List<AssetEntity> pathFileList =
                            await fileListIos[k].assetList;
                        AssetEntity mAssetEntity = pathFileList[0];
                        updateListDataIos("filePath",
                            mAssetEntity: mAssetEntity);
                      } catch (e) {
                        print(e);
                      }
                    }
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

  updateListDataIos(String filePath, {AssetEntity mAssetEntity}) {
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
      FileTypeToFetch fileType = FileTypeToFetch.IMAGE,
      bool isSelected = false,
      AssetEntity iOSAssetEntity}) {
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
    return mImageListBean;
  }

  @override
  void initState() {
    super.initState();
    _getDeviceImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _updateFileListByPageIndex(isScrollEnd: true);
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

    updateAppBarTitle(selectedCount);

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
            ClickedImageLayerView(
              ({bool isSelected, int itemIndex}) {
                print("Selected ");
                fileClickedNew(listRowRawData: listRowRawData, index: index);
                selectedCount = _imageSelectStateUpdated.getSelectedImageCounts;
                print(
                    "Selected Done $selectedCount  ${controllerImageSelectState.getSelectedImageCounts}");
              },
              itemIndex: index,
              controllerImageSelectState: controllerImageSelectState,
            )
          ],
        ),
      );
    }

    Widget gridViewNew() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // A grid view with 3 items per row
          crossAxisCount: appSetting.imageGridCount,
        ),
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

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Material(
            color: Colors.black,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size(100, 56),
                  child: Container(
                      color: Colors.green,
                      child: AppBarGallery(
                        title: "$appBarTitle",
                        backPress: () => _onBackPressed(),
                        okPress: donePress,
                        selectedItemCount: selectedCount,
                        controllerImageSelectState: controllerImageSelectState,
                      ))),
              body: gridViewFutureBuilder(),
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
        File mAssetEntityLocalStr = await listRowRawData.iOSAssetEntity.file;
        final mb = fileSizeCalculator(mFile: mAssetEntityLocalStr);
        if (mb > appSetting.maxMbFileSizeCanUpload) {
          Fluttertoast.showToast(
              msg: "${appSetting.maxFileSizSelectionMessage}");
          return;
        }
        listRowRawData.imageFile = mAssetEntityLocalStr;
        //User allow to select max number of image selected
        if (controllerImageSelectState.getSelectedImageCounts <
            appSetting.maxFileAllowToSelect) {
          controllerImageSelectState.setSelectedImageList(listRowRawData, index,
              itemFile: mAssetEntityLocalStr);
          controllerImageSelectState.setSelectedImageCounts = 1;
          //setEmptyState();
        }
      } else if (listRowRawData.isSelected &&
          controllerImageSelectState.selectedImageCounts > 0) {
        File mAssetEntityLocalStr = await listRowRawData.iOSAssetEntity.file;
        listRowRawData.imageFile = mAssetEntityLocalStr;
        controllerImageSelectState.removeSelectedImage(listRowRawData, index);
        controllerImageSelectState.setSelectedImageCounts = -1;
      }
    }
    //Select only single image
    else if (controllerImageSelectState.getSelectionType ==
        ImageSelectionType.SINGLE) {
      removeAllSelected();
      File mAssetEntityLocalStr = await listRowRawData.iOSAssetEntity.file;
      listRowRawData.imageFile = mAssetEntityLocalStr;
      controllerImageSelectState.setSelectedImageList(listRowRawData, index,
          itemFile: mAssetEntityLocalStr);
      controllerImageSelectState.setSelectedImageCounts = 1;
    }
  }
}
