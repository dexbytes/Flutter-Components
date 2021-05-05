import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black54,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(top: 50, left: 10),
      child: ResizableWidget(
        child: Container(),
      ),
    );
  }
}

class ResizableWidget extends StatefulWidget {
  ResizableWidget({this.child});
  final Widget child;
  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 30.0;

class _ResizableWidgetState extends State<ResizableWidget> {
  double heightOfResizableBox = 0;
  double widthOfResizableBox = 0;
  double maxDragWidth = 0;
  double maxDragHeight = 0;
  Size manipulatingWidgetSize = Size(30, 30);
  Size resizableBoxSiz/*=
      Size(165, 465)*/
      ; // it should less than heightMain and widthMain
  double top = 0;
  double bottom = 0;
  double left = 0;

  int xAxisMultiPliedBy = 5;
  int yAxisMultiPliedBy = 5;
  int verticalMarkPoints = 10;
  int horizontalMarkPoints = 10;

  //It will return to main class
  double xAxisSelectedValue = 0;
  double yAxisSelectedValue = 0;

  double heightMain = 200;
  double widthMain = 300;

  double gridLineWith = 0.3;

  Size selectedValue = Size(0, 0);

  _ResizableWidgetState() {
    heightOfResizableBox =
        resizableBoxHeightCalculate(); //heightMain-manipulatingWidgetSize.height;
    maxDragHeight = heightMain - (manipulatingWidgetSize.height / 2);
    //heightOfResizableBox = (heightOfResizableBox - (manipulatingWidgetSize.height+5));

    //Calculate resizable view width from main width
    widthOfResizableBox = resizableBoxWithCalculate();
    //Calculate resizable view width from main width
    maxDragWidth = widthMain - (manipulatingWidgetSize.width / 2);
    print("ok");
  }

  double resizableBoxWithCalculate() {
    double width = (widthMain - manipulatingWidgetSize.width) / 3;
    if (resizableBoxSiz != null &&
        (resizableBoxSiz.width - manipulatingWidgetSize.width) < widthMain) {
      width = resizableBoxSiz.width;
    }
    return width;
  }

  double resizableBoxHeightCalculate() {
    double height = (heightMain - manipulatingWidgetSize.height) / 3;
    if (resizableBoxSiz != null &&
        (resizableBoxSiz.height - manipulatingWidgetSize.height) < heightMain) {
      height = resizableBoxSiz.height;
    }
    return height;
  }

  double getHorizontalSpaceInLine() {
    double horizontalSpaceInLine =
        (maxDragWidth - (gridLineWith * horizontalMarkPoints)) /
            horizontalMarkPoints;
    return horizontalSpaceInLine;
  }

  double getVerticalSpaceInLine() {
    double verticalSpaceInLine =
        (maxDragHeight - (gridLineWith * verticalMarkPoints)) /
            verticalMarkPoints;
    return verticalSpaceInLine;
  }

  void onDrag(double dx, double dy) {
    var newHeight = heightOfResizableBox + dy;
    var newWidth = widthOfResizableBox + dx;

    setState(() {
      heightOfResizableBox = newHeight > 0 ? newHeight : 0;
      widthOfResizableBox = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget lineGrid() {
      double verticalSpaceInLine = 0;
      double horizontalSpaceInLine = 0;

      verticalSpaceInLine = getVerticalSpaceInLine();

      horizontalSpaceInLine = getHorizontalSpaceInLine();

      double rightMargin = (manipulatingWidgetSize.width / 2);

      return Container(
        color: Colors.grey.withOpacity(0.2),
        margin: EdgeInsets.only(
            right: rightMargin, top: (manipulatingWidgetSize.height / 2)),
        child: Stack(
          children: [
            //Horizontal line for vertical marking
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  verticalMarkPoints,
                  (i) => Container(
                    height: gridLineWith,
                    color: Colors.red,
                    margin: EdgeInsets.only(bottom: verticalSpaceInLine),
                  ),
                )),

            //Vertical marking for horizontal marking
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  horizontalMarkPoints,
                  (i) => Container(
                    width: gridLineWith,
                    color: Colors.red,
                    margin: EdgeInsets.only(left: horizontalSpaceInLine),
                  ),
                ))
          ],
        ),
      );
    }

