import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController _controller = PageController();

  bool isLastPage = false;

  final List<Map<String, String>> onboardingData = [

    /// =========================
    /// PAGE 1
    /// =========================
    {
      "image": "assets/images/kimsir.JPEG",

      "title": "Edward Kim",

      "subtitle":
      "Leading innovation with smart solutions, modern technology, and a vision for future growth. Empowering teams through intelligent digital transformation.",

      "designation": "CEO & Founder",
    },

    /// =========================
    /// PAGE 2
    /// =========================
    {
      "image": "assets/images/Acote.png",

      "title": "Acote",

      "subtitle":
      "Acote Group is a diversified global enterprise focused on innovation, technology, and sustainable growth. We are committed to building future-ready solutions that empower businesses, improve lives, and create long-term value for tomorrow’s world.",

      "designation": "For Your Tomorrow",
    },

    /// =========================
    /// PAGE 3
    /// =========================
    {
      "image": "assets/images/teamwork.png",

      "title": "Work Smarter Together",

      "subtitle":
      "Boost productivity with intelligent scheduling and seamless workplace collaboration.",

      "designation": "",
    },
  ];

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final isSmallDevice = size.height < 700;

    return WillPopScope(

        onWillPop: () async {

          /// =========================
          /// GO TO PREVIOUS PAGE
          /// =========================
          if (_controller.page != null &&
              _controller.page! > 0) {

            _controller.previousPage(

              duration: const Duration(
                milliseconds: 400,
              ),

              curve: Curves.easeInOut,
            );

            return false;
          }

          /// =========================
          /// SHOW EXIT DIALOG
          /// =========================
          final shouldExit = await showDialog(

            context: context,

            barrierDismissible: false,

            builder: (context) {

              final size = MediaQuery.of(context).size;

              return Dialog(

                backgroundColor: Colors.transparent,

                child: Container(

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30),

                    gradient: const LinearGradient(

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [

                        Color(0xFF0F172A),

                        Color(0xFF1E293B),

                        Color(0xFF243B55),
                      ],
                    ),

                    border: Border.all(

                      color:
                      const Color(0xFF2CE6A6).withOpacity(0.30),

                      width: 1.2,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color:
                        const Color(0xFF2CE6A6).withOpacity(0.12),

                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Column(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      /// =========================
                      /// ICON
                      /// =========================
                      Container(

                        height: 80,
                        width: 80,

                        decoration: BoxDecoration(

                          shape: BoxShape.circle,

                          gradient: LinearGradient(

                            colors: [

                              const Color(0xFF2CE6A6)
                                  .withOpacity(0.18),

                              const Color(0xFF16A34A)
                                  .withOpacity(0.10),
                            ],
                          ),

                          border: Border.all(

                            color:
                            const Color(0xFF2CE6A6)
                                .withOpacity(0.35),
                          ),
                        ),

                        child: const Icon(

                          Icons.logout_rounded,

                          color: Color(0xFF2CE6A6),

                          size: 38,
                        ),
                      ),

                      SizedBox(height: size.height * 0.025),

                      /// =========================
                      /// TITLE
                      /// =========================
                      Text(

                        "Exit OfficeMeet?",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: size.width * 0.055,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: size.height * 0.015),

                      /// =========================
                      /// SUBTITLE
                      /// =========================
                      Text(

                        "Are you sure you want to close the application?",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          color: const Color(0xFF94A3B8),

                          fontSize: size.width * 0.040,

                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: size.height * 0.035),

                      /// =========================
                      /// BUTTONS
                      /// =========================
                      Row(
                        children: [

                          /// CANCEL BUTTON
                          Expanded(
                            child: GestureDetector(

                              onTap: () {

                                Navigator.pop(context, false);
                              },

                              child: Container(

                                height: 54,

                                decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(18),

                                  color: Colors.white10,
                                ),

                                child: Center(

                                  child: Text(

                                    "Cancel",

                                    style: TextStyle(

                                      color: Colors.white,

                                      fontSize:
                                      size.width * 0.040,

                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: size.width * 0.04),

                          /// EXIT BUTTON
                          Expanded(
                            child: GestureDetector(

                              onTap: () {

                                Navigator.pop(context, true);
                              },

                              child: Container(

                                height: 54,

                                decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(18),

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
                                          .withOpacity(0.22),

                                      blurRadius: 18,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),

                                child: Center(

                                  child: Text(

                                    "Exit",

                                    style: TextStyle(

                                      color: Colors.white,

                                      fontSize:
                                      size.width * 0.040,

                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          return shouldExit ?? false;
        },


      child:Scaffold(

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
                    const Color(0xFF22C55E)
                        .withOpacity(0.18),

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
                    const Color(0xFF16A34A)
                        .withOpacity(0.18),

                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          /// =========================
          /// PAGE VIEW
          /// =========================
          SafeArea(
            child: PageView.builder(

              controller: _controller,

              physics:
              const BouncingScrollPhysics(),

              itemCount: onboardingData.length,

              onPageChanged: (index) {

                setState(() {

                  isLastPage =
                      index == onboardingData.length - 1;
                });
              },

              itemBuilder: (context, index) {

                final item = onboardingData[index];

                return SingleChildScrollView(

                  physics:
                  const BouncingScrollPhysics(),

                  child: Padding(

                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                      vertical: size.height * 0.025,
                    ),

                    child: Column(

                      children: [

                        SizedBox(
                            height:
                            size.height * 0.02),

                        /// =========================
                        /// IMAGE CARD
                        /// =========================
                        Container(

                          width: double.infinity,

                          constraints: BoxConstraints(

                            maxHeight: isSmallDevice
                                ? size.height * 0.28
                                : size.height * 0.38,

                            minHeight: isSmallDevice
                                ? size.height * 0.25
                                : size.height * 0.30,
                          ),

                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(36),

                            gradient:
                            const LinearGradient(

                              begin:
                              Alignment.topLeft,

                              end:
                              Alignment.bottomRight,

                              colors: [

                                Color(0xFF101827),

                                Color(0xFF1E293B),

                                Color(0xFF243B55),
                              ],
                            ),

                            border: Border.all(

                              color:
                              const Color(0xFF2CE6A6)
                                  .withOpacity(0.30),

                              width: 1.2,
                            ),

                            boxShadow: [

                              BoxShadow(

                                color:
                                const Color(0xFF2CE6A6)
                                    .withOpacity(0.10),

                                blurRadius: 25,
                                spreadRadius: 1,
                              ),
                            ],
                          ),

                          child: ClipRRect(

                            borderRadius:
                            BorderRadius.circular(36),

                            child: Image.asset(

                              item["image"]!,

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(
                            height:
                            size.height * 0.045),

                        /// =========================
                        /// TITLE
                        /// =========================
                        Text(

                          item["title"]!,

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            color:
                                 const Color(0xFF2CE6A6),

                            fontSize: isSmallDevice
                                ? size.width * 0.075
                                : size.width * 0.085,

                            fontWeight:
                            FontWeight.bold,

                            height: 1.3,
                          ),
                        ),

                        /// =========================
                        /// DESIGNATION
                        /// =========================
                        if (item["designation"]!
                            .isNotEmpty)

                          Padding(

                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),

                            child: Text(

                              item["designation"]!,

                              style: TextStyle(

                                color: Colors.white70,

                                fontSize:
                                size.width * 0.042,

                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ),

                        SizedBox(
                            height:
                            size.height * 0.022),

                        /// =========================
                        /// SUBTITLE
                        /// =========================
                        Padding(

                          padding: EdgeInsets.symmetric(
                            horizontal:
                            size.width * 0.02,
                          ),

                          child: Text(

                            item["subtitle"]!,

                            textAlign: TextAlign.center,

                            style: TextStyle(

                              color:
                              const Color(0xFF94A3B8),

                              fontSize:
                              size.width * 0.040,

                              height: 1.7,
                            ),
                          ),
                        ),

                        SizedBox(
                            height:
                            size.height * 0.05),

                        /// =========================
                        /// PAGE INDICATOR
                        /// =========================
                        SmoothPageIndicator(

                          controller: _controller,

                          count:
                          onboardingData.length,

                          effect:
                          ExpandingDotsEffect(

                            dotHeight: 8,
                            dotWidth: 8,

                            activeDotColor:
                            const Color(0xFF2CE6A6),

                            dotColor: Colors.white24,
                          ),
                        ),

                        SizedBox(
                            height:
                            size.height * 0.045),

                        /// =========================
                        /// BUTTONS
                        /// =========================
                        Row(
                          children: [

                            /// SKIP BUTTON
                            Expanded(
                              child: GestureDetector(

                                onTap: () {

                                },

                                child: Container(

                                  height:
                                  isSmallDevice
                                      ? 52
                                      : 58,

                                  decoration:
                                  BoxDecoration(

                                    borderRadius:
                                    BorderRadius.circular(
                                        30),

                                    color:
                                    const Color(0xFF1E293B),
                                  ),

                                  child: Center(

                                    child: Text(

                                      "Skip",

                                      style: TextStyle(

                                        color:
                                        Colors.white,

                                        fontSize:
                                        size.width *
                                            0.043,

                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                                width:
                                size.width * 0.045),

                            /// NEXT BUTTON
                            Expanded(
                              child: GestureDetector(

                                onTap: () {

                                  if (!isLastPage) {

                                    _controller.nextPage(

                                      duration:
                                      const Duration(
                                          milliseconds:
                                          500),

                                      curve:
                                      Curves.easeInOut,
                                    );
                                  }
                                },

                                child: Container(

                                  height:
                                  isSmallDevice
                                      ? 52
                                      : 58,

                                  decoration:
                                  BoxDecoration(

                                    borderRadius:
                                    BorderRadius.circular(
                                        30),

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
                                        const Color(
                                            0xFF2CE6A6)
                                            .withOpacity(
                                            0.25),

                                        blurRadius: 18,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),

                                  child: Center(

                                    child: Text(

                                      isLastPage
                                          ? "Start"
                                          : "Next",

                                      style: TextStyle(

                                        color:
                                        Colors.white,

                                        fontSize:
                                        size.width *
                                            0.043,

                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height:
                            size.height * 0.03),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),);
  }
}