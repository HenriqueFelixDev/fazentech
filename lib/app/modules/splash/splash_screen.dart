import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation _logoScaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    )..forward();

    _logoScaleAnimation = CurvedAnimation(
      curve: Curves.easeOut,
      parent: Tween(begin: 0.2, end: 1.0).animate(_animationController)
    );

    _animationController.addListener(() async{
      if(_animationController.isCompleted) {
        await Future.delayed(Duration(seconds: 1));
        Modular.to.pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _logoAnimation({@required Widget child}) {
    return AnimatedBuilder(
      animation: _animationController,
      child: child,
      builder: (context, child) {
        final opacityAnimationStart = 0.5;
        final opacityOffset = _animationController.value - opacityAnimationStart;
        final opacity = 
          opacityOffset.clamp(0.0, 1.0) / (1.0 - opacityAnimationStart);
        
        return Opacity(
          opacity: opacity,
          child: ScaleTransition(
            scale: _logoScaleAnimation,
            child: child
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _logoAnimation(child: Image.asset('assets/img/logo-fazentech.png')),
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              )
            )
          ]
        )
      )
    );
  }
}