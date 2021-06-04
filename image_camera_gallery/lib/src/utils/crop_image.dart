import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
enum cropImageRatio { original, square, ratio3x2, ratio5x3, ratio4x3, ratio5x4, ratio7x5, ratio16x9}
class CropImage{
  //**********  Image cropping start *********** */
  getCropType(cropImageRatio cropImageRatioTemp) {
    var cropTyp = CropAspectRatioPreset.original;
    switch(cropImageRatioTemp){
      case cropImageRatio.original:
        cropTyp = CropAspectRatioPreset.original;
        break;

        case cropImageRatio.square:
        cropTyp = CropAspectRatioPreset.square;
        break;

        case cropImageRatio.ratio3x2:
        cropTyp = CropAspectRatioPreset.ratio3x2;
        break;

        case cropImageRatio.ratio5x3:
        cropTyp = CropAspectRatioPreset.ratio5x3;
        break;

        case cropImageRatio.ratio4x3:
        cropTyp = CropAspectRatioPreset.ratio4x3;
        break;

        case cropImageRatio.ratio5x4:
        cropTyp = CropAspectRatioPreset.ratio5x4;
        break;

        case cropImageRatio.ratio7x5:
        cropTyp = CropAspectRatioPreset.ratio7x5;
        break;

        case cropImageRatio.ratio16x9:
        cropTyp = CropAspectRatioPreset.ratio16x9;
        break;
    }
    return cropTyp;
  }
  Future<File> cropImage({File imageFile,cropImageRatio cropImageRatioStyle, int compressQuality = 30,bool lockAspectRatio = true,String title = 'Cropper',Color cropToolbarColor=Colors.deepOrange,Color cropToolbarWidgetColor=Colors.white}) async {
    var cropTyp = getCropType(cropImageRatioStyle);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [cropTyp],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: cropToolbarColor,
            toolbarWidgetColor: cropToolbarWidgetColor,
            initAspectRatio:cropTyp,
            lockAspectRatio: lockAspectRatio), compressQuality: compressQuality,
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    if (croppedFile != null) {
     return imageFile = croppedFile;
    }
    else{
      return null;
    }
  }
}
CropImage cropImage = CropImage();