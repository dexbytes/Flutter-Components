import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconModules {
  Widget iconImageModule(
      {@required String imageUrl, Size iconSize, Color imageColor}) {
    return imageUrl != null
        ? (iconSize != null
            ? (imageUrl.contains(".svg")
                ? SvgPicture.asset(
                    imageUrl,
                    height: iconSize.height,
                    width: iconSize.width,
                    color: imageColor,
                  )
                : Image(
                    image: AssetImage(imageUrl),
                    height: iconSize.height,
                    width: iconSize.height,
                    color: imageColor,
                  ))
            : (imageUrl.contains(".svg")
                ? SvgPicture.asset(
                    imageUrl,
                    color: imageColor,
                  )
                : Image(
                    image: AssetImage(imageUrl),
                    color: imageColor,
                  )))
        : Container();
  }
}

final IconModules iconModules = IconModules();
