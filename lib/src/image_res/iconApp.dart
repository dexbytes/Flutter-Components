import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconApps {
 // String backArrow = 'assets/images/navigate_back.svg';
 /// String luggageChecked = 'assets/images/checkbox_selected.svg';

  Widget iconImage(
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

  Widget splashImage(
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
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat /*,
    width: 170.0,*/
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

final IconApps iconApps = IconApps();
