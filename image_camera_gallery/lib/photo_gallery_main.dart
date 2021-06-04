export 'package:image_camera_gallery/src/src/app_bar_gallery.dart';
export 'package:image_camera_gallery/src/src/video_view_gallery.dart';
export 'package:image_camera_gallery/src/src/app_bar_camera.dart';
export 'package:image_camera_gallery/src/src/selected_photo_gallery.dart';
export 'package:image_camera_gallery/src/src/photo_group_gallery.dart';
export 'package:image_camera_gallery/src/src/camera_screen.dart';
export 'package:image_camera_gallery/src/src/photo_gallery.dart';
export 'package:image_camera_gallery/src/src/app_bar_selected_photo_gallery.dart';
export 'package:image_camera_gallery/src/value/app_style.dart';
export 'package:image_camera_gallery/src/value/app_fonts.dart';
export 'package:image_camera_gallery/src/value/app_color.dart';
export 'package:image_camera_gallery/src/value/app_setting.dart';
export 'package:image_camera_gallery/src/utils/utils.dart';
export 'package:image_camera_gallery/src/utils/press_down_up_animation.dart';
export 'package:image_camera_gallery/src/src/image_camera_gallery.dart';
export 'package:image_camera_gallery/src/image_res/iconModules.dart';
export 'package:image_camera_gallery/src/model/image_list_bean.dart';

import 'package:image_camera_gallery/src/model/image_list_bean.dart';
export 'package:image_camera_gallery/src/model/image_group_list_bean.dart';

enum optionToOpen {GALLERY,CAMERA,CAMERA_VIDEO}
enum ImageSelectionType {SINGLE,MULTI}
enum FileTypeFilter {IMAGE_ONLY,VIDEO_ONLY,ALL}   // We have to add file type to fetch from directory
//typedef Function(List<ImageListBean>) SelectedFileList();
//typedef SelectedFileList = Function(List<ImageListBean>);
Function(List<ImageListBean>) selectedFileList;