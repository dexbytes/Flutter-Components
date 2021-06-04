import 'dart:core';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_camera_gallery/src/state/notification_stream.dart';
import 'package:image_camera_gallery/src/utils/asset_thumbnail.dart';
import 'package:image_camera_gallery/src/src/custom_image_cropping.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:io';
import '../model/image_list_bean.dart';
import '../../photo_gallery_main.dart';
import '../state/imageSelectState.dart';
import '../utils/crop_image.dart';
import '../value/app_dimens.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/src/camera_video_screen.dart';
import 'package:image_camera_gallery/src/src/photo_gallery_new.dart';
import 'package:image_camera_gallery/src/value/app_dimens.dart';
import 'package:provider/provider.dart';
import '../state/imageSelectState.dart';
import '../state/simple_hidden_drawer_provider.dart';
import '../../photo_gallery_main.dart';

enum comeFromScreen { GALLERY, CAMERA }

class SelectedPhotoGalleryNew extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final comeFromScreen userComeFromScreen;
  final bool isShowAddMoreOption;
  SelectedPhotoGalleryNew(
      {Key key,
      this.controllerImageSelectState,
      this.isShowAddMoreOption = true,
      this.userComeFromScreen = comeFromScreen.GALLERY})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SelectedPhotoGalleryNew(
        /*controllerImageSelectState: this.controllerImageSelectState*/);
  }
}

class _SelectedPhotoGalleryNew extends State<SelectedPhotoGalleryNew> {
  int selectedItemIndex = 0;
  double bottomImageHeight = 50;
  double bottomImageListHeight = 60;
  double bottomImageListWidth = 0;
  Color appBgColor = Colors.black.withOpacity(0.2);
  Color bottomListBgColor = Colors.black.withOpacity(0.2);
  final CarouselController _controller = CarouselController();
  ImageSelectState controllerImageSelectState;
  _SelectedPhotoGalleryNew({this.controllerImageSelectState}) {
    try {
      _dataRefreshStream =
          DataRefreshStream.instance.notificationsStream.stream;
      _dataRefreshStream.listen((notification) {
        try {
          setState(() {});
        } catch (e) {
          // TODO
        }
        // TODO: Implement your logic here
      });
    } catch (e) {
      print(e);
    }
  }
  bool isAppBarCropShowing = true;
  Stream<dynamic> _dataRefreshStream;
  setEmptyState() {
    if (mounted) {
      setState(() {});
    }
  }

