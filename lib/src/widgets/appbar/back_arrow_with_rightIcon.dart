import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';

class BackArrowWithRightIcon extends StatelessWidget implements PreferredSizeWidget {
  final  String title;
  final  Color titleStyle;
  final  double profileSize;
  final  String backArrowImage;
  final  String notificationCount;
  final  double leftIconSize;
  final  double marginLeft;
  final  double marginRight;
  final  Color appBarBgColor;
  final  Color appBarBackIconColor;
  final  Function() onPressed;
  final  Function() onLeftIconPressed;
  final List<Widget> appBarRightIcons;
  final  bool appBar;
  final double statusBarHeight;

  BackArrowWithRightIcon(
  {Key key,
  this.statusBarHeight,
  this.title,
  this.titleStyle,
  this.profileSize,
  this.backArrowImage,
  this.notificationCount="0",
  this.leftIconSize,
  this.marginLeft=0,
  this.marginRight=0,
  this.appBarBgColor,
  this.appBarBackIconColor,
  this.onPressed,
  this.onLeftIconPressed,
  this.appBarRightIcons,this.appBar,@required context}): super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(profileSize!=null?profileSize:56.0);

  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
    AppStyle _appStyle = Provider.of<AppStyle>(context);
    AppColors _appColors = Provider.of<AppColors>(context);
//    AppFonts _appFonts = Provider.of<AppFonts>(context);
    _appDimens.appDimensFind(context: context);
//    double statusBarHeightLocal = statusBarHeight!=null?statusBarHeight:_appDimens.statusBarHeight();

    Widget leftImageIconPng(String imageUrl) {
      return imageUrl!=null ? new ImageIcon(new AssetImage(imageUrl),size: _appDimens.heightDynamic(value: 19.5),): Icon(Icons.arrow_back_ios);
    }
    Widget leftImageIconSvg(String imageUrl) {
      return Padding(child: SvgPicture.asset(backArrowImage,
        height:_appDimens.heightDynamic(value: 19.5),
        width: _appDimens.widthDynamic(value: 19.5),
        fit: BoxFit.fill,
      ),padding: EdgeInsets.only(left: 5,top: 5),);
    }

    return (appBar!=null&&appBar)?
    //App Bar we have to user Preferred Size when using app bar
    AppBar(
        backgroundColor: appBarBgColor!=null?appBarBgColor:_appColors.appBarBgColor,
        elevation: 0.0,
        //For card view
        flexibleSpace: Container(
          // Add box decoration
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.6, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Color(0xFFFFF),
                Color(0xFFFFF),
                Color(0xFFFFF),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        centerTitle: true,
        title: new Text(title!=null?title:"", style: titleStyle!=null?titleStyle:_appStyle.appBarT1Style(), textAlign: TextAlign.center),
        leading: backArrowImage==null?Container():IconButton(icon:(backArrowImage.contains('.png')?leftImageIconPng(backArrowImage):(backArrowImage.contains('.svg')?leftImageIconSvg(backArrowImage):leftImageIconPng("assets/images/back_arrow_appbar/Back1.png"))),
          onPressed: () => onLeftIconPressed(),
        ),
        actions:appBarRightIcons
    ):
    Container(
        color:appBarBgColor!=null?appBarBgColor:Colors.transparent,
        padding: _appDimens.marginPaddingHorizontal(horizontal: 10),
        child: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Left icon
              Align(
                child:  GestureDetector(
                  child: Container(
                    color: AppColors().appTransColor[700],
                    height:_appDimens.heightDynamic(
                      value: 35,
                    ) ,
                    // color: Colors.red,
                    padding: EdgeInsets.only(
                        left: marginLeft ??_appDimens.horizontalMarginPadding(
                          value: 20,
                        ), right: marginLeft ??_appDimens.horizontalMarginPadding(
                      value: 20,
                    )),
                    child: backArrowImage!=null?Image(
                      image:
                      AssetImage(backArrowImage!=null?backArrowImage:"assets/images/back_arrow_appbar/Back1.png"),
                      color: appBarBackIconColor!=null?appBarBackIconColor:
                      AppColors().appBarLetIconColor[200],
                      width: leftIconSize!=null?leftIconSize:
                      _appDimens.imageSquareAccordingScreen(value: 20),
                      height: leftIconSize!=null?leftIconSize:
                      _appDimens.imageSquareAccordingScreen(value: 20),
                    ):Icon(Icons.arrow_back_ios),
                  ),
                  onTap: () => onPressed(),
                ),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child:  Container(
                  child: Center(
                      child: Text(
                          title != null ? title : "",
                          style: titleStyle!=null?titleStyle:_appStyle.appBarT1Style())),
                  alignment: Alignment.center,
                ),
              )
            ],
          ),
        )
    );
  }
}
