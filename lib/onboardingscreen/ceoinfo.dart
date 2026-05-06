import 'package:flutter/material.dart';

class CeoIntroScreen extends StatelessWidget {
  const CeoIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallDevice = size.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF020617),

      body: SafeArea(
        child: Stack(
          children: [

            /// =========================
            /// TOP RIGHT GLOW
            /// =========================
            Positioned(
              top: -size.width * 0.25,
              right: -size.width * 0.20,
              child: Container(
                height: size.width * 0.70,
                width: size.width * 0.70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF22C55E).withOpacity(0.16),
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
              bottom: -size.width * 0.30,
              left: -size.width * 0.25,
              child: Container(
                height: size.width * 0.85,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF16A34A).withOpacity(0.14),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// =========================
            /// SCROLLABLE CONTENT
            /// =========================
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                  vertical: size.height * 0.025,
                ),
                child: Column(
                  children: [

                    SizedBox(height: size.height * 0.02),

                    /// =========================
                    /// CEO IMAGE CARD
                    /// =========================
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.42,
                        minHeight: size.height * 0.30,
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),

                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0F172A),
                            Color(0xFF1E293B),
                          ],
                        ),

                        border: Border.all(
                          color:
                          const Color(0xFF22C55E).withOpacity(0.35),
                          width: 1.2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                            const Color(0xFF22C55E)
                                .withOpacity(0.12),
                            blurRadius: 25,
                            spreadRadius: 1,
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          "assets/images/kimsir.JPEG",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    /// =========================
                    /// CEO NAME
                    /// =========================
                    Text(
                      "Edward Kim",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF22C55E),
                        fontSize:
                        isSmallDevice
                            ? size.width * 0.085
                            : size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: size.height * 0.008),

                    /// =========================
                    /// DESIGNATION
                    /// =========================
                    Text(
                      "CEO & Founder",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize:
                        isSmallDevice
                            ? size.width * 0.042
                            : size.width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    /// =========================
                    /// MESSAGE
                    /// =========================
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                      ),
                      child: Text(
                        "Leading innovation with smart solutions, modern technology, and a vision for future growth. Empowering teams through intelligent digital transformation.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFCBD5E1),
                          fontSize:
                          isSmallDevice
                              ? size.width * 0.038
                              : size.width * 0.040,
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.06),

                    /// =========================
                    /// BUTTON ROW
                    /// =========================
                    Row(
                      children: [

                        /// SKIP BUTTON
                        Expanded(
                          child: Container(
                            height: size.height * 0.07,

                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(30),
                              color: Colors.white10,
                            ),

                            child: Center(
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  size.width * 0.043,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: size.width * 0.045),

                        /// NEXT BUTTON
                        Expanded(
                          child: Container(
                            height: size.height * 0.07,

                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(30),

                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF22C55E),
                                  Color(0xFF16A34A),
                                ],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color:
                                  const Color(0xFF22C55E)
                                      .withOpacity(0.28),
                                  blurRadius: 18,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  size.width * 0.043,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}