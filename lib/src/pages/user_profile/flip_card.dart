import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

enum FlipDirection {
  VERTICAL,
  HORIZONTAL,
}

class AnimationCard extends StatelessWidget {
  AnimationCard({this.child, this.animation, this.direction});

  final Widget child;
  final Animation<double> animation;
  final FlipDirection direction;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        if (direction == FlipDirection.VERTICAL) {
          transform.rotateX(animation.value);
        } else {
          transform.rotateY(animation.value);
        }
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef void BoolCallback(bool isFront);

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  /// The amount of milliseconds a turn animation will take.
  final int speed;
  final FlipDirection direction;
  final VoidCallback onFlip;
  final BoolCallback onFlipDone;
  final FlipCardController controller;

  final bool flipOnTouch;

  final Alignment alignment;

  const FlipCard({
    Key key,
    @required this.front,
    @required this.back,
    this.speed = 500,
    this.onFlip,
    this.onFlipDone,
    this.direction = FlipDirection.HORIZONTAL,
    this.controller,
    this.flipOnTouch = true,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FlipCardState();
  }
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;

  bool isFront = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: widget.speed), vsync: this);
    _frontRotation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    _backRotation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (widget.onFlipDone != null) widget.onFlipDone(isFront);
      }
    });

    widget.controller?.state = this;
  }

  void toggleCard() {
    if (widget.onFlip != null) {
      widget.onFlip();
    }
    controller.duration = Duration(milliseconds: widget.speed);
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      alignment: widget.alignment,
      fit: StackFit.passthrough,
      children: <Widget>[
        _buildContent(front: true),
        _buildContent(front: false),
      ],
    );

    /// if we need to flip the card on taps, wrap the content
    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: toggleCard,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({@required bool front}) {
    /// pointer events that would reach the backside of the card should be
    /// ignored
    return IgnorePointer(
      /// absorb the front card when the background is active (!isFront),
      /// absorb the background when the front is active
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        child: front ? widget.front : widget.back,
        direction: widget.direction,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FlipCardController {
  /// The internal widget state.
  /// Use only if you know what you're doing!
  FlipCardState state;

  /// The underlying AnimationController.
  /// Use only if you know what you're doing!
  AnimationController get controller => state?.controller;

  /// Flip the card
  void toggleCard() => state?.toggleCard();

  /// Skew by amount percentage (0 - 1.0)
  /// This can be used with a MouseReagion to indicate that the card can
  /// be flipped. skew(0) to go back to original.
  void skew(double amount, {Duration duration, Curve curve}) {
    assert(0 <= amount && amount <= 1);

    if (state.isFront) {
      controller?.animateTo(amount, duration: duration, curve: curve);
    } else {
      controller?.animateTo(1 - amount, duration: duration, curve: curve);
    }
  }

  /// Triggers a flip animation that reverses after the duration
  /// and will run for `total`
  void hint({Duration duration, Duration total}) {
    assert(controller is AnimationController);
    if (!(controller is AnimationController)) {
      return;
    }

    if (controller.isAnimating || controller.value != 0) return;

    Duration original = controller.duration;
    controller.duration = total ?? controller.duration;
    controller.forward();
    Timer(duration ?? const Duration(milliseconds: 150), () {
      controller.reverse();
      controller.duration = original;
    });
  }
}
