import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/photo_gallery_main.dart';
import 'package:video_player/video_player.dart';

class TimerView extends StatefulWidget {
  final bool isTimeStart;
  final stopVideoRecording;
  TimerView({Key key, @required this.isTimeStart, this.stopVideoRecording})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimerViewState(isTimeStart: isTimeStart);
  }
}

class _TimerViewState extends State<TimerView> {
  bool isTimeStart;
  Timer _timer;
  int seconds = 0;
  int totalSecond = 0;
  int minutes = 0;
  int hours = 0;
  String timerTimerStr = "00:00:00";

  _TimerViewState({this.isTimeStart = false}) {
    if (this.isTimeStart != null && this.isTimeStart) {
      startTimer();
    }
  }

  @override
  void didUpdateWidget(TimerView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isTimeStart) {
      startTimer();
    } else if (!widget.isTimeStart) {
      stopTimer();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (mounted) {
        setState(
          () {
            if (seconds < 0) {
              timer.cancel();
            } else {
              seconds = seconds + 1;
              totalSecond = totalSecond + 1;
              if (seconds > 59) {
                minutes += 1;
                seconds = 0;
                if (minutes > 59) {
                  hours += 1;
                  minutes = 0;
                }
              }
              String hoursTemp = hours.toString().padLeft(2, '0');
              String minutesTemp = minutes.toString().padLeft(2, '0');
              String secondsTemp = seconds.toString().padLeft(2, '0');
              timerTimerStr = "$hoursTemp:$minutesTemp:$secondsTemp";
              //Stop video recording on max limit time
              if (totalSecond >= appSetting.videoCaptureDurationInSeconds) {
                stopTimer();
                try {
                  widget.stopVideoRecording();
                } catch (e) {
                  print(e);
                }
              }
            }
          },
        );
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      setState(() {
        seconds = 0;
        minutes = 0;
        hours = 0;
      });
      _timer.cancel();
    }
    timerTimerStr = "$hours:$minutes:$seconds";
  }

  Future<dynamic> timerValue() {
    startTimer();
    return Future.value();
  }

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

    timerView() {
      return Container(
              // height: _appDimens.heightFullScreen()/3,
              // color: Colors.black,
              child: Text(
        timerTimerStr,
        style: appStyle.videoRecordingTimerStyle(),
      )) /* FutureBuilder(
        future: timerValue(),
        builder: (context, snapshot) {
          String timeStr = "00:00:00";
          if (snapshot.data != null) {
            timeStr = snapshot.data;
          }
          return Container(
              // height: _appDimens.heightFullScreen()/3,
              color: Colors.black,
              child: Text(timeStr));
        },
      )*/
          ;
    }

    // TODO: implement build

    return timerView();
  }
}
