import 'package:flutter/material.dart';

class IconLeftWithText extends StatelessWidget {
  final String text;
  final int index;
  final TextStyle textStyle;
  final Widget iconWidget;
  final double viewHeight;
  final Size iconViewSize;
  final EdgeInsets padding;
  const IconLeftWithText({
    @required this.text,
    @required this.index,
    this.iconWidget = const Icon(
      Icons.mail,
      color: Colors.black,
    ),
    this.textStyle,
    this.viewHeight = 50,
    this.iconViewSize = const Size(40, 40),
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    Widget _buildIconView() {
      return SizedBox(
        height: iconViewSize.height,
        width: iconViewSize.width,
        child: iconWidget,
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

    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildIconView(),
          SizedBox(
            width: 10,
          ),
          _buildText()
        ],
      ),
    );
  }
}
