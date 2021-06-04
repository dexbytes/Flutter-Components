import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/src/camera_video_screen.dart';
import 'package:image_camera_gallery/src/src/photo_gallery_new.dart';
import 'package:image_camera_gallery/src/value/app_dimens.dart';
import 'package:provider/provider.dart';
import '../state/imageSelectState.dart';
import '../../photo_gallery_main.dart';
import 'camera_screen_new.dart';

class ImageCameraGallery extends StatefulWidget {
  final optionToOpen openType;
  final FileTypeFilter fileTypeFilter; //You can search file type according this
  final ImageSelectionType selectionType;
  final Function(List<ImageListBean>) resultList;
  //App bar setting in normal mode
  final Color appBarColorBg;
  final Color appBarColorItems;
  final Color screenBgColor;
  final bool isShowPhotoCropView;

  //If multi image selected in gallery
  final Color appBarHighlightColorBg;
  final Color appBarHighlightColorItems;

  //Image quality setting
  final int cameraImageQuality;
  final int listRowImageQuality;
  final int imageCropQuality;
  final int maxFileAllowToSelect;
  final double maxMbFileSizeCanUpload;
  final double videoCaptureDurationInSeconds;

  final String maxFileSelectionMessage;

  //Image
  final String cameraTakePhotoIcon;
  final String cameraFlashIcon;
  final String cameraTypeIcon;
  final String imgCropIcon;
  final String imgDeleteIcon;
  final String addMoreImgIcon;

  final EdgeInsetsGeometry photoGridOutSidePadding;

  ImageCameraGallery(
      {Key key,
      this.openType = optionToOpen.CAMERA,
      this.fileTypeFilter = FileTypeFilter.ALL,
      this.selectionType = ImageSelectionType.SINGLE,
      @required this.resultList,
      this.appBarColorBg = const Color(0xFF231641),
      this.screenBgColor = const Color(0xFF2A272E),
      this.appBarColorItems = Colors.black,
      this.appBarHighlightColorBg = Colors.orange,
      this.cameraImageQuality = 95,
      this.imageCropQuality = 90,
      this.isShowPhotoCropView = false,
      this.photoGridOutSidePadding = const EdgeInsets.only(bottom: 15),
      this.listRowImageQuality = 95,
      this.maxFileAllowToSelect = 5,
      this.maxMbFileSizeCanUpload = 5,
      this.videoCaptureDurationInSeconds = 60,
      this.cameraTakePhotoIcon,
      this.cameraFlashIcon,
      this.cameraTypeIcon,
      this.imgCropIcon,
      this.imgDeleteIcon,
      this.addMoreImgIcon,
      this.maxFileSelectionMessage = "You can't select more than 5 file",
      this.appBarHighlightColorItems = Colors.white})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImageCameraGalleryState();
  }
}

