import 'package:flutter/material.dart';

import '../../photo_gallery_main.dart';

enum FileTypeToFetch {
  IMAGE,
  VIDEO
} // We have to add file type to fetch from directory

class PhotoGalleryAppSetting {
  int cameraImageQuality = 90;
  bool isShowPhotoCropView = false;
  int imageCropQuality = 98;
  int listRowImageQuality = 95;
  int maxSearchedFile = 1000; // it is use
  int filePerPage = 100; // it is use
  int maxFileAllowToSelect = 5;
  int imageGridCount = 3;
  int minFileAllowToSelect = 1;
  double gridImageAllSideMargin = 2;
  double gridImageBottomSideMargin = 5;
  double videoCaptureDurationInSeconds = 60;
  double maxMbFileSizeCanUpload = 2;
  FileTypeFilter fileTypeFilter; //You can search file type according this
  //Image
  String cameraTakePhotoIcon;
  String cameraFlashIcon;
  String cameraTypeIcon;
  String imgCropIcon;
  String imgDeleteIcon;
  String imgVideoPlayIcon;
  String addMoreImgIcon;
  String maxFileSelectionMessage = "You can't select more than 5 file";
  String maxFileSizSelectionMessage = "You can't select grater than 2 mb file";
  ImageSelectionType selectionType;
  EdgeInsetsGeometry photoGridOutSidePadding;
}

PhotoGalleryAppSetting appSetting = PhotoGalleryAppSetting();
