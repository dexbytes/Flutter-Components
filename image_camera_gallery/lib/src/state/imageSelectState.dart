import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/state/notification_stream.dart';
import '../../photo_gallery_main.dart';
import '../model/image_list_bean.dart';
import 'simple_hidden_drawer_provider.dart';

class ImageSelectState with ChangeNotifier {
  int totalNumberOfImage = 0;
  int selectedImageCounts = 0;
  ImageSelectionType selectionType = ImageSelectionType.SINGLE;
  List<ImageListBean> allImageList = new List();
  List<ImageGroupListBean> allImageGroupList = new List();
  //Selected image list
  List<ImageListBean> selectedImageList = new List();
  List<ImageListBean> finalImageList = new List();

  ImageSelectionType get getSelectionType => selectionType;
  set setSelectionType(ImageSelectionType value) {
    selectionType = value;
    notifyListeners();
  }

  int get getTotalNumberOfImage => totalNumberOfImage;
  set setTotalNumberOfImage(int value) {
    totalNumberOfImage = totalNumberOfImage + value;
    notifyListeners();
  }

  set reSetAllImageListData(bool value) {
    if (allImageList != null) {
      allImageList.clear();
    }
  }

  set reSetData(bool value) {
    totalNumberOfImage = 0;
    selectedImageCounts = 0;
    /* if(allImageList!=null){
     allImageList.clear();
   }*/

    if (selectedImageList != null) {
      selectedImageList.clear();
    }
    if (finalImageList != null) {
      finalImageList.clear();
    }
    notifyListeners();
  }

  int get getSelectedImageCounts => selectedImageCounts;
  set setSelectedImageCounts(int value) {
    if (value < 0 && selectedImageCounts > 0) {
      selectedImageCounts = selectedImageCounts + value;
    } else {
      selectedImageCounts = selectedImageCounts + value;
    }

    //notifyListeners();
  }

  //Final Selected list
  List<ImageListBean> get getFinalImageList => finalImageList;
  setFinalImageList(List<ImageListBean> value) {
    finalImageList = new List();
    //Update selected status in image list
    if (finalImageList != null && value != null) {
      finalImageList.addAll(value);
    }
    notifyListeners();
  }

  //Selected image list
  List<ImageListBean> get getSelectedImageList => selectedImageList;
  setSelectedImageList(ImageListBean value, int index, {File itemFile}) {
    //Update selected status in image list
    if (allImageList != null && allImageList.length > 0) {
      // var item = allImageList.firstWhere((x) => x.imageFile.path == value.imageFile.path, orElse: () => null);
      var item = allImageList[index];
      if (item != null) {
        value.isSelected = true;
        allImageList[index] = (value);
      }
    }

    //Add image is selected image list
    if (itemFile != null) {
      var item = selectedImageList.firstWhere(
          (x) => x.imageFile != null && (x.imageFile.path == itemFile.path),
          orElse: () => null);
      if (item == null) {
        selectedImageList.add(value);
      }
    } else {
      /* var item = selectedImageList.firstWhere((x) => x.imageFile.path == itemFile.path, orElse: () => null);
      if(item==null) {*/
      selectedImageList.add(value);
      //}
    }
    //NotificationStream.instance.itemClicked(allImageList);
    //notifyListeners();
  }

  //Remove image from list
  removeSelectedImage(ImageListBean value, int index) {
    if (selectedImageList != null && selectedImageList.length > 0) {
      var item = selectedImageList.firstWhere(
          (x) =>
              x.imageFile != null && (x.imageFile.path == value.imageFile.path),
          orElse: () => null);
      if (item != null) {
        selectedImageList.remove(value);
        if (selectedImageCounts > 0) {
          //  setSelectedImageCounts = -1;
//          selectedImageCounts = selectedImageCounts-1;
        }
      }

      item = allImageList.firstWhere(
          (x) =>
              x.imageFile != null && (x.imageFile.path == value.imageFile.path),
          orElse: () => null);
      if (item != null) {
        int indexTemp = allImageList.indexOf(item);
        value.isSelected = false;
        allImageList[indexTemp] = (value);
      }
    }
    // notifyListeners();
  }

  //Update Cropped SelectedImage
  updateCroppedSelectedImage(ImageListBean value, int index) {
    if (selectedImageList != null &&
        selectedImageList.length > 0 &&
        value != null &&
        index != null) {
      selectedImageList[index] = value;
    }
    notifyListeners();
  }

  //Add Camera Image As Selected Image
  addCameraImageAsSelectedImage(ImageListBean value) {
    if (selectedImageList != null && value != null) {
      selectedImageList.add(value);
    }
    notifyListeners();
  }

  //Remove image from list
  set removeAllSelectedImage(bool isRemoved) {
    if (selectedImageList != null && selectedImageList.length > 0) {
      allImageList.map((element) {
        element.isSelected = false;
        return element;
      }).toList();
      selectedImageList.clear();
      selectedImageCounts = 0;
    }
    notifyListeners();
  }

  set removeAllGalleryImage(bool isRemoved) {
    allImageList.clear();
    notifyListeners();
  }

  set deselectAllGalleryImage(bool isRemoved) {
    allImageList.map((e) => e.isSelected == true ? false : false).toList();

    // allImageList.clear();
    notifyListeners();
  }

  //All image list
  List<ImageListBean> get getAllImageList => allImageList;
  set setAllImageList(ImageListBean value) {
    allImageList.add(value);
    totalNumberOfImage = totalNumberOfImage + 1;
    notifyListeners();
  }

  //All image list
  List<ImageGroupListBean> get getAllImageGroupList => allImageGroupList;
  set setAllImageGroupList(ImageGroupListBean value) {
    allImageGroupList.add(value);
    notifyListeners();
  }

  static ImageSelectState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyProvider>().controller;
  }

  //Trigger for update any ui
  void refreshDataOnUi() {
    DataRefreshStream.instance.refreshDataOnUi("refresh");
  }
}
