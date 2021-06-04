import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../photo_gallery_main.dart';

class ImageGroupListBean {
  bool isSelected = false;
  Image thumbImage;
  FileTypeToFetch fileType = FileTypeToFetch.IMAGE;
  File parentFile;
  String groupImage;
  String groupName;
  Uint8List imageResized;

  List<dynamic> childFilePath;
}