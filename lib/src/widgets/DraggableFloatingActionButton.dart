import 'package:flutter/material.dart';

const BoxConstraints _kSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _kMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

/*
const BoxConstraints _kExtendedSizeConstraints = BoxConstraints(
  minHeight: 48.0,
  maxHeight: 48.0,
);
*/

const Offset _kDefaultOffset = Offset(0, 0);

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

class DraggableFloatingActionButton extends StatefulWidget {
  DraggableFloatingActionButton(
      {Key key,
      this.child,
      this.childSelected,
      this.childView,
      this.tooltip,
      this.foregroundColor,
      this.backgroundColor = Colors.white,
      this.heroTag = const _DefaultHeroTag(),
      this.elevation = 6.0,
      this.highlightElevation = 12.0,
      @required this.onPressed,
      this.mini = false,
      this.shape = const CircleBorder(),
      this.clipBehavior = Clip.none,
      this.materialTapTargetSize,
      this.isExtended = false,
      this.appContext,
      this.appBar,
      this.data = 'dfab',
      this.offset = _kDefaultOffset,
      this.childViewSize = const Size(80, 80),
      this.controller})
      : assert(elevation != null),
        assert(highlightElevation != null),
        assert(mini != null),
        assert(shape != null),
        assert(isExtended != null),
        assert(appContext != null),
        assert(childViewSize != null),
        _sizeConstraints = mini ? _kMiniSizeConstraints : _kSizeConstraints,
        super(key: key);

  final Widget child;
  final Widget childSelected;
  final Widget childView;
  final Size childViewSize;
  final DraggableFloatingActionButtonController controller;
  final String tooltip;

  final Color foregroundColor;

  final Color backgroundColor;

  final Object heroTag;

  final VoidCallback onPressed;

  final double elevation;

  final double highlightElevation;

  final bool mini;

  final ShapeBorder shape;

  final Clip clipBehavior;

  final bool isExtended;

  final MaterialTapTargetSize materialTapTargetSize;

  final BuildContext appContext;

  final AppBar appBar;

  final Offset offset;

  final BoxConstraints _sizeConstraints;

  final String data;

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  Offset dynamicOffset;
  bool showChild = false;
  DraggableFloatingActionButtonController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (_controller != null) {
      _controller.callToExpand = expandFunction;
      _controller.callToCollapse = collapseFunction;
    }
  }

  void expandFunction() {
    setState(() {
      showChild = !showChild;
    });
    print('Calling first function');
  }

  void collapseFunction() {
    setState(() {
      showChild = false;
    });
    print('Calling first function');
  }

  @override
  Widget build(BuildContext context) {
    //Size childViewSize = Size(80, 80);
    if (dynamicOffset == null) {
      dynamicOffset = widget.offset;
    }

    Widget childViewTemp =
        widget.childView != null ? widget.childView : Container();

    Widget floatingChildView = !showChild
        ? Container()
        : Container(
            child: widget.childView != null ? childViewTemp : Container(),
          );

    FloatingActionButton _floatingActionButton = new FloatingActionButton(
        key: widget.key,
        child: !showChild
            ? widget.child
            : (widget.childSelected != null
                ? widget.childSelected
                : widget.child),
        tooltip: widget.tooltip,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        heroTag: widget.heroTag,
        elevation: widget.elevation,
        highlightElevation: widget.highlightElevation,
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed();
          }
          expandFunction();
        },
        shape: widget.shape,
        isExtended: widget.isExtended,
        materialTapTargetSize: widget.materialTapTargetSize,
        clipBehavior: widget.clipBehavior,
        mini: widget.mini);

    Widget _floatingActionView = Container(
      //height: 50,
      width: widget.childViewSize.width,
      child: Column(
        children: [_floatingActionButton, floatingChildView],
      ),
    );

    return Positioned(
        left: dynamicOffset.dx,
        top: dynamicOffset.dy,
        child: showChild
            ? _floatingActionView
            : Draggable(
                data: widget.data,
                child: _floatingActionView,
                feedback: _floatingActionView,
                childWhenDragging: Container(),
                onDraggableCanceled: (Velocity velocity, Offset offset) {
                  if (showChild) {
                    return;
                  } else {
                    setState(() {
                      double appBarHeight = 0;
                      if (widget.appBar != null) {
                        appBarHeight = widget.appBar.preferredSize.height;
                      }

                      var dy = offset.dy -
                          appBarHeight -
                          MediaQuery.of(widget.appContext).padding.top;

                      var maxDy = MediaQuery.of(widget.appContext).size.height -
                          MediaQuery.of(widget.appContext).padding.bottom -
                          appBarHeight -
                          MediaQuery.of(widget.appContext).padding.top;

                      if (dy < 0) {
                        dy = 0;
                      } else if (dy > maxDy) {
                        dy = maxDy - widget._sizeConstraints.maxHeight;
                      } else if ((dy + 50) > maxDy) {
                        dy = maxDy - (widget._sizeConstraints.maxHeight + 30);
                      }

                      Offset newOffset = new Offset(offset.dx, dy);
                      dynamicOffset = newOffset;
                    });
                  }
                },
              ));
  }
}

class DraggableFloatingActionButtonController {
  VoidCallback callToExpand;
  VoidCallback callToCollapse;
  void dispose() {
    //Remove any data that's will cause a memory leak/render errors in here
    callToExpand = null;
    callToCollapse = null;
  }
}
