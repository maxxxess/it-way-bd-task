
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:it_way_bd/screens/task_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Create Animation Controller for scaling, rotating, and opacity
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Define scaling animation (scale from 0.0 to 1.0)
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Define rotation animation (rotate from 0.0 to 360 degrees)
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1416).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Define opacity animation (fade from 0.0 to 1.0)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after the splash
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 154, 87, 249),
                Colors.white,
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedBuilder(
              animation: Listenable.merge([_rotationAnimation, _opacityAnimation]),
              child: Image.asset(
                'images/logo.png', //  Logo of IT Way BD
                height: height * 0.50,
                width: width * 0.50,
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                           BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                            offset: Offset(5,-25), // Bottom-right shadow position
                          ),
                       
                        
                        ],
                      ),
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}