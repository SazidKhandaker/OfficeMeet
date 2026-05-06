import 'package:flutter/material.dart';
import 'dart:async';

import 'package:office_meet/onboardingscreen/onboarding.dart' show OnboardingScreen, CeoIntroScreen;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.repeat(reverse: true);
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
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
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF020617),
        body: Stack(
          children: [
      
            /// =========================
            /// TOP RIGHT GLOW
            /// =========================
            Positioned(
              top: -size.width * 0.30,
              right: -size.width * 0.20,
              child: Container(
                height: size.width * 0.75,
                width: size.width * 0.75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF22C55E).withOpacity(0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
      
            /// =========================
            /// BOTTOM LEFT GLOW
            /// =========================
            Positioned(
              bottom: -size.width * 0.35,
              left: -size.width * 0.25,
              child: Container(
                height: size.width * 0.90,
                width: size.width * 0.90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF16A34A).withOpacity(0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
      
            /// =========================
            /// MAIN CONTENT
            /// =========================
            SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
      
                      /// =========================
                      /// ANIMATED LOGO
                      /// =========================
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          height: size.width * 0.42,
                          width: size.width * 0.42,
      
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
      
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF1E293B),
                                Color(0xFF334155),
                                Color(0xFF475569),
                              ],
                            ),

                            border: Border.all(
                              color: const Color(0xFF2CE6A6).withOpacity(0.85),
                              width: 1.6,
                            ),
      
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2CE6A6).withOpacity(0.22),
                                blurRadius: 45,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
      
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.035),
      
                            child: Image.asset(
                              "assets/images/nurion_logo.png",
                              fit: BoxFit.contain,
      
                            ),
                          ),
                        ),
                      ),
      
                      SizedBox(height: size.height * 0.06),
      
                      /// =========================
                      /// APP NAME
                      /// =========================
                      Text(
                        "OfficeMeet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
      
                      SizedBox(height: size.height * 0.012),
      
                      /// =========================
                      /// SUBTITLE
                      /// =========================
                      Text(
                        "Smart Meeting Room Booking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF94A3B8),
                          fontSize: size.width * 0.043,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                        ),
                      ),
      
                      SizedBox(height: size.height * 0.07),
      
                      /// =========================
                      /// LOADING INDICATOR
                      /// =========================
                      SizedBox(
                        height: size.width * 0.085,
                        width: size.width * 0.085,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(
                            Color(0xFF22C55E),
                          ),
                          backgroundColor: Colors.white12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      
            /// =========================
            /// POWERED BY TEXT
            /// =========================
            Positioned(
              bottom: size.height * 0.04,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Powered by Nurion Lab",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: size.width * 0.040,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}