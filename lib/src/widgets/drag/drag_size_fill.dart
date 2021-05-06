import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef AxisSelectedValueCallback = Function(
    {double xAxisSelectedValue, double yAxisSelectedValue});

class ResizableWidget extends StatefulWidget {
  ResizableWidget(
      {this.child,
      this.resizableBoxSiz,
      this.xAxisMultiPliedBy = 10,
      this.yAxisMultiPliedBy = 10,
      this.yAxisMarkPoints = 10,
      this.xAxisMarkPoints = 10,
      this.heightMain = 200,
      this.widthMain = 200,
      this.axisSelectedValueCallback,
      this.manipulatingBallColor,
      this.gridBgColor = Colors.grey,
      this.widgetBgColor = Colors.transparent,
      this.gridLinColor = Colors.black,
      this.pickedValueTextColor = Colors.black,
      this.dragBoxFillColor = Colors.green,
      this.isShowGrid = true,
      this.isShowYAxisNumberMarking = true,
      this.isShowXAxisNumberMarking = true,
      this.axisNumberMarkingFontSize = 7});
  final Widget child;
  final Size resizableBoxSiz; // it should less than heightMain and widthMain

  final int xAxisMultiPliedBy;
  final int yAxisMultiPliedBy;
  final int yAxisMarkPoints;
  final int xAxisMarkPoints;
  final double heightMain;
  final double widthMain;
  final AxisSelectedValueCallback axisSelectedValueCallback;

  final Color gridBgColor;
  final Color gridLinColor;
  final Color pickedValueTextColor;
  final Color dragBoxFillColor;
  final Color manipulatingBallColor;
  final Color widgetBgColor;
  final bool isShowGrid;
  final double axisNumberMarkingFontSize;
  final bool isShowYAxisNumberMarking;
  final bool isShowXAxisNumberMarking;

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState(
      gridBgColor: this.gridBgColor,
      manipulatingBallColor: this.manipulatingBallColor,
      gridLinColor: this.gridLinColor,
      pickedValueTextColor: this.pickedValueTextColor,
      dragBoxFillColor: this.dragBoxFillColor,
      xAxisMultiPliedBy: this.xAxisMultiPliedBy,
      resizableBoxSiz: this.resizableBoxSiz,
      yAxisMultiPliedBy: this.yAxisMultiPliedBy,
      yAxisMarkPoints: this.yAxisMarkPoints,
      xAxisMarkPoints: this.xAxisMarkPoints,
      heightMain: this.heightMain,
      widthMain: this.widthMain);
}

const ballDiameter = 30.0;

class _ResizableWidgetState extends State<ResizableWidget> {
  double heightOfResizableBox = 0;
  double widthOfResizableBox = 0;
  double maxDragWidth = 0;
  double maxDragHeight = 0;
  Size manipulatingWidgetSize = Size(30, 30);
  double top = 0;
  double bottom = 0;
  double left = 0;

  Size resizableBoxSiz; // it should less than heightMain and widthMain

  int xAxisMultiPliedBy;
  int yAxisMultiPliedBy;
  int yAxisMarkPoints;
  int xAxisMarkPoints;

  double heightMain;
  double widthMain;

  double gridLineWith = 0.3;

  //It will return to main class
  double xAxisSelectedValue = 0;
  double yAxisSelectedValue = 0;

  final Color gridBgColor;
  final Color gridLinColor;
  final Color pickedValueTextColor;
  final Color dragBoxFillColor;
  final Color manipulatingBallColor;

  _ResizableWidgetState(
      {this.gridBgColor,
      this.gridLinColor,
      this.pickedValueTextColor,
      this.manipulatingBallColor,
      this.dragBoxFillColor,
      this.xAxisMultiPliedBy,
      this.resizableBoxSiz,
      this.yAxisMultiPliedBy,
      this.yAxisMarkPoints,
      this.xAxisMarkPoints,
      this.heightMain,
      this.widthMain}) {
    heightOfResizableBox =
        resizableBoxHeightCalculate(); //heightMain-manipulatingWidgetSize.height;
    maxDragHeight = heightMain - ((manipulatingWidgetSize.height / 2) * 2);

    //Calculate resizable view width from main width
    widthOfResizableBox = resizableBoxWithCalculate();
    //Calculate resizable view width from main width
    maxDragWidth = widthMain - ((manipulatingWidgetSize.width / 2) * 2);
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
        (maxDragWidth - (gridLineWith * (xAxisMarkPoints + 1))) /
            xAxisMarkPoints;
    return horizontalSpaceInLine;
  }

