import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../photo_gallery_main.dart';

typedef FileSelectCallback = Function({bool isSelected, int itemIndex});

class ClickedImageLayerView extends StatefulWidget {
  final ImageSelectState controllerImageSelectState;
  final FileSelectCallback fileSelectCallback;
  final ImageListBean listRowRawData;
  final int itemIndex;
  ClickedImageLayerView(this.fileSelectCallback,
      {this.listRowRawData,
      this.controllerImageSelectState,
      this.itemIndex = -1});
  @override
  _ClickedImageLayerViewState createState() => _ClickedImageLayerViewState();
}

class _ClickedImageLayerViewState extends State<ClickedImageLayerView> {
  bool isSelected = false;
  bool isSelectable = false;

  _ClickedImageLayerViewState() {
    /* if (isSelected == null) {
      isSelected = false;
    }*/
  }
  void initState() {
    return super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future<void> fileClicked() async {
    print(
        "### Selected image Count ### ${widget.controllerImageSelectState.getSelectedImageCounts}");
    //Check is multi image selection or single
    if ((widget.controllerImageSelectState.getSelectionType ==
        ImageSelectionType.MULTI)) {
      if (widget.controllerImageSelectState.getSelectedImageCounts <
          appSetting.maxFileAllowToSelect) {
        final mb = widget.listRowRawData.fileSize;
        if (mb > appSetting.maxMbFileSizeCanUpload) {
          Fluttertoast.showToast(
              msg: "${appSetting.maxFileSizSelectionMessage}");
          return;
        }
        setState(() {
          isSelectable = true;
        });
      } else {
        setState(() {
          isSelectable = false;
        });
        Fluttertoast.showToast(msg: "${appSetting.maxFileSelectionMessage}");
      }
    } else if ((widget.controllerImageSelectState.getSelectionType ==
        ImageSelectionType.SINGLE)) {
      if (widget.controllerImageSelectState.getSelectedImageCounts <
          appSetting.minFileAllowToSelect) {
        setState(() {
          isSelectable = true;
        });
      } else {
        setState(() {
          isSelectable = false;
        });
      }
    }

    //Click to select any image
    if (isSelectable && !isSelected) {
      setState(() {
        isSelected = true;
      });
    } else {
      setState(() {
        isSelected = false;
      });
    }
    //Call to callback
    if (widget.fileSelectCallback != null) {
      widget.fileSelectCallback(
          isSelected: isSelected, itemIndex: widget.itemIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      if (widget.listRowRawData.isSelected != null) {
        isSelected = widget.listRowRawData.isSelected;
      }
    }
    //Main view
    return Container(
        child: InkWell(
      onLongPress: () {
        fileClicked();
      },
      onTap: () {
        fileClicked();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: isSelected
                      ? Color(0xff7c94b6).withOpacity(0.3)
                      : Colors.transparent,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 0),
                    child: Stack(
                      children: [
                        isSelected
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
