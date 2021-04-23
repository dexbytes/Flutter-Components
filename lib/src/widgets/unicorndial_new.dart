import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class UnicornOrientationNew {
  static const HORIZONTAL = 0;
  static const VERTICAL = 1;
}

class UnicornButtonNew extends FloatingActionButton {
  final FloatingActionButton currentButton;
  final String labelText;
  final double labelFontSize;
  final Color labelColor;
  final Color labelBackgroundColor;
  final Color labelShadowColor;
  final bool labelHasShadow;
  final bool hasLabel;

  UnicornButtonNew(
      {this.currentButton,
      this.labelText,
      this.labelFontSize = 14.0,
      this.labelColor,
      this.labelBackgroundColor,
      this.labelShadowColor,
      this.labelHasShadow = true,
      this.hasLabel = false})
      : assert(currentButton != null);

  Widget returnLabel() {
    return Container(
        decoration: BoxDecoration(
            boxShadow: this.labelHasShadow
                ? [
                    new BoxShadow(
                      color: this.labelShadowColor == null
                          ? Color.fromRGBO(204, 204, 204, 1.0)
                          : this.labelShadowColor,
                      blurRadius: 3.0,
                    ),
                  ]
                : null,
            color: this.labelBackgroundColor == null
                ? Colors.white
                : this.labelBackgroundColor,
            borderRadius: BorderRadius.circular(3.0)), //color: Colors.white,
        padding: EdgeInsets.all(9.0),
        child: Text(this.labelText,
            style: TextStyle(
                fontSize: this.labelFontSize,
                fontWeight: FontWeight.bold,
                color: this.labelColor == null
                    ? Color.fromRGBO(119, 119, 119, 1.0)
                    : this.labelColor)));
  }

  Widget build(BuildContext context) {
    return this.currentButton;
  }
}

class UnicornDialerNew extends StatefulWidget {
  final int orientation;
  final Icon parentButton;
  final Icon finalButtonIcon;
  final bool hasBackground;
  final Color parentButtonBackground;
  final List<UnicornButtonNew> childButtons;
  final int animationDuration;
  final int mainAnimationDuration;
  final double childPadding;
  final Color backgroundColor;
  final Function onMainButtonPressed;
  final Object parentHeroTag;
  final bool hasNotch;
  final bool isAlignBottomOrLeftSide;

  UnicornDialerNew(
      {this.parentButton,
      this.parentButtonBackground,
      this.childButtons,
      this.onMainButtonPressed,
      this.orientation = 1,
      this.hasBackground = true,
      this.isAlignBottomOrLeftSide = false,
      this.backgroundColor = Colors.white30,
      this.parentHeroTag = "parent",
      this.finalButtonIcon,
      this.animationDuration = 180,
      this.mainAnimationDuration = 200,
      this.childPadding = 4.0,
      this.hasNotch = false})
      : assert(parentButton != null);

  _UnicornDialerNew createState() => _UnicornDialerNew();
}

