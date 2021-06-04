import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'package:image_camera_gallery/src/state/notification_stream.dart';
import 'package:image_camera_gallery/src/utils/asset_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../photo_gallery_main.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PhotoGallery extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final String directoryPath;
  final String directoryName;
  final List filePathList;
  PhotoGallery(
      {Key key,
      this.controllerImageSelectState,
      this.directoryPath,
      this.filePathList,
      this.directoryName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryState(
        /*controllerImageSelectState: this.controllerImageSelectState,*/
        directoryPath: this.directoryPath,
        filePathList: this.filePathList,
        directoryName: this.directoryName);
  }
}

class _PhotoGalleryState extends State<PhotoGallery> {
  Directory directory;
  int selectedCount = 0;
  int receivedFilesCount = 0;
  List allFetchedFileList = new List();
  List filePathList;
  final String directoryName;
  String appBarTitle = "Selected";
  ImageSelectState controllerImageSelectState;
  bool isLoadingNewPage = false;
  String directoryPath;
  ScrollController _scrollController = new ScrollController();

  List<AssetEntity> assets = [];
  Stream<dynamic> _notificationsStream;
  _PhotoGalleryState(
      {this.controllerImageSelectState,
      this.directoryPath,
      this.filePathList,
      this.directoryName}) {
    if (filePathList != null && filePathList.length > 0) {
      _getDeviceImages();
    }
  }
  int currentPageIndex = 0;

  //Update state of object
  setEmptyState() {
    if (mounted) {
      //setState(() {});
    }
  }

