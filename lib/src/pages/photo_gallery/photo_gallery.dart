import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';
import 'package:image_camera_gallery/photo_gallery_main.dart';

class PhotoGalleryPage extends StatefulWidget {
  PhotoGalleryPage({Key key}) : super(key: key);
  @override
  _PhotoGalleryPageState createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHidPassword = true;
  bool isShowGalleryView = false;
  bool isHidPasswordConform = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: CardView(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          isAndroid: ConstantC.isAndroidPlatform,
          cardType: CardType.FULL_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: Column(
            children: [
              Text(
                "Gallery Photo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              ButtonSolid(
                btnShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  setState(() {
                    isShowGalleryView = !isShowGalleryView;
                  });
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageCameraGallery(
                              openType: optionToOpen.GALLERY,
                              fileTypeFilter: FileTypeFilter.IMAGE_ONLY,
                              appBarColorBg: Colors.blueGrey,
                              appBarHighlightColorBg: Colors.orange,
                              appBarHighlightColorItems: Colors.white,
                              appBarColorItems: Colors.green,
                              selectionType: ImageSelectionType.MULTI,
                              maxFileAllowToSelect: 5,
                              resultList: (List<ImageListBean> value) {
                                if (value != null && value.length > 0) {
                                  //_showSelectedFiles(fileList: value);
                                }
                              },
                            )),
                  );*/
                },
                isAndroid: ConstantC.isAndroidPlatform,
                buttonExpandedType: ButtonExpandedType.BLOCK_WIDTH,
                buttonSize: ButtonSize.LARGE_SIZE,
                title: " Take Photo ",
                height: 50,
              ),
              SizedBox(
                height: 5,
              ),
              !isShowGalleryView
                  ? Container()
                  : Container(
                      height: 500,
                      child: ImageCameraGallery(
                        photoGridOutSidePadding: EdgeInsets.only(bottom: 0),
                        isShowPhotoCropView: true,
                        openType: optionToOpen.GALLERY,
                        fileTypeFilter: FileTypeFilter.ALL,
                        //appBarColorBg: Colors.blueGrey,
                        appBarHighlightColorBg: Colors.orange,
                        appBarHighlightColorItems: Colors.white,
                        appBarColorItems: Colors.green,
                        selectionType: ImageSelectionType.SINGLE,
                        maxFileAllowToSelect: 5,
                        resultList: (List<ImageListBean> value) {
                          if (value != null && value.length > 0) {
                            print("Photo Count ${value.length}");
                            //_showSelectedFiles(fileList: value);
                          }
                        },
                      ),
                    )
            ],
          ),
        ),
      );
    }

    return _centerView();
  }
}
