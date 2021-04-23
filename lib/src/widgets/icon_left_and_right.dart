import 'package:flutter/material.dart';

class IconLeftAndRight extends StatelessWidget {
  final String text;
  final int index;
  final TextStyle textStyle;
  final Widget iconLeftWidget;
  final Widget iconRightWidget;
  final double viewHeight;
  final Size iconViewSize;
  final Size iconRightViewSize;
  final EdgeInsets padding;
  const IconLeftAndRight({
    @required this.text,
    @required this.index,
    this.iconLeftWidget = const Icon(
      Icons.mail,
      color: Colors.black,
    ),
    this.iconRightWidget = const Icon(
      Icons.mail,
      color: Colors.black,
    ),
    this.textStyle,
    this.viewHeight = 50,
    this.iconViewSize = const Size(40, 40),
    this.iconRightViewSize = const Size(40, 40),
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

    Widget _buildIconRightView() {
      return SizedBox(
        height: iconRightViewSize.height,
        width: iconRightViewSize.width,
        child: iconRightWidget,
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
          _buildIconRightView()
        ],
      ),
    );
  }
}