  //File Details
  ImageListBean getImageListBean(
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

  updateListDataIos(String filePath, {AssetEntity mAssetEntity}) {
    try {
      receivedFilesCount = receivedFilesCount + 1;
      if (mounted) {
        controllerImageSelectState.setAllImageList = getImageListBean(
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

  //Update image grid view
  updateListData(String filePath) {
    try {
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
              if (mounted && value != null) {
                controllerImageSelectState.setAllImageList = getImageListBean(
                    isSelected: false,
                    compressedFilePath: value,
                    fileType: FileTypeToFetch.VIDEO,
                    originalFilePath: filePath);
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
                controllerImageSelectState.setAllImageList = getImageListBean(
                    isSelected: false,
                    compressedFilePath: value,
                    fileType: FileTypeToFetch.IMAGE,
                    originalFilePath: filePath);
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
          if (allFetchedFileList != null && allFetchedFileList.length > 0) {
            fileList = new List();
            int itemIndexTo = receivedFilesCount + appSetting.filePerPage;
            //Add file till end length of fetched file list
            if (itemIndexTo < allFetchedFileList.length) {
              fileList.addAll(
                  allFetchedFileList.sublist(receivedFilesCount, itemIndexTo));
            }
            //Add all remaining file from fetched file list
            else {
              fileList.addAll(allFetchedFileList.sublist(
                  receivedFilesCount, allFetchedFileList.length));
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
                File fileData = File(item);
                FileSystemEntity file = fileData;
                //print("File Name >> ${file.path}");
                if (file is Directory) {
                  print("<< Directory >> ${file.path}");
                }
                if (file is File) {
                  String pathOk = file.path;
                  print("<< File Path >> ${file.path}");
                  if (projectUtils.isFileAddToShow(item: file.path)) {
                    //Add new image file in list
                    updateListData(pathOk);
                  }
                }
                if (file is Link) {
                  print("<< Link >> ${file.path}");
                }
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
      getPermissionOfStorage().then((permissionGranted) async {
        if (permissionGranted) {
          if (filePathList != null && filePathList.length > 0) {
            resetProviderValues();
            if (Platform.isIOS || Platform.isAndroid) {
              int k = 0;
              for (int i = 0; i < filePathList.length; i++) {
                /*if(i != 0 && i<30){
                  continue;
                } */
                try {
                  AssetEntity mAssetEntity = filePathList[i];
                  /*File mAssetEntityLocalStr = await mAssetEntity.file;
                  String filePath = "${mAssetEntityLocalStr.path}";
                  setState(() {
                    allFetchedFileList.add("$filePath");
                    k++;
                  });*/
                  updateListDataIos("filePath", mAssetEntity: mAssetEntity);
                } catch (e) {
                  print(e);
                }
              }
            }
            //Android
            else {
              resetProviderValues();
              allFetchedFileList = filePathList;
              allFetchedFileList
                ..sort((a, b) {
                  File mFileA = File(a);
                  File mFileB = File(b);
                  DateTime dateA = mFileA.lastModifiedSync();
                  DateTime dateB = mFileB.lastModifiedSync();
                  return dateA.compareTo(dateB);
                });
              appSetting.maxSearchedFile = allFetchedFileList.length;
              _updateFileListByPageIndex();
            }
          } else {
            getLocalPath().then((value) {
              if (value != null) {
                directory = value;
                resetProviderValues();
                allFetchedFileList = directory
                    .listSync(recursive: true)
                    .map((item) => item.path)
                    .where((item) => projectUtils.isFileAddToShow(item: item))
                    .toList(growable: false);

                allFetchedFileList
                  ..sort((a, b) {
                    File mFileA = File(a);
                    File mFileB = File(b);
                    DateTime dateA = mFileA.lastModifiedSync();
                    DateTime dateB = mFileB.lastModifiedSync();
                    return dateA.compareTo(dateB);
                  });
                appSetting.maxSearchedFile = allFetchedFileList.length;
                _updateFileListByPageIndex();
              }
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  //Get directory path
  Future<Directory> getLocalPath() async {
    Directory directory;
    if (widget.directoryPath != null && widget.directoryPath.trim() != "") {
      directory = new Directory("${widget.directoryPath}");
    } else {
      if (Platform.isAndroid) {
        try {
          directory = await getExternalStorageDirectory();
          if (directory != null) {
            String pathTemp = directory.path;
            if (pathTemp != null && pathTemp.trim() != "") {
              pathTemp = pathTemp.substring(0, pathTemp.lastIndexOf("/0") + 2);
              directory = new Directory("$pathTemp");
            }
          }
        } catch (e) {
          print(e);
        }
      } else if (Platform.isIOS) {
        {
          directory = await getApplicationDocumentsDirectory();
        }
      }
    }
    return directory;
  }

  //Remove all selected files
  removeAllSelected() {
    controllerImageSelectState.removeAllSelectedImage = true;
    controllerImageSelectState.deselectAllGalleryImage = true;
    controllerImageSelectState.setSelectedImageCounts = 0;
  }

  @override
  void initState() {
    super.initState();
    // if (filePathList == null || filePathList.length <= 0) {
    //   _getDeviceImages();
    // }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("Ended of grid view >>> ");
        _updateFileListByPageIndex(isScrollEnd: true);
        // Bottom poistion
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
    }
    //Back Press
    _onBackPressed() {
      if (selectedCount > 0 && mounted) {
        removeAllSelected();
        setEmptyState();
      } else {
        Navigator.pop(context, false);
        //print("BackPress Clicked");
      }
      return Future.value(true);
    }

    // ImageSelectState _imageSelectStateUpdated = controllerImageSelectState;
    selectedCount = _imageSelectStateUpdated.getSelectedImageCounts;

    updateAppBarTitle(selectedCount);

    Widget singleImage({value, bool isSelected}) => new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AssetThumbnail(asset: value, isSelected: isSelected),
            ),
          ],
        );

    Widget imageViewFile({ImageListBean listRowRawData, int index = 0}) {
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
                    fileClicked(listRowRawData: listRowRawData, index: index);
                  },
                  onLongPress: () {
                    fileClicked(listRowRawData: listRowRawData, index: index);
                  },
                  child: singleImage(
                      value: listRowRawData.iOSAssetEntity,
                      isSelected: listRowRawData.isSelected)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 0),
                child: Stack(
                  children: [
                    listRowRawData.isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget gridView() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // A grid view with 3 items per row
          crossAxisCount: 4,
        ),
        itemCount: _imageSelectStateUpdated.getAllImageList.length,
        itemBuilder: (_, index) {
          return imageViewFile(
              index: index,
              listRowRawData: _imageSelectStateUpdated.getAllImageList[index]);
          //AssetThumbnail(asset: filePathList[index]);
        },
      );
    }

    Future<List<ImageListBean>> getListData() async {
      return _imageSelectStateUpdated.getAllImageList;
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
                    ))),
            body: gridView(),
          )),
    );
  }

  Future<void> donePress() {
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

  void imageCount(int count) {
    //if(mounted)
    //controllerImageSelectState.setTotalNumberOfImage = count;
  }
  //Update Gallery title
  void updateAppBarTitle(int selectedCount) {
    appBarTitle = selectedCount > 0 ? "$selectedCount Selected" : "Gallery";
    if (appSetting.selectionType == ImageSelectionType.SINGLE) {
      appBarTitle = "Gallery";
    }
    if (directoryPath != null &&
        directoryPath.trim() != "" &&
        directoryPath.contains('/')) {
      String title = directoryName != null
          ? directoryName
          : directoryPath.substring(
              directoryPath.lastIndexOf('/') + 1, directoryPath.length);
      appBarTitle = selectedCount > 0 ? "$selectedCount Selected" : "$title";
    }
    // appBarTitle = selectedCount>0?"($selectedCount/${controllerImageSelectState.getTotalNumberOfImage}) Selected":"Gallery";
  }

  double fileSizeCalculator({File mFile}) {
    int bytes = mFile.lengthSync();
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb;
  }

  Future<void> fileClicked({ImageListBean listRowRawData, int index}) async {
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
        } else {
          Fluttertoast.showToast(msg: "${appSetting.maxFileSelectionMessage}");
        }
      } else if (listRowRawData.isSelected &&
          controllerImageSelectState.selectedImageCounts > 0) {
        File mAssetEntityLocalStr = await listRowRawData.iOSAssetEntity.file;
        listRowRawData.imageFile = mAssetEntityLocalStr;
        controllerImageSelectState.removeSelectedImage(listRowRawData, index);
        controllerImageSelectState.setSelectedImageCounts = -1;
        //setEmptyState();
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
      setEmptyState();
    }
  }

  Future<void> resetProviderValues() {
    controllerImageSelectState.removeAllSelectedImage = true;
    controllerImageSelectState.removeAllGalleryImage = true;
    controllerImageSelectState.reSetData = true;
    return null;
  }
}