  double getVerticalSpaceInLine() {
    double verticalSpaceInLine =
        (maxDragHeight - (gridLineWith * (yAxisMarkPoints + 1))) /
            yAxisMarkPoints;
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
    double rightMargin = (manipulatingWidgetSize.width / 2);
    double topMargin = (manipulatingWidgetSize.height / 2);

    //Line grid
    Widget lineGrid() {
      double verticalSpaceInLine = 0;
      double horizontalSpaceInLine = 0;

      verticalSpaceInLine = getVerticalSpaceInLine();

      horizontalSpaceInLine = getHorizontalSpaceInLine();

      return Container(
        color: !widget.isShowGrid ? Colors.transparent : gridBgColor,
        margin: EdgeInsets.only(
            right: rightMargin,
            top: topMargin,
            left: rightMargin,
            bottom: topMargin),
        child: Stack(
          children: [
            //Horizontal line for vertical marking
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !widget.isShowGrid
                    ? Container()
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          yAxisMarkPoints,
                          (i) => Container(
                            height: gridLineWith,
                            color: gridLinColor,
                            margin: EdgeInsets.only(
                                bottom: /*i == 0 ?*/ verticalSpaceInLine /* : 0,
                            top: i == 0 ? 0 : verticalSpaceInLine*/
                                ),
                          ),
                        )),
                Container(
                  height: gridLineWith,
                  color: gridLinColor,
                )
              ],
            ),
            //Vertical marking for horizontal marking
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: gridLineWith,
                  color: gridLinColor,
                ),
                !widget.isShowGrid
                    ? Container()
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          xAxisMarkPoints,
                          (i) => Container(
                            width: gridLineWith,
                            color: gridLinColor,
                            margin:
                                EdgeInsets.only(left: horizontalSpaceInLine),
                          ),
                        )),
              ],
            )
          ],
        ),
      );
    }

    //Line marking
    Widget lineGridValues() {
      double verticalSpaceInLine = 0;
      double horizontalSpaceInLine = 0;
      double fontSize = widget.axisNumberMarkingFontSize;
      verticalSpaceInLine =
          (maxDragHeight - (fontSize * (yAxisMarkPoints + 1))) /
              yAxisMarkPoints;
      horizontalSpaceInLine =
          (maxDragWidth - (fontSize * (xAxisMarkPoints + 1))) / xAxisMarkPoints;
      return Container(
        color: Colors.red.withOpacity(0.4),
        child: Stack(
          children: [
            //Y axis number marking
            !widget.isShowYAxisNumberMarking
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: topMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                yAxisMarkPoints,
                                (i) => Container(
                                  child: new RotatedBox(
                                      quarterTurns: 0,
                                      child: Text(
                                        "${((yAxisMarkPoints - i)) * yAxisMultiPliedBy}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: fontSize),
                                      )),
                                  margin: EdgeInsets.only(
                                      bottom: verticalSpaceInLine),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),

            //X axis number marking
            !widget.isShowYAxisNumberMarking
                ? Container()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 0, top: 0, left: rightMargin, bottom: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                xAxisMarkPoints,
                                (i) => Container(
                                  child: new RotatedBox(
                                      quarterTurns: 0,
                                      child: Text(
                                        "${(i + 1) * xAxisMultiPliedBy}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: fontSize),
                                      )),
                                  margin: EdgeInsets.only(
                                      left: horizontalSpaceInLine),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      );
    }

    return Container(
      height: heightMain,
      width: widthMain,
      color: widget.widgetBgColor,
      child: Stack(
        children: <Widget>[
          Align(
            child: lineGridValues(),
            alignment: Alignment.bottomLeft,
          ),

          Align(
            child: lineGrid(),
            alignment: Alignment.bottomLeft,
          ),
          Positioned(
            bottom: bottom + topMargin,
            left: left + rightMargin,
            child: Container(
              height: heightOfResizableBox,
              width: widthOfResizableBox,
              color: dragBoxFillColor,
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
          /*Positioned(
            bottom: bottom + heightOfResizableBox / 2 - ballDiameter / 2,
            left: left + widthOfResizableBox / 2 - ballDiameter / 2,
            child: ManipulatingBall(
              manipulatingBallColor: Colors.transparent,
              positionValue: "$xAxisSelectedValue,$yAxisSelectedValue",
              onDrag: (dx, dy) {
                */ /*setState(() {
                  top = top + dy;
                  left = left + dx;
                });*/ /*
              },
            ),
          ),*/

          //center top
          Positioned(
            bottom: (bottom + topMargin) +
                heightOfResizableBox -
                ballDiameter / 2.2,
            left: (left + rightMargin) +
                widthOfResizableBox / 2 -
                ballDiameter / 2,
            child: ManipulatingValueBall(
              pickedValueTextColor: pickedValueTextColor,
              manipulatingBallColor: Colors.transparent,
              positionValue: "Y - $yAxisSelectedValue",
              onDrag: (dx, dy) {},
            ),
          ),
          //center right
          Positioned(
            bottom: (bottom + topMargin) +
                heightOfResizableBox / 2 -
                ballDiameter / 2,
            left:
                (left + rightMargin) + widthOfResizableBox - ballDiameter / 2.2,
            child: ManipulatingValueBall(
              pickedValueTextColor: pickedValueTextColor,
              isVerticalText: true,
              manipulatingBallColor: Colors.transparent,
              positionValue: "X - $xAxisSelectedValue",
              onDrag: (dx, dy) {},
            ),
          ),

          // top right
          Positioned(
            bottom:
                (bottom + topMargin) + heightOfResizableBox - ballDiameter / 2,
            left: (left + rightMargin) + widthOfResizableBox - ballDiameter / 2,
            child: ManipulatingBall(
              manipulatingBallColor: manipulatingBallColor,
              onDrag: (dx, dy) {
                var newHeight = heightOfResizableBox - dy;
                double newWidth = widthOfResizableBox + dx;
                setState(() {
                  //Y axis Drag
                  if (maxDragHeight > newHeight) {
                    heightOfResizableBox = newHeight > 0 ? newHeight : 0;
                    double lineWidth = getVerticalSpaceInLine();
                    double verticalMarkPointsValue =
                        heightOfResizableBox / lineWidth;
                    print("Y value verticalMarkPointsValue");
                    verticalMarkPointsValue =
                        verticalMarkPointsValue.toPrecision(1);
                    if (verticalMarkPointsValue > yAxisMarkPoints) {
                      verticalMarkPointsValue =
                          verticalMarkPointsValue.toPrecision(0);
                    }
                    yAxisSelectedValue =
                        yAxisMultiPliedBy * verticalMarkPointsValue;
                    //selectedValue.height;
                    print("V value Y $verticalMarkPointsValue");
                  }

                  //X axis drag
                  if (maxDragWidth > newWidth) {
                    widthOfResizableBox = newWidth > 0 ? newWidth : 0;
                    double lineWidth = getHorizontalSpaceInLine();
                    double horizontalMarkPointValue =
                        widthOfResizableBox / lineWidth;

                    print("X value $horizontalMarkPointValue");

                    horizontalMarkPointValue =
                        horizontalMarkPointValue.toPrecision(1);
                    if (horizontalMarkPointValue > xAxisMarkPoints) {
                      horizontalMarkPointValue =
                          horizontalMarkPointValue.toPrecision(0);
                    }
                    xAxisSelectedValue =
                        xAxisMultiPliedBy * horizontalMarkPointValue;
                    print("X value X $horizontalMarkPointValue");
                  }
                });

                //Call back selected values
                if (widget.axisSelectedValueCallback != null) {
                  widget.axisSelectedValueCallback(
                      xAxisSelectedValue: xAxisSelectedValue,
                      yAxisSelectedValue: yAxisSelectedValue);
                }
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

//To show drag value
class ManipulatingValueBall extends StatefulWidget {
  ManipulatingValueBall(
      {Key key,
      this.onDrag,
      this.positionValue = "",
      this.manipulatingBallColor,
      this.isVerticalText = false,
      this.pickedValueTextColor = Colors.black});

  final Function onDrag;
  final String positionValue;
  final Color manipulatingBallColor;
  final Color pickedValueTextColor;
  final bool isVerticalText;

  @override
  _ManipulatingValueBallState createState() => _ManipulatingValueBallState();
}

class _ManipulatingValueBallState extends State<ManipulatingValueBall> {
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
        /*width: ballDiameter,
        height: ballDiameter,*/
        padding: EdgeInsets.only(
            bottom: widget.isVerticalText ? 0 : 13,
            left: widget.isVerticalText ? 13 : 0),
        decoration: BoxDecoration(
          color: widget.manipulatingBallColor != null
              ? widget.manipulatingBallColor
              : Colors.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: new RotatedBox(
            quarterTurns: widget.isVerticalText ? 1 : 0,
            child: Text(
              "${widget.positionValue}",
              style: TextStyle(color: widget.pickedValueTextColor),
            )),
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
