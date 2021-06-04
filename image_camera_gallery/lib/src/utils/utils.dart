import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../photo_gallery_main.dart';

class ProjectUtils {
  final List<String> extensions = <String>[
    "JPG",
    "PNG",
    "TIFF",
    "JPEG",
    "GIF",
    "WEBP",
    "PSD",
    "RAW",
    "BMP",
    "HEIF",
    "INDD",
    "JPEG 2000"
  ];
  final List<String> videoFileExtensions = <String>[
    "WEBM",
    "MPG",
    "MP2",
    "MPEG",
    "MPE",
    "MPV",
    "OGG",
    "MP4",
    "M4P",
    "M4V",
    "AVI",
    "WMV",
    "MOV",
    "QT",
    "FLV",
    "SWF",
    "AVCHD"
  ];

  final List<String> directories = <String>[
    "PICTURES",
    "DOCUMENTS",
    "WHATSAPP",
    "WHATSAPP IMAGES",
    "MESSANGER",
    "DOWNLOAD",
    "DOWNLOADS",
    // "SCREENSHOTS",
    "DCIM",
    "CAMERA",
    "OTHER ALBUMS",
    "IMAGES",
    "SKYPE",
    "Camera Roll",
    /*   (appSetting.fileTypeFilter == FileTypeFilter.VIDEO_ONLY||appSetting.fileTypeFilter == FileTypeFilter.ALL)?"Videos":"",
    (appSetting.fileTypeFilter == FileTypeFilter.VIDEO_ONLY||appSetting.fileTypeFilter == FileTypeFilter.ALL)?"Camera Roll":"",*/
    "Camera",
    "Photo",
    "Recents",
    "Videos",
    "Screen Recording",
    "Screen Recordings",
    // "Screenshots",
  ];

  final List<String> ignoreFileDirectories = <String>[
    "/cache",
    "/.",
    "_thum",
    "/thum",
  ];

