import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/avatar_image.dart';

class AvatarLeftWithData extends StatefulWidget {
  final String avatarPath;
  final int index;
  final Widget rightWidget;
  final double viewHeight;
  final Size avatarViewSize;
  final EdgeInsets padding;

  AvatarLeftWithData({
    @required this.avatarPath,
    @required this.index,
    this.rightWidget = const Text("data"),
    this.viewHeight = 100,
    this.avatarViewSize = const Size(60, 60),
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  });

  @override
  _AvatarLeftWithDataState createState() => _AvatarLeftWithDataState();
}

class _AvatarLeftWithDataState extends State<AvatarLeftWithData> {
  @override
  Widget build(BuildContext context) {
    // Avatar view widget
    Widget _buildAvatarView() {
      return SizedBox(
        height: widget.avatarViewSize.height,
        width: widget.avatarViewSize.width,
        child: AvatarImage(
          height: widget.avatarViewSize.height,
          width: widget.avatarViewSize.width,
          image: widget.avatarPath != null
              ? widget.avatarPath
              : "https://upload.wikimedia.org/wikipedia/commons/4/44/Zonal_Councils.svg",
          name: "NA",
        ),
      );
    }

    Widget _buildText() {
      return widget.rightWidget;
    }

    return Container(
      height: widget.viewHeight,
      padding: widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildAvatarView(),
          SizedBox(
            width: 10,
          ),
          _buildText()
        ],
      ),
    );
  }
}
