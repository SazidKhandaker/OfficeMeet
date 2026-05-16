import 'package:flutter/material.dart';
import 'package:office_meet/Auth/login.dart' show LoginPage;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final isSmall = size.height < 700;

    return Scaffold(

      backgroundColor: const Color(0xFF020617),

      body: Stack(
        children: [

          /// =========================
          /// TOP RIGHT GLOW
          /// =========================
          Positioned(
            top: -120,
            right: -80,

            child: Container(
              height: 280,
              width: 280,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2CE6A6)
                        .withOpacity(0.22),

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
            bottom: -150,
            left: -120,

            child: Container(
              height: 350,
              width: 350,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF16A34A)
                        .withOpacity(0.20),

                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          /// =========================
          /// ORBIT LINES
          /// =========================
          Positioned.fill(
            child: CustomPaint(
              painter: OrbitPainter(),
            ),
          ),

          /// =========================
          /// MAIN CONTENT
          /// =========================
          SafeArea(

            child: SingleChildScrollView(

              physics:
              const BouncingScrollPhysics(),

              child: ConstrainedBox(

                constraints: BoxConstraints(
                  minHeight: size.height,
                ),

                child: Padding(

                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                  ),

                  child: Column(
                    children: [

                      SizedBox(
                          height:
                          size.height * 0.03),

                      /// =========================
                      /// TOP FLOATING CARDS
                      /// =========================
                      SizedBox(

                        height: isSmall
                            ? size.height * 0.24
                            : size.height * 0.38,

                        child: Stack(
                          children: [

                            /// CARD 1
                            Positioned(
                              top: isSmall ? 15 : 40,
                              left: isSmall ? 0 : -10,

                              child: Transform.rotate(

                                angle: -0.30,

                                child: buildFeatureCard(
                                  title: "Meeting Room",

                                  subtitle:
                                  "Book Instantly",

                                  icon:
                                  Icons.meeting_room_rounded,

                                  isSmall: isSmall,
                                ),
                              ),
                            ),

                            /// CARD 2
                            Positioned(
                              top: isSmall ? 35 : 65,
                              left: isSmall
                                  ? size.width * 0.26
                                  : size.width * 0.28,

                              child: Transform.rotate(

                                angle: -0.10,

                                child: buildFeatureCard(
                                  title: "Team Sync",

                                  subtitle:
                                  "Manage Schedules",

                                  icon:
                                  Icons.groups_rounded,

                                  isSmall: isSmall,
                                ),
                              ),
                            ),

                            /// CARD 3
                            Positioned(
                              top: isSmall ? 65 : 130,
                              right: isSmall ? 0 : -10,

                              child: Transform.rotate(

                                angle: 0.18,

                                child: buildFeatureCard(
                                  title: "Workspace",

                                  subtitle:
                                  "Collaborate Faster",

                                  icon: Icons
                                      .calendar_month_rounded,

                                  isSmall: isSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                          height:
                          size.height * 0.04),

                      /// =========================
                      /// TITLE
                      /// =========================
                      RichText(

                        textAlign: TextAlign.center,

                        text: TextSpan(
                          children: [

                            TextSpan(
                              text: "Smart ",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize:
                                isSmall ? 34 : 52,

                                fontWeight:
                                FontWeight.bold,

                                height: 1.1,
                              ),
                            ),

                            TextSpan(
                              text: "Meetings",

                              style: TextStyle(
                                color:
                                const Color(0xFF2CE6A6),

                                fontSize:
                                isSmall ? 34 : 52,

                                fontWeight:
                                FontWeight.bold,

                                height: 1.1,
                              ),
                            ),

                            TextSpan(
                              text:
                              "\nStart Here",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize:
                                isSmall ? 34 : 52,

                                fontWeight:
                                FontWeight.bold,

                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                          height:
                          size.height * 0.025),

                      /// =========================
                      /// SUBTITLE
                      /// =========================
                      Padding(

                        padding: EdgeInsets.symmetric(
                          horizontal:
                          size.width * 0.03,
                        ),

                        child: Text(

                          "Manage meeting rooms, schedules, and collaboration effortlessly in one smart platform.",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            color:
                            const Color(0xFF94A3B8),

                            fontSize:
                            isSmall ? 14 : 17,

                            height: 1.7,

                            fontWeight:
                            FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(
                          height:
                          size.height * 0.06),

                      /// =========================
                      /// LOGIN BUTTON
                      /// =========================
                      GestureDetector(
                        onTap: (){
                          Navigator.push(

                            context,

                            MaterialPageRoute(
                              builder: (context) =>
                              const LoginPage(),
                            ),
                          );
                        },

                        child: Container(

                          height:
                          isSmall ? 58 : 66,

                          width: double.infinity,

                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(40),

                            gradient:
                            const LinearGradient(
                              colors: [

                                Color(0xFF2CE6A6),

                                Color(0xFF16A34A),
                              ],
                            ),

                            boxShadow: [

                              BoxShadow(

                                color:
                                const Color(0xFF2CE6A6)
                                    .withOpacity(0.30),

                                blurRadius: 24,
                                spreadRadius: 1,
                              ),
                            ],
                          ),

                          child: Row(

                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                            children: [

                              const SizedBox(width: 22),

                              Text(

                                "Log In",

                                style: TextStyle(

                                  color: Colors.white,

                                  fontSize:
                                  isSmall ? 18 : 20,

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              Container(

                                margin:
                                const EdgeInsets.all(8),

                                height: 48,
                                width: 48,

                                decoration:
                                const BoxDecoration(
                                  shape: BoxShape.circle,

                                  color:
                                  Color(0xFF02110C),
                                ),

                                child: const Icon(

                                  Icons
                                      .arrow_forward_rounded,

                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                          height:
                          size.height * 0.022),

                      /// =========================
                      /// SIGN UP BUTTON
                      /// =========================
                      Container(

                        height:
                        isSmall ? 58 : 66,

                        width: double.infinity,

                        decoration: BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(40),

                          color: Colors.white10,

                          border: Border.all(
                            color: Colors.white12,
                          ),
                        ),

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            const SizedBox(width: 22),

                            Text(

                              "Sign Up",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize:
                                isSmall ? 18 : 20,

                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),

                            Container(

                              margin:
                              const EdgeInsets.all(8),

                              height: 48,
                              width: 48,

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,

                                color:
                                const Color(0xFF2CE6A6)
                                    .withOpacity(0.16),
                              ),

                              child: const Icon(

                                Icons
                                    .arrow_forward_rounded,

                                color:
                                Color(0xFF2CE6A6),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                          height:
                          size.height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// FEATURE CARD
  /// =========================
  Widget buildFeatureCard({

    required String title,

    required String subtitle,

    required IconData icon,

    required bool isSmall,
  }) {

    return Container(

      height: isSmall ? 125 : 190,
      width: isSmall ? 115 : 170,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(34),

        gradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            Colors.white.withOpacity(0.10),

            Colors.white.withOpacity(0.04),
          ],
        ),

        border: Border.all(
          color: Colors.white10,
        ),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(0.35),

            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Container(

            height: 46,
            width: 46,

            decoration: BoxDecoration(

              shape: BoxShape.circle,

              color: Colors.white10,
            ),

            child: Icon(

              icon,

              color:
              const Color(0xFF2CE6A6),
            ),
          ),

          const Spacer(),

          Text(

            title,

            style: TextStyle(

              color: Colors.white,

              fontSize:
              isSmall ? 15 : 24,

              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(

            subtitle,

            style: TextStyle(

              color: Colors.white70,

              fontSize:
              isSmall ? 11 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================
/// ORBIT PAINTER
/// =========================
class OrbitPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()

      ..color = Colors.white.withOpacity(0.10)

      ..style = PaintingStyle.stroke

      ..strokeWidth = 1;

    canvas.drawCircle(

      Offset(
        size.width * 0.5,
        size.height * 0.25,
      ),

      220,

      paint,
    );

    canvas.drawCircle(

      Offset(
        size.width * 0.5,
        size.height * 0.25,
      ),

      300,

      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate) {

    return false;
  }
}