import 'dart:ui';

import 'package:flutter/material.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() =>
      _MeetingPageState();
}

class _MeetingPageState
    extends State<MeetingPage> {

  bool micOn = true;

  bool cameraOn = true;

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFF0B0618),

      body: SafeArea(

        child: Stack(
          children: [

            /// =========================
            /// BACKGROUND GLOW
            /// =========================
            Positioned(

              top: -120,
              left: -90,

              child: glowCircle(

                260,

                const Color(
                  0xFFB026FF,
                ),
              ),
            ),

            Positioned(

              bottom: -100,
              right: -80,

              child: glowCircle(

                240,

                const Color(
                  0xFF00E5FF,
                ),
              ),
            ),

            /// =========================
            /// MAIN BODY
            /// =========================
            Padding(

              padding:
              EdgeInsets.symmetric(

                horizontal:
                width * 0.05,

                vertical:
                height * 0.02,
              ),

              child: Column(

                children: [

                  /// =========================
                  /// TOP BAR
                  /// =========================
                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      topButton(
                        Icons.arrow_back_ios_new,
                            () {

                          Navigator.pop(
                            context,
                          );
                        },
                      ),

                      Column(
                        children: [

                          Text(

                            "Team Meeting",

                            style: TextStyle(

                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,

                              fontSize:
                              width * 0.055,
                            ),
                          ),

                          SizedBox(
                            height:
                            height * 0.005,
                          ),

                          Row(
                            children: [

                              Container(

                                height: 10,
                                width: 10,

                                decoration:
                                const BoxDecoration(

                                  shape:
                                  BoxShape.circle,

                                  color:
                                  Colors.greenAccent,
                                ),
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              Text(

                                "12 Members Online",

                                style: TextStyle(

                                  color:
                                  Colors.white60,

                                  fontSize:
                                  width * 0.032,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      topButton(
                        Icons.more_vert,
                            () {},
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    height * 0.03,
                  ),

                  /// =========================
                  /// MAIN SPEAKER
                  /// =========================
                  Expanded(

                    child: Column(
                      children: [

                        Expanded(

                          flex: 6,

                          child: ClipRRect(

                            borderRadius:
                            BorderRadius.circular(
                              35,
                            ),

                            child: Stack(
                              children: [

                                /// IMAGE
                                Container(

                                  width:
                                  double.infinity,

                                  decoration:
                                  const BoxDecoration(

                                    image:
                                    DecorationImage(

                                      image:
                                      AssetImage(
                                        "assets/images/meeting_bg.png",
                                      ),

                                      fit:
                                      BoxFit.cover,
                                    ),
                                  ),
                                ),

                                /// OVERLAY
                                Container(

                                  decoration:
                                  BoxDecoration(

                                    gradient:
                                    LinearGradient(

                                      begin:
                                      Alignment.topCenter,

                                      end:
                                      Alignment.bottomCenter,

                                      colors: [

                                        Colors.black.withOpacity(
                                          0.15,
                                        ),

                                        Colors.black.withOpacity(
                                          0.75,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /// USER INFO
                                Positioned(

                                  left:
                                  width * 0.05,

                                  bottom:
                                  height * 0.03,

                                  child: Column(

                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      Text(

                                        "Sazid Khandaker",

                                        style: TextStyle(

                                          color:
                                          Colors.white,

                                          fontWeight:
                                          FontWeight.bold,

                                          fontSize:
                                          width * 0.06,
                                        ),
                                      ),

                                      SizedBox(
                                        height:
                                        height * 0.005,
                                      ),

                                      Text(

                                        "Flutter Developer",

                                        style: TextStyle(

                                          color:
                                          Colors.white70,

                                          fontSize:
                                          width * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// LIVE INDICATOR
                                Positioned(

                                  top:
                                  width * 0.05,

                                  right:
                                  width * 0.05,

                                  child: Container(

                                    padding:
                                    const EdgeInsets.symmetric(

                                      horizontal: 16,
                                      vertical: 8,
                                    ),

                                    decoration:
                                    BoxDecoration(

                                      borderRadius:
                                      BorderRadius.circular(
                                        20,
                                      ),

                                      color:
                                      Colors.redAccent,
                                    ),

                                    child: Row(
                                      children: [

                                        Container(

                                          height: 8,
                                          width: 8,

                                          decoration:
                                          const BoxDecoration(

                                            shape:
                                            BoxShape.circle,

                                            color:
                                            Colors.white,
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        const Text(

                                          "LIVE",

                                          style: TextStyle(

                                            color:
                                            Colors.white,

                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height:
                          height * 0.025,
                        ),

                        /// =========================
                        /// PARTICIPANTS
                        /// =========================
                        SizedBox(

                          height:
                          height * 0.15,

                          child: ListView(

                            scrollDirection:
                            Axis.horizontal,

                            children: [

                              participantCard(
                                width,
                                "A",
                              ),

                              participantCard(
                                width,
                                "R",
                              ),

                              participantCard(
                                width,
                                "J",
                              ),

                              participantCard(
                                width,
                                "T",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height:
                          height * 0.02,
                        ),
                      ],
                    ),
                  ),

                  /// =========================
                  /// BOTTOM CONTROLS
                  /// =========================
                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(
                      35,
                    ),

                    child: BackdropFilter(

                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),

                      child: Container(

                        padding:
                        EdgeInsets.symmetric(

                          horizontal:
                          width * 0.05,

                          vertical:
                          height * 0.02,
                        ),

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(
                            35,
                          ),

                          color:
                          Colors.white.withOpacity(
                            0.08,
                          ),

                          border: Border.all(

                            color:
                            Colors.white.withOpacity(
                              0.08,
                            ),
                          ),
                        ),

                        child: Row(

                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            controlButton(

                              micOn
                                  ? Icons.mic
                                  : Icons.mic_off,

                              micOn
                                  ? const Color(
                                0xFF00E5FF,
                              )
                                  : Colors.redAccent,

                                  () {

                                setState(() {

                                  micOn =
                                  !micOn;
                                });
                              },
                            ),

                            controlButton(

                              cameraOn
                                  ? Icons.videocam
                                  : Icons.videocam_off,

                              cameraOn
                                  ? const Color(
                                0xFFB026FF,
                              )
                                  : Colors.redAccent,

                                  () {

                                setState(() {

                                  cameraOn =
                                  !cameraOn;
                                });
                              },
                            ),

                            controlButton(

                              Icons.screen_share,

                              Colors.orangeAccent,

                                  () {},
                            ),

                            controlButton(

                              Icons.call_end,

                              Colors.redAccent,

                                  () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// PARTICIPANT CARD
  /// =========================
  Widget participantCard(
      double width,
      String name,
      ) {

    return Container(

      width:
      width * 0.28,

      margin:
      const EdgeInsets.only(
        right: 15,
      ),

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(28),

        image:
        const DecorationImage(

          image:
          AssetImage(
            "assets/images/profile.jpg",
          ),

          fit:
          BoxFit.cover,
        ),
      ),

      child: Container(

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(28),

          gradient:
          LinearGradient(

            begin:
            Alignment.topCenter,

            end:
            Alignment.bottomCenter,

            colors: [

              Colors.transparent,

              Colors.black.withOpacity(
                0.75,
              ),
            ],
          ),
        ),

        child: Align(

          alignment:
          Alignment.bottomLeft,

          child: Padding(

            padding:
            const EdgeInsets.all(14),

            child: Text(

              name,

              style: const TextStyle(

                color:
                Colors.white,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// CONTROL BUTTON
  /// =========================
  Widget controlButton(
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        height: 62,
        width: 62,

        decoration: BoxDecoration(

          shape:
          BoxShape.circle,

          color:
          color.withOpacity(0.15),

          border: Border.all(

            color:
            color.withOpacity(0.35),
          ),

          boxShadow: [

            BoxShadow(

              color:
              color.withOpacity(0.25),

              blurRadius: 25,
            ),
          ],
        ),

        child: Icon(

          icon,

          color: color,
        ),
      ),
    );
  }

  /// =========================
  /// TOP BUTTON
  /// =========================
  Widget topButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: ClipRRect(

        borderRadius:
        BorderRadius.circular(18),

        child: BackdropFilter(

          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),

          child: Container(

            height: 52,
            width: 52,

            decoration: BoxDecoration(

              borderRadius:
              BorderRadius.circular(
                18,
              ),

              color:
              Colors.white.withOpacity(
                0.08,
              ),

              border: Border.all(

                color:
                Colors.white.withOpacity(
                  0.08,
                ),
              ),
            ),

            child: Icon(

              icon,

              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// GLOW
  /// =========================
  Widget glowCircle(
      double size,
      Color color,
      ) {

    return Container(

      height: size,
      width: size,

      decoration: BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        color.withOpacity(0.20),

        boxShadow: [

          BoxShadow(

            color:
            color.withOpacity(0.45),

            blurRadius: 120,
          ),
        ],
      ),
    );
  }
}