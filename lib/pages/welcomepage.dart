import 'package:nroho/Services/wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui; // import dart:ui with a prefix

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final heightDevice = ui.window.physicalSize.height;
  final widthDevice = ui.window.physicalSize.width;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Wrapper(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
             /* ClipPath(
                clipper: CustomClipper1(),
                child: Container(
                  height: 200,
                  color: Color.fromARGB(255, 1, 31, 56),
                ),
              ),*/
              Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: heightDevice * 0.12,
                    width: widthDevice * 0.12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CustomClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(ui.Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.0017857);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width * 0.7135417, size.height * 0.9901857, 0, size.height);
    path.quadraticBezierTo(
        size.width * 0.2435417,
        size.height * 0.9650000,
        size.width * 0.9741667,
        size.height * 0.8600000);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}