  updateListData(String item) {
    ImageListBean mImageListBean = new ImageListBean();
    mImageListBean.imageFile = new File(item);
    mImageListBean.isSelected = false;
    if (mounted) controllerImageSelectState.setAllImageList = mImageListBean;
    setEmptyState();
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
      print("List Data ${_imageSelectStateUpdated.getAllImageGroupList}");
      print("List Data >>>");
    }

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark) // Or Brightness.dark
          );
    }

    appBgColor = Colors.black.withOpacity(0.2);
    bottomListBgColor = Colors.black.withOpacity(0.2);
    bottomImageListWidth = _appDimens.widthFullScreen();

    //Back Press
    _onBackPressed() {
      if (widget.userComeFromScreen == comeFromScreen.CAMERA) {
        //Delete selected image in case come from camera
        controllerImageSelectState.removeSelectedImage(
            _imageSelectStateUpdated.selectedImageList[selectedItemIndex],
            selectedItemIndex);
        controllerImageSelectState.setSelectedImageCounts = -1;
      }
      Navigator.pop(context);
      return Future.value(true);
    }

    //Delete item app bar icon
    Widget deleteIcon = Padding(
        padding: _appDimens.marginPaddingHorizontal(horizontal: 15),
        child: PressDownUpAnimation(
          child: Container(
            child: (appSetting.imgDeleteIcon != null &&
                    appSetting.imgDeleteIcon.trim() != "")
                ? iconModules.iconImageModule(
                    imageUrl: appSetting.imgDeleteIcon)
                : Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
          ),
          onclick: () {
            controllerImageSelectState.removeSelectedImage(
                _imageSelectStateUpdated.selectedImageList[selectedItemIndex],
                selectedItemIndex);
            controllerImageSelectState.setSelectedImageCounts = -1;
            setEmptyState();
            if (controllerImageSelectState.getSelectedImageCounts <= 0) {
              Navigator.pop(context);
            }
          },
        ));

    //Crop item app bar icon
    Widget cropIcon = !isAppBarCropShowing
        ? Container()
        : PressDownUpAnimation(
            child: (appSetting.imgCropIcon != null &&
                    appSetting.imgCropIcon.trim() != "")
                ? iconModules.iconImageModule(imageUrl: appSetting.imgCropIcon)
                : Icon(
                    Icons.crop_rotate,
                    color: Colors.white,
                  ),
            onclick: () {
              ImageListBean mImageListBean =
                  _imageSelectStateUpdated.selectedImageList[selectedItemIndex];
              File imageFile = mImageListBean.imageFile;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => /*SimpleCropRoute()*/
                        CustomImageCropping(
                            title: "ok", imageListBean: mImageListBean)),
              );
              /*if (isAppBarCropShowing) {
                ImageListBean mImageListBean = _imageSelectStateUpdated
                    .selectedImageList[selectedItemIndex];
                File imageFile = mImageListBean.imageFile;
                cropImage
                    .cropImage(
                        imageFile: imageFile,
                        cropImageRatioStyle: cropImageRatio.square,
                        cropToolbarColor: appStyle.appBarColorBg,
                        cropToolbarWidgetColor: appStyle.appBarColorItems)
                    .then((File imageFileTemp) async {
                  if (imageFileTemp != null) {
                    mImageListBean.imageFile = imageFileTemp;
                    Uint8List value = await projectUtils.compressImageUint8List(
                        imageFileTemp,
                        minHeight: 1080,
                        minWidth: 1080,
                        quality: appSetting.imageCropQuality);
                    mImageListBean.imageResized = value;
                    controllerImageSelectState.updateCroppedSelectedImage(
                        mImageListBean, selectedItemIndex);
                    setEmptyState();
                  }
                });
              }*/
            },
          );

    // Add more image from gallery
    Widget addMoreImageIcon() {
      return Padding(
        padding: _appDimens.marginPaddingVertical(vertical: 0),
        child: PressDownUpAnimation(
          child: widget.userComeFromScreen == comeFromScreen.CAMERA
              ? Container()
              : !widget.isShowAddMoreOption
                  ? Container()
                  : ((appSetting.addMoreImgIcon != null &&
                          appSetting.addMoreImgIcon.trim() != "")
                      ? iconModules.iconImageModule(
                          imageUrl: appSetting.addMoreImgIcon)
                      : Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: bottomImageHeight,
                        )),
          onclick: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    // Done with selected Image
    Widget doneWithSelectedImage() {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: _appDimens.marginPaddingVertical(
              vertical:
                  widget.userComeFromScreen == comeFromScreen.CAMERA ? 10 : 0),
          child: InkWell(
            onTap: () {
              controllerImageSelectState.setFinalImageList(
                  controllerImageSelectState.selectedImageList);
              Navigator.pop(context, true);
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: PhotoGalleryAppColors().editTextBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text("Done"),
              ),
            ),
          ),
        ),
      );
    }

    //Custom App bar
    Widget appBar = Container(
        width: _appDimens.widthFullScreen(),
        child: BackArrowWithRightIcon(
            appBarBgColor: appBgColor,
            backArrowImage: null,
            title: "",
            statusBarHeight: _appDimens.statusBarHeight(),
            appBarRightIcons: [deleteIcon, cropIcon],
            leftIconSize: _appDimens.iconSquareCustom(value: 25),
            appBarBackIconColor: Colors.white,
            appBar: false,
            context: context,
            onLeftIconPressed: () => _onBackPressed()));

    //**************** Bottom image List **********************
    Widget bottomListSingleImage({ImageListBean value, bool isSelected}) =>
        new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: value.imageResized != null
                  ? Container(
                      height: bottomImageHeight,
                      width: bottomImageHeight,
                      decoration: new BoxDecoration(
                        color: isSelected ? const Color(0xff7c94b6) : null,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(isSelected ? 1 : 1),
                              BlendMode.dstATop),
                          image: MemoryImage(value.imageResized, scale: 1),
                        ),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.transparent,
                          width: isSelected ? 1 : 0,
                        ),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    )
                  : Container(
                      height: bottomImageHeight,
                      width: bottomImageHeight,
                      child: AssetThumbnail(
                          asset: value.iOSAssetEntity,
                          isSelected: isSelected,
                          withDecoration: false),
                    ),
            ),
          ],
        );
    Widget bottomListImageView(
        {ImageListBean listRowRawData, File fileData, int index = 0}) {
      bool isSelected = selectedItemIndex == index ? true : false;

      return /*(listRowRawData.imageResized != null || listRowRawData.iOSAssetEntity!=null)
          ?*/
          Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItemIndex = index;
                    });
                    _controller.animateToPage(selectedItemIndex);
                    /*if(!listRowRawData.isSelected && Provider.of<ImageSelectState>(context, listen: false).selectedImageCounts>0){
                          Provider.of<ImageSelectState>(context, listen: false).setSelectedImageList(listRowRawData,index);
                          Provider.of<ImageSelectState>(context, listen: false).setSelectedImageCounts = 1;
                          //setState(() {
                            //imageList = imageSelectState.getAllImageList;
                             // selectedCount = imageSelectState.getSelectedImageCounts;
                          //});
                        }
                        else if(listRowRawData.isSelected && Provider.of<ImageSelectState>(context, listen: false).selectedImageCounts>0){
                          Provider.of<ImageSelectState>(context, listen: false).removeSelectedImage(listRowRawData,index);
                          Provider.of<ImageSelectState>(context, listen: false).setSelectedImageCounts = -1;
                          //setState(() {
                            //imageList = imageSelectState.getAllImageList;
                           // selectedCount = imageSelectState.getSelectedImageCounts;
                          //});
                        }*/
                  },
                  child: bottomListSingleImage(
                      value: listRowRawData, isSelected: isSelected)),
            ),
          ],
        ),
      ) /*
          : Container()*/
          ;
    }

    //Selected image list
    Widget bottomListView() {
      return (_imageSelectStateUpdated.selectedImageList != null &&
              _imageSelectStateUpdated.selectedImageList.length > 0)
          ? Container(
              color: bottomListBgColor,
              width: bottomImageListWidth,
              padding: _appDimens.marginPaddingVerticalHorizontal(vertical: 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [addMoreImageIcon(), doneWithSelectedImage()],
                  ),
                  (_imageSelectStateUpdated.selectedImageList != null &&
                          _imageSelectStateUpdated.selectedImageList.length > 1)
                      ? Container(
                          height: bottomImageListHeight,
                          padding:
                              _appDimens.marginPaddingVertical(vertical: 4),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _imageSelectStateUpdated
                                  .selectedImageList.length,
                              itemBuilder: (context, index) {
                                File mFile = _imageSelectStateUpdated
                                    .selectedImageList[index].imageFile;
                                return bottomListImageView(
                                    fileData: mFile,
                                    index: index,
                                    listRowRawData: _imageSelectStateUpdated
                                        .selectedImageList[index]);
                              }),
                        )
                      : Container(),
                ],
              ),
            )
          : Container();
    }
    //************ End Bottom image view ********************

    ////////////////////////////////////// Slide View //////////////////////////////
    Widget slideViewSingleImage({value, bool isSelected}) => PhotoView(
          imageProvider: FileImage(value, scale: 1),
        );

    Widget slideViewSingleVideo({String videoPath, bool isSelected}) =>
        Container(
          child: videoPath != null
              ? VideoViewGallery(
                  videoLink: videoPath,
                )
              : Container(),
        );

    Widget slideImageView(
        {ImageListBean listRowRawData, File fileData, int index = 0}) {
      FileSystemEntity file = fileData;
      //if (file is File)
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: listRowRawData.imageFile == null
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: listRowRawData.fileType == FileTypeToFetch.IMAGE
                    ? slideViewSingleImage(
                        value: listRowRawData.imageFile,
                        isSelected: listRowRawData.isSelected)
                    : slideViewSingleVideo(
                        videoPath: listRowRawData.imageFile.path,
                        isSelected: listRowRawData.isSelected),
              ),
      );
    }

    //Selected image slide View
    Widget slideView() {
      return (_imageSelectStateUpdated.selectedImageList != null &&
              _imageSelectStateUpdated.selectedImageList.length > 0)
          ? Container(
              child: Container(
                  child: CarouselSlider.builder(
              itemCount: _imageSelectStateUpdated.selectedImageList.length,
              carouselController: _controller,
              options: CarouselOptions(
                  height: double.maxFinite,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  onPageChanged: (pageNumber, reason) {
                    setState(() {
                      selectedItemIndex = pageNumber;
                    });
                  }),
              itemBuilder: (ctx, index, reIndex) {
                ImageListBean mImageListBean =
                    _imageSelectStateUpdated.selectedImageList[index];
                if (mImageListBean.fileType == FileTypeToFetch.IMAGE) {
                  isAppBarCropShowing = true;
                } else {
                  isAppBarCropShowing = false;
                }
                return slideImageView(
                    fileData: mImageListBean.imageFile,
                    index: index,
                    listRowRawData: mImageListBean);
              },
            )))
          : Container();
    }
    //////////////////////////////////// End Slide View ////////////////////////

    Widget body() {
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: slideView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: bottomListView(),
          ),
          Positioned(top: _appDimens.statusBarHeight(), child: appBar),
        ],
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        //color: Colors.white,
        child: Material(
          color: Colors.black,
          child: SafeArea(bottom: true, child: body()),
        ),
      ),
    );
  }

  Future<void> donePress() {
    print("Done Clicked");
    return null;
  }

  void imageCount(int count) {
    //if(mounted)
    //Provider.of<ImageSelectState>(context, listen: false).setTotalNumberOfImage = count;
  }
}
