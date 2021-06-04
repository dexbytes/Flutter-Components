import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/value/app_dimens.dart';
import 'package:provider/provider.dart';
import '../model/image_list_bean.dart';
import '../../photo_gallery_main.dart';
import '../state/imageSelectState.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final Function(List<ImageListBean>) resultList;
  final ImageSelectionType selectionType;
  final backToMainApp;
  final controllerCameraFunction;
  CameraScreen(
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
        controllerImageSelectState: this.controllerImageSelectState);
  }
}

class _CameraAppState extends State<CameraScreen> {
  CameraController controller;
  XFile imageFile;
  ImageSelectState controllerImageSelectState;

  _CameraAppState({this.controllerImageSelectState});

  bool isBackCamera = true; //Front
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      setState(() {
        cameras = value;
      });
      controller = CameraController(cameras[0], ResolutionPreset.max);
      widget.controllerCameraFunction(controller);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
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
      //Navigator.pop(context, true);
      widget.backToMainApp(null, true);
      return Future.value(true);
    }

    Widget bottomView = (controller != null && controller.value != null)
        ? Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                      child: (appSetting.cameraFlashIcon != null &&
                              appSetting.cameraFlashIcon.trim() != "")
                          ? iconModules.iconImageModule(
                              imageUrl: appSetting.cameraFlashIcon)
                          : Icon(
                              controller?.value?.flashMode == FlashMode.off
                                  ? Icons.flash_off
                                  : Icons.flash_on,
                              color:
                                  controller?.value?.flashMode == FlashMode.off
                                      ? Colors.orange
                                      : Colors.blue,
                            ),
                      onTap: () {
                        if (controller != null) {
                          onSetFlashModeButtonPressed(
                              controller?.value?.flashMode == FlashMode.off
                                  ? FlashMode.auto
                                  : FlashMode.off);
                          //onSetFlashModeButtonPressed(controller?.value?.flashMode );
                        }
                      }),
                  Container(
                    width: 100,
                    child: PressDownUpAnimation(
                        child: (appSetting.cameraTakePhotoIcon != null &&
                                appSetting.cameraTakePhotoIcon.trim() != "")
                            ? iconModules.iconImageModule(
                                imageUrl: appSetting.cameraTakePhotoIcon)
                            : Icon(
                                Icons.camera,
                                size: 60,
                                color: Colors.white,
                              ),
                        onclick: () {
                          if (controller != null) {
                            onTakePictureButtonPressed();
                          }
                        }),
                  ),
                  PressDownUpAnimation(
                    child: (appSetting.cameraTypeIcon != null &&
                            appSetting.cameraTypeIcon.trim() != "")
                        ? iconModules.iconImageModule(
                            imageUrl: appSetting.cameraTypeIcon)
                        : Icon(
                            Icons.flip_camera_ios,
                            color: controller?.value?.flashMode == FlashMode.off
                                ? Colors.white
                                : Colors.white,
                          ),
                    onclick: () {
                      if (controller != null) {
                        // isBackCamera =!isBackCamera;
                        //controller.value.c
                        _toggleCameraLens();
                      }
                    },
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
        // aspectRatio: controller.value.aspectRatio,
        aspectRatio:
            _appDimens.widthFullScreen() / _appDimens.heightFullScreen(),
        child: Material(
          color: Colors.black.withOpacity(0.2),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: CameraPreview(controller)),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    child: bottomView,
                  )),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    child: appbar,
                  ))
            ],
          ),
        ));
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        setSelectedPhoto(file);
        if (file != null) showInSnackBar('Picture saved to ${file.path}');
      }
    });
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    try {
      await controller.setFlashMode(mode);
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
        Uint8List value = await projectUtils.compressImageUint8List(imageFile,
            minHeight: 1920,
            minWidth: 1080,
            quality: appSetting.cameraImageQuality);
        mImageListBean.imageResized = value;
        mImageListBean.imageFile = imageFile;
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
            // Navigator.pop(context, true);
          }
        });
      } else {
        var selectedList = controllerImageSelectState.getFinalImageList;
        widget.backToMainApp(selectedList, true);
        // Navigator.pop(context, true);
      }
    } catch (e) {
      widget.backToMainApp(null, true);
      //Navigator.pop(context, true);
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
    controller =
        CameraController(description, ResolutionPreset.max, enableAudio: true);
    try {
      await controller.initialize();
      // to notify the widgets that camera has been initialized and now camera preview can be done
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
