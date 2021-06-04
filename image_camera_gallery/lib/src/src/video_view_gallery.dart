import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/*class VideoViewGallery extends StatefulWidget {
  final String videoLink;
  final bool isNetworkVideoLink;
  VideoViewGallery({Key key,@required this.videoLink,this.isNetworkVideoLink = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoViewGalleryState(videoLink:videoLink,isNetworkVideoLink:isNetworkVideoLink);
  }
}*/
/*  class _VideoViewGalleryState extends State<VideoViewGallery> {
    VideoPlayerController _controllerVideo;
    Future<void> _initializeVideoPlayerFuture;
    String videoLink;
    bool isNetworkVideoLink;
    _VideoViewGalleryState({this.videoLink,this.isNetworkVideoLink = false});

    @override
    void initState() {
      super.initState();
    }

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      _controllerVideo.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    PhotoGalleryAppDimens _appDimens = PhotoGalleryAppDimens();
    _appDimens.appDimensFind(context: context);
    PhotoGalleryAppColors _appColors = PhotoGalleryAppColors();

    if(_controllerVideo==null && mounted){
      _controllerVideo =  isNetworkVideoLink?VideoPlayerController.network(videoLink):VideoPlayerController.file(File(videoLink));
      _initializeVideoPlayerFuture = _controllerVideo.initialize();
    }
    //Delete item app bar icon
    Widget playIcon = Padding(padding: _appDimens.marginPaddingHorizontal(horizontal: 15), child:PressDownUpAnimation(child:Container(
      child: (appSetting.imgVideoPlayIcon!=null && appSetting.imgVideoPlayIcon.trim()!="")?iconModules.iconImageModule(imageUrl: appSetting.imgVideoPlayIcon):
      Container(padding: EdgeInsets.symmetric(vertical:15,horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          //border: Border.all(color: _appColors.textNormalColor[600], width: 2,),
          color:Colors.black.withOpacity(0.2),
        ),
        child: Icon(
          (!_controllerVideo.value.isPlaying)?Icons.play_arrow_rounded:Icons.pause,
          color: Colors.white,
        ),
      ),
    ),onclick: (){
      if(_controllerVideo.value.isPlaying){
        _controllerVideo.pause();
      }
      else{
        _controllerVideo.initialize();
        _controllerVideo.play();
      }
    },));


    videoPlayer(){
      return  FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _controllerVideo.value.initialized
                ?
            GestureDetector(
              onTap: (){
              },
              child:  Container(
                 // height: _appDimens.heightFullScreen()/3,
                  color: _appColors.black,
                  child:Stack(
                    children: <Widget>[
                      Center(
                        child:VideoPlayer(_controllerVideo),)
                    ],
                  )),
            )
                : Container();
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: Container());
          }
        },
      );
    }
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          videoPlayer(),
          Center(child: playIcon,)
        ],
      ),
    );
  }

  }*/

class VideoViewGallery extends StatefulWidget {
  final String videoLink;
  final bool isNetworkVideoLink;
  VideoViewGallery(
      {Key key, @required this.videoLink, this.isNetworkVideoLink = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoViewGalleryState(
        videoLink: videoLink, isNetworkVideoLink: this.isNetworkVideoLink);
  }
}

class _VideoViewGalleryState extends State<VideoViewGallery> {
  VideoPlayerController _controllerVideo;
  Future<void> _initializeVideoPlayerFuture;
  String videoLink;
  bool isNetworkVideoLink;

  bool hidePauseButton = false;
  _VideoViewGalleryState({this.videoLink, this.isNetworkVideoLink = false});

  @override
  void initState() {
    if (_controllerVideo == null && mounted) {
      _controllerVideo = isNetworkVideoLink
          ? VideoPlayerController.network(videoLink)
          : VideoPlayerController.file(File(videoLink));
      _initializeVideoPlayerFuture = _controllerVideo.initialize();
    }
    // Use the controller to loop the video.
    _controllerVideo.setLooping(false);
    _controllerVideo.addListener(() {
      //custom Listner
      if (!_controllerVideo.value.isPlaying &&
          _controllerVideo.value.position == _controllerVideo.value.duration) {
        setState(() {
          videoPlaying = false;
        });
      }
      if (!hidePauseButton && _controllerVideo.value.isPlaying) {
        Future.delayed(Duration(seconds: 3)).then((value) {
          setState(() {
            hidePauseButton = true;
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerVideo.dispose();
    super.dispose();
  }

  bool videoPlaying = false;

  @override
  Widget build(BuildContext context) {
    /*   AppDimens _appDimens = Provider.of<AppDimens>(context);
    _appDimens.appDimensFind(context: context);
    AppColors _appColors = Provider.of<AppColors>(context);*/

    //Delete item app bar icon
    Widget pauseIcon = Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              //border: Border.all(color: _appColors.textNormalColor[600], width: 2,),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
        ));

    //Delete item app bar icon
    Widget playIcon2 = Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ));

    playPauseVideo() {
      if (_controllerVideo.value.isPlaying) {
        _controllerVideo.pause();
        setState(() {
          videoPlaying = false;
          // hidePauseButton = false;
        });
      } else {
        if (_controllerVideo.value.position ==
            _controllerVideo.value.duration) {
          _controllerVideo.initialize().then((value) {
            _controllerVideo.play();
            setState(() {
              videoPlaying = true;
              hidePauseButton = false;
            });
          });
        } else {
          _controllerVideo.play();
          setState(() {
            videoPlaying = true;
            // hidePauseButton = false;
          });
        }
      }
    }

    videoPlayer() {
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _controllerVideo.value.isInitialized
                ? Container(
                    // height: _appDimens.heightFullScreen()/3,
                    color: Colors.black,
                    child: IntrinsicHeight(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: AspectRatio(
                                aspectRatio: _controllerVideo.value.aspectRatio,
                                child: Center(
                                  child: VideoPlayer(_controllerVideo),
                                )),
                          ),
                          (videoPlaying)
                              ? GestureDetector(
                                  onTap: () {
                                    playPauseVideo();
                                    setState(() {
                                      hidePauseButton = false;
                                    });
                                  },
                                  child: hidePauseButton
                                      ? Center(
                                          child: Container(
                                          height: double.maxFinite,
                                          color: Colors.transparent,
                                          width: double.maxFinite,
                                        ))
                                      : Center(
                                          child: pauseIcon,
                                        ))
                              : Container(),
                          (!videoPlaying)
                              ? GestureDetector(
                                  onTap: () {
                                    playPauseVideo();
                                  },
                                  child: Center(
                                    child: playIcon2,
                                  ))
                              : Container()
                        ],
                      ),
                    ))
                : Container();
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: Container());
          }
        },
      );
    }
    // TODO: implement build

    return videoPlayer();
  }
}
