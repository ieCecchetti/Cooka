import 'package:cooka/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:cooka/data/constants.dart' as app;
import 'package:cooka/theme/app_theme.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for scale and opacity
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4000), // Extended duration
      vsync: this,
    );

    // Add listener to navigate when animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainViewScreen()),
        );
      }
    });

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation sequence
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.accentSoft,
                              AppColors.accent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/cooka.png',
                              width: 250, // Smaller image
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      app.appName,
                      style: handwritten(fontSize: 56),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: Text(
                      app.appDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.inkSoft,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                "created by LevelApp↑",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.inkSoft.withValues(alpha: 0.8),
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
