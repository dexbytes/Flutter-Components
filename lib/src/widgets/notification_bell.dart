import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';

class NotificationBal extends StatelessWidget {
  final String iconData;
  final VoidCallback onTap;
  final int notificationCount;
  final double rightIconSize;
  final double rightIconBoxSize;
  final double countTextSize;
  final Color boxShapeCircleColor;
  final Color iconDataColor;
  const NotificationBal({
    Key key,
    this.onTap,
    this.iconData,
    this.rightIconSize,
    this.rightIconBoxSize,
    this.iconDataColor,
    this.notificationCount,this.countTextSize,this.boxShapeCircleColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
    AppColors _appColors = Provider.of<AppColors>(context);

    var rightIconSizeTemp =  rightIconBoxSize!=null?rightIconBoxSize:rightIconSize!=null?rightIconSize:18;

    Widget menuIcon =
    iconData!=null?(iconData.contains(".svg")?SvgPicture.asset(iconData,
        width: rightIconSize!=null?rightIconSize:_appDimens.iconSquareCustom(value: 18),
        height: rightIconSize!=null?rightIconSize:_appDimens.iconSquareCustom(value: 18),
        color: iconDataColor,
        fit: BoxFit.scaleDown)
            :
        Image(
          image: AssetImage(iconData),
          width: rightIconSize!=null?rightIconSize:_appDimens.iconSquareCustom(value: 18),
          height: rightIconSize!=null?rightIconSize:_appDimens.iconSquareCustom(value: 18),
          color: iconDataColor,
        )):Container(child: Icon(Icons.notifications,color: _appColors.iconColor,),);


    return InkWell(
      onTap: onTap,
      child: Container(
        width: rightIconSizeTemp,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                menuIcon
              ],
            ),
            notificationCount>0?Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(bottom: 0),
                child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: boxShapeCircleColor!=null?boxShapeCircleColor:/*Colors.red*/_appColors.iconColor[200]),
                  alignment: Alignment.center,
                  child: Container(margin: EdgeInsets.all(4),
                      child: Center(
                        child: Text('${notificationCount<=99?notificationCount:"99+"}',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: countTextSize!=null?countTextSize:12,
                    color: Colors.white/*,backgroundColor: Colors.red*/
                  )),
                      )),
                ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}