class _UnicornDialerNew extends State<UnicornDialerNew>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _parentController;
  bool isOpen = false;
  double fatButtonViewHeight = 60;
  double fatViewFullHeight = 60;
  double fatButtonSingleChildHeight = 0;
  GlobalKey fabKey = GlobalKey();
  @override
  void initState() {
    this._animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    this._parentController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.mainAnimationDuration));

    super.initState();
  }

  @override
  dispose() {
    this._animationController.dispose();
    this._parentController.dispose();
    super.dispose();
  }

  void mainActionButtonOnPressed() {
    if (this._animationController.isDismissed) {
      this._animationController.forward();
    } else {
      this._animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    this._animationController.reverse();

    var hasChildButtons =
        widget.childButtons != null && widget.childButtons.length > 0;
    bool isFabOnBottomOfScreenBool = widget.isAlignBottomOrLeftSide;

    //Get required view height
    getRequiredViewHeight() {
      double fatViewFullHeightTemp = fatButtonViewHeight + 20;
      if (hasChildButtons) {
        SizeProviderWidget(
          onChildSize: (size) {
            fatButtonSingleChildHeight = size.height;
          },
          child: widget
              .childButtons[0].currentButton, //the widget we want the size of,
        );
        fatViewFullHeightTemp =
            (((fatButtonSingleChildHeight + 15) * widget.childButtons.length) +
                fatButtonViewHeight +
                20);
      }
      fatViewFullHeight = fatViewFullHeightTemp;
      return fatViewFullHeightTemp;
    }

    //Check if
    bool isFabOnBottomOfScreen({BuildContext context}) {
      bool isOnBottomOnScreen = false;
      RenderBox referenceBox = context.findRenderObject();
      // final RenderBox referenceBox = fabKey.currentContext.findRenderObject();
      final position = referenceBox.localToGlobal(Offset.zero);
      final buttonXPosition = position.dx;
      final buttonYPosition = position.dy;
      final screenHeight = MediaQuery.of(context).size.height;
      print(
          "#### object y position $buttonYPosition & Screen height $screenHeight");
      double requiredHeight = getRequiredViewHeight();
      if (requiredHeight > 0 && buttonYPosition > -1 && screenHeight > 0) {
        double requiredButtonYPosition = requiredHeight + buttonYPosition;
        print(
            "#### object y position $requiredButtonYPosition  & object y position $buttonYPosition & Required height $requiredHeight & Screen height $screenHeight");
        if (requiredButtonYPosition > screenHeight) {
          isOnBottomOnScreen = true;
        }
      }
      return isOnBottomOnScreen;
    }

    if (!this._parentController.isAnimating) {
      if (this._parentController.isCompleted) {
        this._parentController.forward().then((s) {
          this._parentController.reverse().then((e) {
            this._parentController.forward();
          });
        });
      }
      if (this._parentController.isDismissed) {
        this._parentController.reverse().then((s) {
          this._parentController.forward();
        });
      }
    }

    var mainFAB = AnimatedBuilder(
        animation: this._parentController,
        builder: (BuildContext context, Widget child) {
          return Transform(
              transform: new Matrix4.diagonal3(vector.Vector3(
                  _parentController.value,
                  _parentController.value,
                  _parentController.value)),
              alignment: FractionalOffset.center,
              child: SizeProviderWidget(
                  onChildSize: (size) {
                    fatButtonViewHeight = size.height;
                  },
                  child: FloatingActionButton(
                      isExtended: false,
                      heroTag: widget.parentHeroTag,
                      backgroundColor: widget.parentButtonBackground,
                      onPressed: () {
                        mainActionButtonOnPressed();
                        if (widget.onMainButtonPressed != null) {
                          widget.onMainButtonPressed();
                        }
                      },
                      child: !hasChildButtons
                          ? widget.parentButton
                          : AnimatedBuilder(
                              animation: this._animationController,
                              builder: (BuildContext context, Widget child) {
                                return Transform(
                                  transform: new Matrix4.rotationZ(
                                      this._animationController.value * 0.8),
                                  alignment: FractionalOffset.center,
                                  child: isFabOnBottomOfScreenBool
                                      ? (this._animationController.isDismissed
                                          ? RotatedBox(
                                              quarterTurns: 2,
                                              child: Icon(
                                                  widget.parentButton.icon))
                                          : Icon(widget.finalButtonIcon == null
                                              ? Icons.close
                                              : widget.finalButtonIcon.icon))
                                      : new Icon(this
                                              ._animationController
                                              .isDismissed
                                          ? (widget.parentButton.icon)
                                          : widget.finalButtonIcon == null
                                              ? Icons.close
                                              : widget.finalButtonIcon.icon),
                                );
                              }))));
        });

    Widget positionOfChildView({int index, @required Widget childView}) {
      if (widget.orientation == UnicornOrientationNew.VERTICAL) {
        double topToBottomPosition = isFabOnBottomOfScreenBool
            ? (((widget.childButtons.length - index) * 55.0) + 15)
            : ((index + 1) * 55.0);
        return isFabOnBottomOfScreenBool
            ? Positioned(
                right:
                    widget.childButtons[index].currentButton.mini ? 4.0 : 0.0,
                //top: isFabOnBottomOfScreenBool ? 0 : topToBottomPosition,
                bottom: topToBottomPosition,
                child: childView,
              )
            : Positioned(
                right:
                    widget.childButtons[index].currentButton.mini ? 4.0 : 0.0,
                top: topToBottomPosition,
                // bottom: isFabOnBottomOfScreenBool ? topToBottomPosition : 0,
                child: childView,
              );
      } else {
        double leftToRightPosition = isFabOnBottomOfScreenBool
                ? (((widget.childButtons.length - index) * 55.0) + 8)
                : ((index + 1) * 55.0)
            /*: 8.0*/;
        return isFabOnBottomOfScreenBool
            ? Positioned(
                left:
                    leftToRightPosition /*widget.orientation == UnicornOrientationNew.VERTICAL
                    ? widget.childButtons[index].currentButton.mini
                        ? 4.0
                        : 0.0
                    : ((widget.childButtons.length - index) * 55.0) + 15*/
                ,
                //top: isFabOnBottomOfScreenBool ? 0 : leftToRightPosition,
                bottom: 0,
                child: childView,
              )
            : Positioned(
                right: leftToRightPosition,
                bottom: 0,
                // bottom: isFabOnBottomOfScreenBool ? topToBottomPosition : 0,
                child: childView,
              );
      }
    }

    if (hasChildButtons) {
      var mainFloatingButton = AnimatedBuilder(
          animation: this._animationController,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
                angle: this._animationController.value * 0.8, child: mainFAB);
          });

      var childButtonsList = widget.childButtons == null ||
              widget.childButtons.length == 0
          ? List<Widget>()
          : List.generate(widget.childButtons.length, (index) {
              var intervalValue = index == 0
                  ? 0.9
                  : ((widget.childButtons.length - index) /
                          widget.childButtons.length) -
                      0.2;

              intervalValue =
                  intervalValue < 0.0 ? (1 / index) * 0.5 : intervalValue;

              var childFAB = FloatingActionButton(
                  onPressed: () {
                    if (widget.childButtons[index].currentButton.onPressed !=
                        null) {
                      widget.childButtons[index].currentButton.onPressed();
                    }

                    this._animationController.reverse();
                  },
                  child: widget.childButtons[index].currentButton.child,
                  heroTag: widget.childButtons[index].currentButton.heroTag,
                  backgroundColor:
                      widget.childButtons[index].currentButton.backgroundColor,
                  mini: widget.childButtons[index].currentButton.mini,
                  tooltip: widget.childButtons[index].currentButton.tooltip,
                  key: widget.childButtons[index].currentButton.key,
                  elevation: widget.childButtons[index].currentButton.elevation,
                  foregroundColor:
                      widget.childButtons[index].currentButton.foregroundColor,
                  highlightElevation: widget
                      .childButtons[index].currentButton.highlightElevation,
                  isExtended:
                      widget.childButtons[index].currentButton.isExtended,
                  shape: widget.childButtons[index].currentButton.shape);

              return positionOfChildView(
                  index: index,
                  childView: Row(children: [
                    ScaleTransition(
                        scale: CurvedAnimation(
                          parent: this._animationController,
                          curve: Interval(intervalValue, 1.0,
                              curve: Curves.linear),
                        ),
                        alignment: FractionalOffset.topCenter,
                        child: (!widget.childButtons[index].hasLabel) ||
                                widget.orientation ==
                                    UnicornOrientationNew.HORIZONTAL
                            ? Container()
                            : Container(
                                padding:
                                    EdgeInsets.only(right: widget.childPadding),
                                child:
                                    widget.childButtons[index].returnLabel())),
                    ScaleTransition(
                        scale: CurvedAnimation(
                          parent: this._animationController,
                          curve: Interval(intervalValue, 1.0,
                              curve: Curves.linear),
                        ),
                        alignment: FractionalOffset.center,
                        child: childFAB)
                  ]));
            });

      unicornDialWidget() {
        /*fatViewFullHeight =
            (((fatButtonSingleChildHeight + 18) * widget.childButtons.length) +
                fatButtonViewHeight +
                20);*/
        return Container(
            //color: Colors.orange,
            margin: widget.hasNotch ? EdgeInsets.only(bottom: 15.0) : null,
            // height: fatViewFullHeight,
            child: Stack(
                //fit: StackFit.expand,
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: childButtonsList.toList()
                  ..add(Positioned(
                      right: null, bottom: null, child: mainFloatingButton))));
      }

      var modal = ScaleTransition(
          scale: CurvedAnimation(
            parent: this._animationController,
            curve: Interval(1.0, 1.0, curve: Curves.linear),
          ),
          alignment: FractionalOffset.center,
          child: GestureDetector(
              onTap: mainActionButtonOnPressed,
              child: Container(
                color: widget.backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              )));

      return widget.hasBackground
          ? Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: [
                  Positioned(right: -16.0, /* top: -16.0,*/ child: modal),
                  unicornDialWidget()
                ])
          : unicornDialWidget();
    }

    return mainFAB;
  }
}

class SizeProviderWidget extends StatefulWidget {
  final Widget child;
  final Function(Size) onChildSize;

  const SizeProviderWidget({Key key, this.onChildSize, this.child})
      : super(key: key);
  @override
  _SizeProviderWidgetState createState() => _SizeProviderWidgetState();
}

class _SizeProviderWidgetState extends State<SizeProviderWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onChildSize(context.size);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
