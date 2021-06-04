import 'dart:io';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../photo_gallery_main.dart';

class CustomImageCropping extends StatefulWidget {
  CustomImageCropping(
      {Key key,
      this.title,
      this.imageListBean,
      this.controllerImageSelectState,
      this.isShowAppBar = false,
      this.isShowAddMoreOption = false,
      this.userComeFromScreen,
      this.resultList})
      : super(key: key);
  final String title;
  final ImageListBean imageListBean;
  final ImageSelectState controllerImageSelectState;
  final bool isShowAppBar;
  final comeFromScreen userComeFromScreen;
  final bool isShowAddMoreOption;
  final Function(ImageListBean) resultList;
  @override
  _CustomImageCroppingState createState() =>
      _CustomImageCroppingState(imageListBean: this.imageListBean);
}

class _CustomImageCroppingState extends State<CustomImageCropping> {
  ui.Image image;
  bool isImageloaded = false;
  bool isShowAppBar = false;
  ImageListBean imageListBean;
  File imageFile;
  double deviceHeight;
  double deviceWidth;
  final _cropController = CropController();
  final _imageDataList = <Uint8List>[];

  var _loadingImage = false;
  var _currentImage = 0;
  set currentImage(int value) {
    setState(() {
      _currentImage = value;
    });
    _cropController.image = _imageDataList[_currentImage];
  }

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = true;
  Uint8List _croppedData;

  _CustomImageCroppingState({this.imageListBean}) {
    //_cropController.withCircleUi = true;
    //init();
  }

  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    //final ByteData data = await rootBundle.load('assets/image.jpeg');
    this.imageFile = imageListBean.imageFile;
    File file = imageFile;
    Uint8List bytes = file.readAsBytesSync();
    _imageDataList.add(bytes);
  }

  @override
  void didUpdateWidget(CustomImageCropping oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageListBean.imageFile == widget.imageListBean.imageFile)
      return;
    setState(() {
      this.imageFile = widget.imageListBean.imageFile;
      _croppedData = null;
      updateImage();
    });
  }

  Future<Null> updateImage() async {
    _imageDataList.clear();
    //final ByteData data = await rootBundle.load('assets/image.jpeg');
    File file = imageFile;
    Uint8List bytes = file.readAsBytesSync();
    _imageDataList.add(bytes);
  }

  _saveCropped() async {
    var byteData = _croppedData;
    var buffer = byteData.buffer.asUint8List();
    // var response = await get(imgUrl);
    var documentDirectory = await getApplicationDocumentsDirectory();
    print("${documentDirectory.path}");
    String pathTemp = imageFile.path;
    print("$pathTemp");
    String fileExtation =
        pathTemp.substring(pathTemp.lastIndexOf(".") + 1, pathTemp.length);
    pathTemp = pathTemp.substring(0, pathTemp.lastIndexOf("/"));
    print("$pathTemp");
    File file = File(join(
        pathTemp, '${DateTime.now().toUtc().toIso8601String()}.$fileExtation'));
    file.writeAsBytesSync(buffer);

    if (widget.resultList != null) {
      ImageListBean imageListBeanTemp = imageListBean;
      imageListBeanTemp.imageFile = file;
      imageListBeanTemp.dataFile = file;
      setState(() {
        _isCropping = false;
      });
      widget.resultList(imageListBeanTemp);
    } else {
      setState(() {
        _isCropping = false;
      });
    }
    print(file.path);
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: isShowAppBar
            ? AppBar(
                title: Text(widget.title),
              )
            : PreferredSize(child: Container(), preferredSize: Size(0, 0)),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Visibility(
              visible: !_loadingImage && !_isCropping,
              child: Column(
                children: [
                  /*if (_imageDataList.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildSumbnail(_imageDataList[0]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[0]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[0]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[0]),
                        ],
                      ),
                    ),*/
                  Expanded(
                    child: Visibility(
                      visible: _croppedData == null,
                      child: Stack(
                        children: [
                          if (_imageDataList.isNotEmpty)
                            Crop(
                              controller: _cropController,
                              image: _imageDataList[_currentImage],
                              onCropped: (croppedData) {
                                setState(() {
                                  _croppedData = croppedData;
                                  //_isCropping = false;
                                });
                                _saveCropped();
                              },
                              withCircleUi: _isCircleUi,
                              initialSize: 0.5,
                              maskColor: _isSumbnail ? Colors.white : null,
                              cornerDotBuilder: (size, index) => _isSumbnail
                                  ? const SizedBox.shrink()
                                  : const DotControl(),
                            ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => _isSumbnail = true),
                              onTapUp: (_) =>
                                  setState(() => _isSumbnail = false),
                              child: CircleAvatar(
                                backgroundColor: _isSumbnail
                                    ? Colors.blue.shade50
                                    : Colors.blue,
                                child: Center(
                                  child: Icon(Icons.crop_free_rounded),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 25,
                            child: Container(
                                child: PressDownUpAnimation(
                              child: CircleAvatar(
                                backgroundColor:
                                    /*_isSumbnail
                                    ? Colors.blue.shade50
                                    :*/
                                    Colors.blue,
                                child: Icon(
                                  Icons.crop_rotate,
                                  color: Colors.white,
                                ),
                              ),
                              onclick: () {
                                setState(() {
                                  _isCropping = true;
                                });
                                _isCircleUi
                                    ? _cropController.cropCircle()
                                    : _cropController.crop();
                              },
                            )

                                /*ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCropping = true;
                                    });
                                    _isCircleUi
                                        ? _cropController.cropCircle()
                                        : _cropController.crop();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text('Done'),
                                  ),
                                ),*/
                                ),
                          )
                        ],
                      ),
                      replacement: _croppedData == null
                          ? SizedBox.shrink()
                          : Stack(
                              children: [
                                Center(child: Image.memory(_croppedData)),
                                Positioned(
                                  right: 16,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _croppedData = null),
                                    child: CircleAvatar(
                                      backgroundColor: _croppedData == null
                                          ? Colors.blue.shade50
                                          : Colors.blue,
                                      child: Center(
                                        child:
                                            Icon(Icons.settings_backup_restore),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  if (_croppedData == null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.crop_7_5),
                                onPressed: () {
                                  _isCircleUi = false;
                                  _cropController.aspectRatio = 16 / 4;
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.crop_16_9),
                                onPressed: () {
                                  _isCircleUi = false;
                                  _cropController.aspectRatio = 16 / 9;
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.crop_5_4),
                                onPressed: () {
                                  _isCircleUi = false;
                                  _cropController.aspectRatio = 4 / 3;
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.crop_square),
                                onPressed: () {
                                  _isCircleUi = false;
                                  _cropController
                                    ..withCircleUi = false
                                    ..aspectRatio = 1;
                                },
                              ),
                              IconButton(
                                  icon: Icon(Icons.circle),
                                  onPressed: () {
                                    _isCircleUi = true;
                                    _cropController.withCircleUi = true;
                                  }),
                            ],
                          ),
                          const SizedBox(height: 16),*/
                          /*Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isCropping = true;
                                });
                                _isCircleUi
                                    ? _cropController.cropCircle()
                                    : _cropController.crop();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text('Done'),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),*/
                        ],
                      ),
                    ),
                ],
              ),
              replacement: CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
