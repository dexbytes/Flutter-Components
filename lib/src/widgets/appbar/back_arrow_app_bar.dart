import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';
class BackArrowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final  String title;
  final  Color titleStyle;
  final  double profileSize;
  final  String backArrowImage;
  final  String rightIcon;
  final  String notificationCount;
  final  double rightIconSize;
  final  double leftIconSize;
  final  double marginLeft;
  final  double marginRight;
  final  Color appBarBgColor;
  final  Color appBarBackIconColor;
  final  Function() onPressed;
  final  Function() onNotificationPressed;
  final  bool appBar;
  final Size statusBarHeight;
  BackArrowAppBar(
      {Key key,
        this.statusBarHeight = const Size.fromHeight(56.0),
        this.title,
        this.titleStyle,
        this.profileSize,
        this.backArrowImage,
        this.rightIcon,
        this.notificationCount,
        this.rightIconSize,
        this.leftIconSize,
        this.marginLeft,
        this.marginRight,
        this.appBarBgColor,
        this.appBarBackIconColor,
        this.onPressed,
        this.onNotificationPressed,this.appBar})
      : super(key: key);

  @override
  Size get preferredSize => statusBarHeight;

  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
    AppStyle _appStyle = Provider.of<AppStyle>(context);
    AppColors _appColors = Provider.of<AppColors>(context);
    _appDimens.appDimensFind(context: context);

    AppBar mAppBar = AppBar(
      backgroundColor: appBarBgColor!=null?appBarBgColor:Colors.transparent,
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
           // stops: [0.1, 0.6, 0.9],
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
      title: new Text(title!=null?title:"",
          style: titleStyle!=null?titleStyle:_appStyle.appBarT1Style(),
          maxLines: 1,
          textAlign: TextAlign.center),
      // leading: IconButton(icon:new Icon(Icons.arrow_back, size: screenSize.height / 20,color: _appColors.lightBlack,),
      leading: IconButton(
        icon: backArrowImage!=null?new ImageIcon(
          new AssetImage(backArrowImage),
          color: appBarBackIconColor!=null?appBarBackIconColor:
          _appColors.appBarLetIconColor[200],
          size: leftIconSize!=null?leftIconSize:0,
        ):Icon(Icons.arrow_back_ios),
        onPressed: () => onPressed(),
      ),
      actions: <Widget>[

      ],
    );
    Widget mAppBar1 = Container(
        color:appBarBgColor!=null?appBarBgColor:Colors.transparent,
        padding: EdgeInsets.only(
          top: _appDimens.verticalMarginPadding(
            value: 50 - statusBarHeight.height,
          ),
        ),
        child: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Left icon
              Align(
                child:  GestureDetector(
                  child: Container(
                    color: _appColors.appTransColor[700],
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
                      AssetImage(backArrowImage),
                      color: appBarBackIconColor!=null?appBarBackIconColor:
                      _appColors.appBarLetIconColor[200],
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

                  //margin: EdgeInsets.only(left: 70),
                  child: Center(
                      child: Text(
                          title != null ? title : "",
                          style: titleStyle!=null?titleStyle:_appStyle.appBarT1Style() )),
                  alignment: Alignment.center,
                ),
              )],
          ),
        )
    );
    return (appBar!=null&&appBar)?mAppBar1:mAppBar;
  }
}
