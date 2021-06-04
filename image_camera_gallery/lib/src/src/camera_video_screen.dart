import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/src/timer_view.dart';
import 'package:image_camera_gallery/src/value/app_dimens.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../model/image_list_bean.dart';
import '../../photo_gallery_main.dart';
import '../state/imageSelectState.dart';

List<CameraDescription> cameras;

class CameraVideoScreen extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final Function(List<ImageListBean>) resultList;
  final ImageSelectionType selectionType;
  final backToMainApp;
  final controllerCameraFunction;
  CameraVideoScreen(
      {Key key,
      this.controllerImageSelectState,
      this.selectionType,
      this.backToMainApp,
      this.resultList,
      this.controllerCameraFunction})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CameraAppState(
        /*controllerImageSelectState:this.controllerImageSelectState*/);
    //return _VideoRecorderExampleState();
  }
}

class _CameraAppState extends State<CameraVideoScreen> {
  CameraController controller;
  XFile imageFile;
  XFile videoFile;
  bool isVideoRecording = false;
  ImageSelectState controllerImageSelectState;
  VoidCallback videoPlayerListener;
  VideoPlayerController videoController;
  _CameraAppState({this.controllerImageSelectState});

  ResolutionPreset mResolutionPreset = ResolutionPreset.medium;
  bool isBackCamera = true; //Front
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        //onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      setState(() {
        cameras = value;
      });
      controller = CameraController(
        cameras[0], mResolutionPreset,
        enableAudio: true,
        // imageFormatGroup: ImageFormatGroup.jpeg,
      );

      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        if (controller != null) {
          //widget.controllerCameraFunction(controller);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  setEmptyState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    PhotoGalleryAppDimens _appDimens = PhotoGalleryAppDimens();
    _appDimens.appDimensFind(context: context);
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
          }
        }
      } catch (e) {
        print(e);
      }
    }

    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    //Back Press
    _onBackPressed() {
      widget.backToMainApp(null, true);
      return Future.value(true);
    }

    Widget bottomView = (controller != null && controller.value != null)
        ? Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 80,
                    child: PressDownUpAnimation(
                        child: Container(),
                        onclick: () {
                          // if (controller != null) {
                          //   onSetFlashModeButtonPressed(FlashMode.off);
                          // }
                        }),
                  ),
                  Container(
                    width: 130,
                    child: !isVideoRecording
                        ? PressDownUpAnimation(
                            child: (appSetting.cameraTakePhotoIcon != null &&
                                    appSetting.cameraTakePhotoIcon.trim() != "")
                                ? iconModules.iconImageModule(
                                    imageUrl: appSetting.cameraTakePhotoIcon)
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 4, color: Colors.white)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            onclick: () {
                              if (controller != null) {
                                onVideoRecordButtonPressed();
                              }
                            })
                        : PressDownUpAnimation(
                            child: (appSetting.cameraTakePhotoIcon != null &&
                                    appSetting.cameraTakePhotoIcon.trim() != "")
                                ? iconModules.iconImageModule(
                                    imageUrl: appSetting.cameraTakePhotoIcon)
                                : /*Container(
                                    width: 60,
                                    height: 60,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(100.0),
                                        border: new Border.all(
                                          width: 2.0,
                                          color: Colors.white,
                                        )),
                                  )*/
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 3, color: Colors.white)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            onclick: () {
                              if (controller != null) {
                                onVideoRecordStopButtonPressed();
                              }
                            }),
                  ),
                  Container(
                    width: 80,
                    child: PressDownUpAnimation(
                      child: (appSetting.cameraTypeIcon != null &&
                              appSetting.cameraTypeIcon.trim() != "")
                          ? iconModules.iconImageModule(
                              imageUrl: appSetting.cameraTypeIcon)
                          : Icon(
                              Icons.flip_camera_ios,
                              color:
                                  controller?.value?.flashMode == FlashMode.off
                                      ? Colors.white
                                      : Colors.white,
                            ),
                      onclick: () {
                        if (controller != null && !isVideoRecording) {
                          _toggleCameraLens();
                        } else {}
                      },
                    ),
                  )
                ]),
          )
        : Container();

    Widget appbar = PreferredSize(
        preferredSize: Size(100, 56),
        child: AppBarCamera(
          appBarColor: Colors.transparent,
          title: "",
          appBarIconColor: Colors.white,
          backPress: () => _onBackPressed(),
          okPress: () {},
          selectedItemCount: 0,
        ));

    return AspectRatio(
        aspectRatio:
            _appDimens.widthFullScreen() / _appDimens.heightFullScreen()
        /*controllerCamera != null ? controllerCamera.value.aspectRatio : 1*/,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center, child: CameraPreview(controller)),
            /*_thumbnailWidget(),*/
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 150,
                  child: bottomView,
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  child: appbar,
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: TimerView(
                      isTimeStart: isVideoRecording,
                      stopVideoRecording: () {
                        if (controller != null) {
                          onVideoRecordStopButtonPressed();
                        }
                      }),
                ))
          ],
        ));
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    try {
      // await controller.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  //Take photo
  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<XFile> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      isVideoRecording = false;
      return controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onVideoRecordButtonPressed() {
    if (!controller.value.isRecordingVideo) {
      startVideoRecording().then((_) {
        if (mounted)
          setState(() {
            isVideoRecording = true;
          });
      });
    }
  }

  void onVideoRecordStopButtonPressed() {
    if (controller.value.isRecordingVideo) {
      stopVideoRecording().then((file) {
        if (mounted) {
          setState(() {
            isVideoRecording = false;
            if (file != null) {
              showInSnackBar('Video recorded to ${file.path}');
              videoFile = file;
              setSelectedPhoto(videoFile);
              // _startVideoPlayer();
            }
          });
        }
      });
    }
  }

  Future<void> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await controller.prepareForVideoRecording();
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  void _showCameraException(CameraException e) {
    //logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  //Set Photo as a selected and move to crop option
  Future<void> setSelectedPhoto(XFile xFile) async {
    try {
      if (xFile != null && xFile.path != null) {
        String filePath = xFile.path;
        ImageListBean mImageListBean = ImageListBean();
        File imageFile = File(filePath);
        mImageListBean.isSelected = true;
        /*Uint8List value = await projectUtils.compressImageUint8List(
            imageFile,minHeight:1920 ,minWidth: 1080,quality: appSetting.cameraImageQuality);*/
        Uint8List value = await projectUtils.videoToImage(filePath);
        mImageListBean.imageResized = value;
        mImageListBean.imageFile = imageFile;
        mImageListBean.fileType = FileTypeToFetch.VIDEO;
        controllerImageSelectState
            .addCameraImageAsSelectedImage(mImageListBean);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectedPhotoGallery(
                  controllerImageSelectState: controllerImageSelectState,
                  userComeFromScreen: comeFromScreen.CAMERA)),
        ).then((value) {
          setEmptyState();
          //Back to main screen
          if (value != null && value) {
            var selectedList = controllerImageSelectState.getFinalImageList;
            widget.backToMainApp(selectedList, value);
            //  Navigator.pop(context, true);
          }
        });
      } else {
        var selectedList = controllerImageSelectState.getFinalImageList;
        widget.backToMainApp(selectedList, true);
        // Navigator.pop(context, true);
      }
    } catch (e) {
      //var selectedList = controllerImageSelectState.getFinalImageList;
      widget.backToMainApp(null, true);
      // Navigator.pop(context, true);
      print(e);
    }
  }

  //Change Camera
  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = controller.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      _initCamera(newDescription);
    } else {
      print('Asked camera not available');
    }
  }

  // init camera
  Future<void> _initCamera(CameraDescription description) async {
    controller = CameraController(
      description,
      mResolutionPreset,
      enableAudio: true,
    );
    try {
      await controller.initialize();
      // to notify the widgets that camera has been initialized and now camera preview can be done
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
