import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/thumbnail_image.dart';

class ThumbnailLeftWithData extends StatefulWidget {
  final String avatarPath;
  final int index;
  final Widget rightWidget;
  final double viewHeight;
  final Size avatarViewSize;
  final EdgeInsets padding;

  ThumbnailLeftWithData({
    @required this.avatarPath,
    @required this.index,
    this.rightWidget = const Text("data"),
    this.viewHeight = 100,
    this.avatarViewSize = const Size(95, 95),
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  });

  @override
  _ThumbnailLeftWithDataState createState() => _ThumbnailLeftWithDataState();
}

class _ThumbnailLeftWithDataState extends State<ThumbnailLeftWithData> {
  @override
  Widget build(BuildContext context) {
    // Render avatar view
    Widget _buildAvatarView() {
      return SizedBox(
        height: widget.avatarViewSize.height,
        width: widget.avatarViewSize.width,
        child: ThumbnailImage(
          height: widget.avatarViewSize.height,
          width: widget.avatarViewSize.width,
          image: widget.avatarPath != null
              ? widget.avatarPath
              : "https://upload.wikimedia.org/wikipedia/commons/4/44/Zonal_Councils.svg",
          name: "NA",
        ),
      );
    }

    // Thumb nail text
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
