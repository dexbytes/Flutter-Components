import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail(
      {Key key,
      @required this.asset,
      this.isSelected = false,
      this.borderRadius = 10,
      this.withDecoration = true})
      : super(key: key);

  final AssetEntity asset;
  final bool isSelected;
  final bool withDecoration;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null)
          return Card(
            child: Center(
                child: SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator())),
          );
        // If there's data, display it as an image
        return Stack(
          children: [
            withDecoration
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: isSelected ? const Color(0xff7c94b6) : null,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(isSelected ? 0.5 : 1),
                            BlendMode.dstATop),
                        image: MemoryImage(bytes, scale: 1),
                      ),
                    ),
                  )
                : Container(
                    decoration: new BoxDecoration(
                      color: isSelected ? const Color(0xff7c94b6) : null,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(isSelected ? 1 : 1),
                            BlendMode.dstATop),
                        image: MemoryImage(bytes, scale: 1),
                      ),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.transparent,
                        width: isSelected ? 1 : 0,
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  )

            // Display a Play icon if the asset is a video
            ,
            (asset.type == AssetType.video)
                ? Center(
                    child: Container(
                      color: Colors.blue,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
