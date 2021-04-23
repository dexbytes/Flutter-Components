import 'package:flutter/material.dart';

class IconLeftAndRightTextWithText extends StatelessWidget {
  final String text;
  final int index;
  final TextStyle textStyle;
  final TextStyle rightTextStyle;
  final Widget iconLeftWidget;
  final String textRight;
  final double viewHeight;
  final Size iconViewSize;
  final EdgeInsets padding;
  const IconLeftAndRightTextWithText({
    @required this.text,
    @required this.index,
    this.iconLeftWidget = const Icon(
      Icons.mail,
      color: Colors.black,
    ),
    this.textRight = "",
    this.textStyle,
    this.rightTextStyle,
    this.viewHeight = 50,
    this.iconViewSize = const Size(40, 40),
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  }) /*: assert(iconWidget != null)*/;

  @override
  Widget build(BuildContext context) {
    Widget _buildIconLeftView() {
      return SizedBox(
        height: iconViewSize.height,
        width: iconViewSize.width,
        child: iconLeftWidget,
      );
    }

    Widget _buildText() {
      TextStyle textStyleTemp = this.textStyle != null
          ? this.textStyle
          : TextStyle(
              color: Colors.black,
            );
      return Text(
        "$text",
        style: textStyleTemp,
        maxLines: 1,
      );
    }

    Widget _buildRightText() {
      TextStyle textStyleTemp = this.rightTextStyle != null
          ? this.textStyle
          : TextStyle(
              color: Colors.grey,
            );
      return Text(
        "$textRight",
        style: textStyleTemp,
        maxLines: 1,
        textAlign: TextAlign.end,
      );
    }

    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIconLeftView(),
                SizedBox(
                  width: 10,
                ),
                _buildText()
              ]),
          _buildRightText()
        ],
      ),
    );
  }
}