class _ImageCameraGalleryState extends State<ImageCameraGallery> {
  ImageSelectState _imageSelectStateController;
  bool itInit = false;
  String appBarTitle = "Option";
  bool isReadyToShow = false;
  CameraController controllerCamera;
//App setting according another app
  void settings() {
    try {
      //App color setting
      appStyle.appBarHighlightColorBg = widget.appBarHighlightColorBg;
      appStyle.appBarHighlightColorItems = widget.appBarHighlightColorItems;
      appStyle.appBarColorBg = widget.appBarColorBg;
      appStyle.screenBgColor = widget.screenBgColor;
      appStyle.appBarColorItems = widget.appBarColorItems;
    } catch (e) {
      print(e);
    }
    /* try {
      if (mounted) {
        ImageSelectState _imageSelectStateUpdated =
            Provider.of<ImageSelectState>(context);
        if (_imageSelectStateUpdated != null) {
          _imageSelectStateUpdated.selectionType = widget.selectionType;
          //If user select camera
          if (widget.openType == optionToOpen.CAMERA) {
            _imageSelectStateUpdated.selectionType = ImageSelectionType.SINGLE;
          }
          _imageSelectStateController = _imageSelectStateUpdated;
        }
      }
    } catch (e) {
      print(e);
    }*/

    //Module icon setting
    try {
      appSetting.photoGridOutSidePadding = widget.photoGridOutSidePadding;
      appSetting.selectionType = widget.selectionType;
      appSetting.isShowPhotoCropView = widget.isShowPhotoCropView;
      appSetting.cameraImageQuality = widget.cameraImageQuality;
      appSetting.imageCropQuality = widget.imageCropQuality;
      appSetting.listRowImageQuality = widget.listRowImageQuality;
      appSetting.maxFileSelectionMessage = widget.maxFileSelectionMessage;
      appSetting.maxFileAllowToSelect = widget.maxFileAllowToSelect;
      appSetting.maxMbFileSizeCanUpload = widget.maxMbFileSizeCanUpload;
      appSetting.videoCaptureDurationInSeconds =
          widget.videoCaptureDurationInSeconds;
      appSetting.cameraTakePhotoIcon = widget.cameraTakePhotoIcon;
      appSetting.cameraFlashIcon = widget.cameraFlashIcon;
      appSetting.cameraTypeIcon = widget.cameraTypeIcon;
      appSetting.imgCropIcon = widget.imgCropIcon;
      appSetting.imgDeleteIcon = widget.imgDeleteIcon;
      appSetting.addMoreImgIcon = widget.addMoreImgIcon;
      appSetting.fileTypeFilter = widget.fileTypeFilter;
    } catch (e) {
      print(e);
    }
  }

//move to screen
  void moveToScreen() {
    //Set Add module according app requirement
    settings();
    if (widget.openType == optionToOpen.CAMERA) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraScreenNew(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        //if(value!=null && value) {
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
        // }
      });
    } else if (widget.openType == optionToOpen.CAMERA_VIDEO) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraVideoScreen(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        //if(value!=null && value) {
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
        // }
      });
    } else if (widget.openType == optionToOpen.GALLERY) {
      /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoGallery(controllerImageSelectState:_imageSelectStateController)),
    ).then((value){
      //Back to main screen
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        }
        catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        }
        catch (e) {
          print(e);
        }
        Navigator.pop(context);
    });*/
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhotoGalleryNew(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
      });*/
      PhotoGalleryNew(
        controllerImageSelectState: _imageSelectStateController,
        selectionType: widget.selectionType,
        resultList: widget.resultList,
        backToMainApp: backToMainApp,
      );
    }
  }

  //move to screen
  moveToScreen1() {
    PhotoGalleryAppDimens _appDimens = PhotoGalleryAppDimens();
    _appDimens.appDimensFind(context: context);

    //Set Add module according app requirement
    settings();
    if (widget.openType == optionToOpen.CAMERA) {
      return CameraScreenNew(
          controllerImageSelectState: _imageSelectStateController,
          selectionType: widget.selectionType,
          resultList: widget.resultList,
          backToMainApp: backToMainApp,
          controllerCameraFunction: (value) {
            setState(() {
              // controllerCamera = value;
            });
          });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraScreenNew(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        //if(value!=null && value) {
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
        // }
      });
    } else if (widget.openType == optionToOpen.CAMERA_VIDEO) {
      return AspectRatio(
          aspectRatio:
              _appDimens.widthFullScreen() / _appDimens.heightFullScreen()
          /*controllerCamera != null ? controllerCamera.value.aspectRatio : 1*/,
          child: CameraVideoScreen(
              controllerImageSelectState: _imageSelectStateController,
              selectionType: widget.selectionType,
              resultList: widget.resultList,
              backToMainApp: backToMainApp,
              controllerCameraFunction: (value) {
                // setState(() {
                controllerCamera = value;
                // });
              }));
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraVideoScreen(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        //if(value!=null && value) {
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
        // }
      });
    } else if (widget.openType == optionToOpen.GALLERY) {
      /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoGallery(controllerImageSelectState:_imageSelectStateController)),
    ).then((value){
      //Back to main screen
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        }
        catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        }
        catch (e) {
          print(e);
        }
        Navigator.pop(context);
    });*/
      return PhotoGalleryNew(
        controllerImageSelectState: _imageSelectStateController,
        selectionType: widget.selectionType,
        resultList: widget.resultList,
        backToMainApp: backToMainApp,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhotoGalleryNew(
                controllerImageSelectState: _imageSelectStateController)),
      ).then((value) {
        //Back to main screen
        var selectedList = _imageSelectStateController.getFinalImageList;
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //_imageSelectStateController = ImageSelectState();
    new Future.delayed(const Duration(microseconds: 1), () {
      setState(() {
        isReadyToShow = true;
      });
      //moveToScreen();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  setEmptyState() {
    if (mounted) {
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ImageSelectState>(
            create: (_) => ImageSelectState(),
          )
        ],
        child: MaterialApp(
            color: widget.openType == optionToOpen.GALLERY
                ? Colors.white
                : Colors.black,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: widget.openType == optionToOpen.GALLERY
                  ? Colors.white
                  : Colors.black,
              body: !isReadyToShow
                  ? Container(
                      margin: EdgeInsets.all(20),
                      child: Container(
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        )),
                      ),
                    )
                  : moveToScreen1(),
            )));
  }

  Future<void> backToMainApp(selectedList, bool value) {
    if (value != null && value) {
      if (selectedList != null && selectedList.length > 0) {
        try {
          widget.resultList(selectedList);
        } catch (e) {
          print(e);
        }
        try {
          // resetProviderValues();
          setEmptyState();
          print("$selectedList");
        } catch (e) {
          print(e);
        }
      }
      Navigator.pop(context, true);
    }

    return null;
  }

  Future<void> resetProviderValues() {
    _imageSelectStateController.removeAllSelectedImage = true;
    _imageSelectStateController.reSetData = true;
    return null;
  }
}
