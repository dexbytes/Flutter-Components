import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../photo_gallery_main.dart';

class ImageListBean {
  bool isSelected = false;
  double fileSize = 0.0;
  Image thumbImage;
  FileTypeToFetch fileType = FileTypeToFetch.IMAGE;
  File imageFile; // This is also a all file
  File dataFile; //All type file
  Uint8List imageResized;
  AssetEntity iOSAssetEntity;
}