  //Check if file is image file
  isFileAddToShow({String item}) {
    bool isFileAddToShow = false;
    try {
      //Check if file is hidden or not  if not than we will show file to user
      if (Platform.isAndroid) {
        if (!isHiddenFile(item: item) &&
            isDirectoryToShowInAndroid(item: item)) {
          //if (!isHiddenFile(item: item) ) {
          if (appSetting.fileTypeFilter == FileTypeFilter.IMAGE_ONLY) {
            isFileAddToShow = isImageFile(item: item);
          } else if (appSetting.fileTypeFilter == FileTypeFilter.VIDEO_ONLY) {
            isFileAddToShow = isVideoFile(item: item);
          } else if (appSetting.fileTypeFilter == FileTypeFilter.ALL) {
            isFileAddToShow =
                (isImageFile(item: item) || isVideoFile(item: item))
                    ? true
                    : false;
          }
        }
      } else if (Platform.isIOS) {
        if (!isHiddenFile(item: item)) {
          //if (!isHiddenFile(item: item) ) {
          if (appSetting.fileTypeFilter == FileTypeFilter.IMAGE_ONLY) {
            isFileAddToShow = isImageFile(item: item);
          } else if (appSetting.fileTypeFilter == FileTypeFilter.VIDEO_ONLY) {
            isFileAddToShow = isVideoFile(item: item);
          } else if (appSetting.fileTypeFilter == FileTypeFilter.ALL) {
            isFileAddToShow =
                (isImageFile(item: item) || isVideoFile(item: item))
                    ? true
                    : false;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return isFileAddToShow;
    // return item.endsWith(".jpg");
  }

  //Check if file is image file
  isImageFile({String item}) {
    bool isImageFile = false;
    try {
      isImageFile = extensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      print(e);
    }
    return isImageFile;
    // return item.endsWith(".jpg");
  }

  //Check if file is hidden
  isHiddenFile({String item}) {
    bool isHiddenFile = false;
    try {
      //Check if file is hidden or not  if not than we will show file to user and it return tru if file hidden
      //isHiddenFile = item.contains("/.");

      if (Platform.isIOS) {
        if (appSetting.fileTypeFilter != FileTypeFilter.VIDEO_ONLY) {
          var contain = ignoreFileDirectories.where((ignoreElement) =>
              item.toUpperCase().contains("${ignoreElement.toUpperCase()}"));
          if (contain.isNotEmpty) isHiddenFile = true;
        }
      } else {
        var contain = ignoreFileDirectories.where((ignoreElement) =>
            item.toUpperCase().contains("${ignoreElement.toUpperCase()}"));
        if (contain.isNotEmpty) isHiddenFile = true;
      }
      //isHiddenFile = videoFileExtensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      print(e);
    }
    return isHiddenFile;
    // return item.endsWith(".jpg");
  }

  //Check if file is hidden
  isDirectoryToShowInIos({String item}) {
    bool isDirectoryToShowInIos = false;
    try {
      //Check if file is hidden or not  if not than we will show file to user and it return tru if file hidden
      //isHiddenFile = item.contains("/.");

      var contain = directories.where((ignoreElement) =>
          (ignoreElement != null && ignoreElement.trim() != "")
              ? ignoreElement.toUpperCase().contains("${item.toUpperCase()}")
              : null);
      if (contain != null && contain.isNotEmpty) isDirectoryToShowInIos = true;
      //isHiddenFile = videoFileExtensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      print(e);
    }
    return isDirectoryToShowInIos;
    // return item.endsWith(".jpg");
  }

  //Check if file is hidden
  isDirectoryToShowInAndroid({String item}) {
    bool isDirectoryToShowInAndroid = false;
    try {
      //Check if file is hidden or not  if not than we will show file to user and it return tru if file hidden
      //isHiddenFile = item.contains("/.");
      try {
        if (Platform.isAndroid) {
          if (item.trim().split("/").last.contains(".")) {
            var folders = item.trim().split("/");
            item = folders[folders.length - 2];
          } else {
            item = item.trim().split("/").last;
          }
        }
      } catch (e) {
        print(e);
      }

      var contain = directories.where((ignoreElement) =>
          (ignoreElement != null && ignoreElement.trim() != "")
              ? ignoreElement.toUpperCase().contains("${item.toUpperCase()}")
              : null);
      if (contain != null && contain.isNotEmpty)
        isDirectoryToShowInAndroid = true;
      //isHiddenFile = videoFileExtensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      print(e);
    }
    return isDirectoryToShowInAndroid;
    // return item.endsWith(".jpg");
  }

  //Check if file is video file
  isVideoFile({String item}) {
    bool isVideoFile = false;
    try {
      isVideoFile =
          videoFileExtensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      print(e);
    }
    return isVideoFile;
    // return item.endsWith(".jpg");
  }

  Future<Image> loadThumb({File imgFile}) async {
    // read image
    List<int> thumbInts = await imgFile.readAsBytes();
    ByteBuffer buffer = Uint8List.fromList(thumbInts).buffer;
    ByteData byteData = new ByteData.view(buffer);
    Image _imageThumbView = new Image.memory(
      byteData.buffer.asUint8List(),
      fit: BoxFit.cover,
      gaplessPlayback: true,
      scale: 1.0,
      filterQuality: FilterQuality.low,
    );
    return _imageThumbView;
  }

// 1. compress file and get Uint8List
  Future<Uint8List> compressImageUint8List(File file,
      {int rotate = 0,
      int quality = 90,
      int minWidth = 50,
      int minHeight = 50}) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.path,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
      rotate: rotate,
    );
/*    print(file.lengthSync());
    print(result.length);*/
    return result;
  }

  Future<Uint8List> videoToImage(String filePath,
      {int rotate = 0,
      int quality = 90,
      int minWidth = 50,
      int minHeight = 50}) async {
    var result = await VideoThumbnail.thumbnailData(
      video: filePath,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: appSetting.listRowImageQuality,
    );
    return result;
  }
}

ProjectUtils projectUtils = ProjectUtils();