    return Container(
      height: heightMain,
      width: widthMain,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Align(
            child: lineGrid(),
            alignment: Alignment.bottomLeft,
          ),
          Positioned(
            bottom: bottom,
            left: left,
            child: Container(
              height: heightOfResizableBox,
              width: widthOfResizableBox,
              color: Colors.green[100],
              child: widget.child,
            ),
          ),
          // top left
          /* Positioned(
            top: top - ballDiameter / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;
                var newHeight = heightOfResizableBox - 2 * mid;
                var newWidth = widthOfResizableBox - 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                  top = top + mid;
                  left = left + mid;
                });
              },
            ),
          ),*/
          // top middle
          /*Positioned(
            top: top - ballDiameter / 2,
            left: left + widthOfResizableBox / 2 - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newHeight = heightOfResizableBox - dy;
                setState(() {
                  heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                  top = top + dy;
                });
              },
            ),
          ),*/

          // top right old
          /*Positioned(
            top: top - ballDiameter / 2,
            left: left + widthOfResizableBox - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + (dy * -1)) / 2;
                var newHeight = heightOfResizableBox + 2 * mid;
                var newWidth = widthOfResizableBox + 2 * mid;
                setState(() {
                  heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),*/

          // top right
          Positioned(
            bottom: bottom + heightOfResizableBox - ballDiameter / 2,
            left: left + widthOfResizableBox - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newHeight = heightOfResizableBox - dy;
                double newWidth = widthOfResizableBox + dx;

                setState(() {
                  if (maxDragHeight > newHeight) {
                    heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                    double lineWidth = getVerticalSpaceInLine();
                    double verticalMarkPointsValue =
                        heightOfResizableBox / lineWidth;
                    print("Y value verticalMarkPointsValue");

                    verticalMarkPointsValue =
                        verticalMarkPointsValue.toPrecision(1);
                    if (verticalMarkPointsValue > verticalMarkPoints) {
                      verticalMarkPointsValue =
                          verticalMarkPointsValue.toPrecision(0);
                    }
                    yAxisSelectedValue =
                        yAxisMultiPliedBy * verticalMarkPointsValue;
                    //selectedValue.height;
                    print("V value Y $verticalMarkPointsValue");
                  }

                  if (maxDragWidth > newWidth) {
                    widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                    double lineWidth = getHorizontalSpaceInLine();
                    double horizontalMarkPointValue =
                        widthOfResizableBox / lineWidth;

                    print("X value $horizontalMarkPointValue");

                    horizontalMarkPointValue =
                        horizontalMarkPointValue.toPrecision(1);
                    if (horizontalMarkPointValue > horizontalMarkPoints) {
                      horizontalMarkPointValue =
                          horizontalMarkPointValue.toPrecision(0);
                    }
                    xAxisSelectedValue =
                        xAxisMultiPliedBy * horizontalMarkPointValue;
                    print("X value X $horizontalMarkPointValue");
                  }
                });
              },
            ),
          ),

          // center right
          /* Positioned(
            top: top + heightOfResizableBox / 2 - ballDiameter / 2,
            left: left + widthOfResizableBox - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newWidth = widthOfResizableBox + dx;

                setState(() {
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                });
              },
            ),
          ),*/
          // bottom right
          /* Positioned(
            top: top + heightOfResizableBox - ballDiameter / 2,
            left: left + widthOfResizableBox - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;

                var newHeight = heightOfResizableBox + 2 * mid;
                var newWidth = widthOfResizableBox + 2 * mid;

                setState(() {
                  heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),*/
          // bottom center
          /*Positioned(
            top: top + heightOfResizableBox - ballDiameter / 2,
            left: left + widthOfResizableBox / 2 - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newHeight = heightOfResizableBox + dy;

                setState(() {
                  heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                });
              },
            ),
          ),*/
          // bottom left
          /* Positioned(
            top: top + heightOfResizableBox - ballDiameter / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var mid = ((dx * -1) + dy) / 2;

                var newHeight = heightOfResizableBox + 2 * mid;
                var newWidth = widthOfResizableBox + 2 * mid;

                setState(() {
                  heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),*/
          //left center
          /* Positioned(
            top: top + heightOfResizableBox / 2 - ballDiameter / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              onDrag: (dx, dy) {
                var newWidth = widthOfResizableBox - dx;

                setState(() {
                  widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                  left = left + dx;
                });
              },
            ),
          ),*/
          // center center
          Positioned(
            bottom: bottom + heightOfResizableBox / 2 - ballDiameter / 2,
            left: left + widthOfResizableBox / 2 - ballDiameter / 2,
            child: ManipulatingBall(
              manipulatingBallColor: Colors.transparent,
              positionValue: "$xAxisSelectedValue,$yAxisSelectedValue",
              onDrag: (dx, dy) {
                /*setState(() {
                  top = top + dy;
                  left = left + dx;
                });*/
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall(
      {Key key,
      this.onDrag,
      this.positionValue = "",
      this.manipulatingBallColor});

  final Function onDrag;
  final String positionValue;
  final Color manipulatingBallColor;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX;
  double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: widget.manipulatingBallColor != null
              ? widget.manipulatingBallColor
              : Colors.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Text("${widget.positionValue}"),
      ),
    );
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
