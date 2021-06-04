import 'package:flutter/material.dart';

class PressDownUpAnimation extends StatefulWidget {
  final child, onclick;
  PressDownUpAnimation({Key key,this.child,this.onclick}):super(key:key);
  @override
  _PressDownUpAnimationState createState() => _PressDownUpAnimationState(this.child,this.onclick);
}

class _PressDownUpAnimationState extends State<PressDownUpAnimation> with SingleTickerProviderStateMixin {
  AnimationController animateController;
  Animation<double> animation;
  var childWidget, onclickFunction;

  _PressDownUpAnimationState(child, onclick){
    this.childWidget = child;
    this.onclickFunction = onclick;
  }

  @override
  void initState(){
    animateController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    animation = Tween(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: animateController, curve: Curves.elasticOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: animateController, curve: Curves.elasticOut)),
    child: GestureDetector(
      onTap: () async {
        await animateController.forward();
        animateController.reset();
        if(widget.onclick!=null){
          widget.onclick();
        }
      },
      child: widget.child??Container(),
    ));
  }
}
