import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_animation_files_link.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key key,
      this.leading,
      this.title,
      this.actions,
      this.scaffoldKey,
      this.icon,
      this.onActionPressed,
      this.textController,
      this.isBackButton = false,
      this.isCrossButton = false,
      this.submitButtonText,
      this.isSubmitDisable = true,
      this.isbootomLine = true,
      this.onSearchChanged
      })
      : super(key: key);

  final List<Widget> actions;
  final Size appBarHeight = Size.fromHeight(56.0);
  final int icon;
  final bool isBackButton;
  final bool isbootomLine;
  final bool isCrossButton;
  final bool isSubmitDisable;
  final Widget leading;
  final Function onActionPressed;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String submitButtonText;
  final TextEditingController textController;
  final Widget title;
  final ValueChanged<String> onSearchChanged;

  @override
  Size get preferredSize => appBarHeight;



  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
//    AppStyle _appStyle = Provider.of<AppStyle>(context);
//    AppColors _appColors = Provider.of<AppColors>(context);
//    AppFonts _appFonts = Provider.of<AppFonts>(context);
    _appDimens.appDimensFind(context: context);

    Widget _icon(IconData icon, {Color color}) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Theme.of(context).backgroundColor,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
            ]),
        child: Icon(
          icon,
          color: color!=null?color:Provider.of<AppColors>(context).iconColor,
        ),
      ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
    }

    return Container(
      padding: Provider.of<AppDimens>(context).marginPaddingVerticalHorizontal(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }
}
