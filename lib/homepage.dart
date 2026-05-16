import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(

        child: SingleChildScrollView(

          physics:
          const BouncingScrollPhysics(),

          padding: EdgeInsets.symmetric(

            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// =========================
              /// TOP BAR
              /// =========================
              Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  /// MENU
                  glassCircleButton(

                    icon:
                    Icons.menu_rounded,

                    size:
                    width * 0.14,
                  ),

                  Row(
                    children: [

                      glassCircleButton(

                        icon:
                        Icons.notifications_none_rounded,

                        size:
                        width * 0.14,
                      ),

                      SizedBox(
                        width: width * 0.03,
                      ),

                      /// PROFILE
                      Container(

                        padding:
                        const EdgeInsets.all(2),

                        decoration: BoxDecoration(

                          shape:
                          BoxShape.circle,

                          border: Border.all(

                            color:
                            const Color(0xFFD9FF00),

                            width: 2,
                          ),
                        ),

                        child: CircleAvatar(

                          radius:
                          width * 0.06,

                          backgroundColor:
                          Colors.grey.shade800,

                          child: Icon(

                            Icons.person,

                            color: Colors.white,

                            size:
                            width * 0.07,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: height * 0.04,
              ),

              /// =========================
              /// HELLO TEXT
              /// =========================
              RichText(

                text: TextSpan(

                  children: [

                    TextSpan(

                      text: "Hello, ",

                      style: TextStyle(

                        color: Colors.white,

                        fontSize:
                        width * 0.10,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    TextSpan(

                      text: "Sazid",

                      style: TextStyle(

                        color:
                        const Color(0xFFD9FF00),

                        fontSize:
                        width * 0.10,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: height * 0.01,
              ),

              Text(

                "Welcome back to Acote workspace",

                style: TextStyle(

                  color:
                  Colors.white.withOpacity(0.6),

                  fontSize:
                  width * 0.040,
                ),
              ),

              SizedBox(
                height: height * 0.035,
              ),

              /// =========================
              /// CATEGORY
              /// =========================
              SingleChildScrollView(

                scrollDirection:
                Axis.horizontal,

                child: Row(
                  children: [

                    glassCategory(
                      icon: Icons.search,
                      width: width,
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    categoryChip(
                      "HRD Meeting",
                      width,
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    categoryChip(
                      "Developer Team",
                      width,
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    categoryChip(
                      "Acote Workspace",
                      width,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: height * 0.04,
              ),

              /// =========================
              /// TITLE
              /// =========================
              Text(

                "My Task",

                style: TextStyle(

                  color: Colors.white,

                  fontSize:
                  width * 0.075,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              SizedBox(
                height: height * 0.025,
              ),

              /// =========================
              /// MAIN CARD
              /// =========================
              Container(

                height: height * 0.58,

                width: double.infinity,

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(38),

                  gradient:
                  LinearGradient(

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: [

                      Colors.white.withOpacity(0.12),

                      Colors.white.withOpacity(0.03),
                    ],
                  ),

                  border: Border.all(

                    color:
                    Colors.white.withOpacity(0.08),
                  ),
                ),

                child: ClipRRect(

                  borderRadius:
                  BorderRadius.circular(38),

                  child: BackdropFilter(

                    filter: ImageFilter.blur(
                      sigmaX: 25,
                      sigmaY: 25,
                    ),

                    child: Stack(
                      children: [

                        /// GLOW
                        Positioned(

                          top: -60,
                          right: -30,

                          child: Container(

                            height:
                            width * 0.45,

                            width:
                            width * 0.45,

                            decoration: BoxDecoration(

                              shape:
                              BoxShape.circle,

                              color:
                              Colors.white.withOpacity(0.06),
                            ),
                          ),
                        ),

                        Padding(

                          padding: EdgeInsets.all(
                            width * 0.06,
                          ),

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              /// TOP ROW
                              Row(

                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                                children: [

                                  Row(
                                    children: [

                                      glassCircleButton(

                                        icon:
                                        Icons.calendar_today_rounded,

                                        size:
                                        width * 0.13,
                                      ),

                                      SizedBox(
                                        width:
                                        width * 0.03,
                                      ),

                                      Column(

                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                        children: [

                                          Text(

                                            "May 22, 2025",

                                            style: TextStyle(

                                              color:
                                              Colors.white.withOpacity(0.6),

                                              fontSize:
                                              width * 0.032,
                                            ),
                                          ),

                                          SizedBox(
                                            height:
                                            height * 0.005,
                                          ),

                                          Text(

                                            "10:00 - 11:00 AM",

                                            style: TextStyle(

                                              color:
                                              Colors.white,

                                              fontWeight:
                                              FontWeight.bold,

                                              fontSize:
                                              width * 0.040,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Container(

                                    height:
                                    width * 0.13,

                                    width:
                                    width * 0.13,

                                    decoration: BoxDecoration(

                                      shape:
                                      BoxShape.circle,

                                      border: Border.all(

                                        color:
                                        Colors.white.withOpacity(0.15),
                                      ),
                                    ),

                                    child: Icon(

                                      Icons.arrow_outward_rounded,

                                      color: Colors.white,

                                      size:
                                      width * 0.06,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: height * 0.04,
                              ),

                              /// TITLE
                              Text(

                                "Development\nSprint Team\nMeeting",

                                style: TextStyle(

                                  color: Colors.white,

                                  height: 1.1,

                                  fontSize:
                                  width * 0.10,

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const Spacer(),

                              /// MEMBERS
                              Text(

                                "Joined Members",

                                style: TextStyle(

                                  color:
                                  Colors.white.withOpacity(0.7),

                                  fontSize:
                                  width * 0.040,
                                ),
                              ),

                              SizedBox(
                                height: height * 0.018,
                              ),

                              Row(
                                children: [

                                  memberAvatar(
                                    "A",
                                    width,
                                  ),

                                  memberAvatar(
                                    "S",
                                    width,
                                  ),

                                  memberAvatar(
                                    "R",
                                    width,
                                  ),

                                  Container(


                                    transform:
                                    Matrix4.translationValues(
                                    -width * 0.03,
                                    0,
                                    0,
                                  ),

                                    height:
                                    width * 0.11,

                                    width:
                                    width * 0.11,

                                    decoration: BoxDecoration(

                                      shape:
                                      BoxShape.circle,

                                      color:
                                      Colors.grey.shade700,

                                      border: Border.all(

                                        color:
                                        Colors.black,

                                        width: 2,
                                      ),
                                    ),

                                    child: Center(

                                      child: Text(

                                        "+10",

                                        style: TextStyle(

                                          color:
                                          Colors.white,

                                          fontWeight:
                                          FontWeight.bold,

                                          fontSize:
                                          width * 0.030,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: height * 0.03,
                              ),

                              /// BOTTOM BAR
                              Container(

                                padding:
                                EdgeInsets.symmetric(

                                  horizontal:
                                  width * 0.05,

                                  vertical:
                                  height * 0.022,
                                ),

                                decoration: BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(24),

                                  color:
                                  Colors.white.withOpacity(0.06),
                                ),

                                child: Row(

                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                                  children: [

                                    Text(

                                      "Work in Progress",

                                      style: TextStyle(

                                        color:
                                        Colors.white,

                                        fontSize:
                                        width * 0.045,

                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),

                                    Text(

                                      "80%",

                                      style: TextStyle(

                                        color:
                                        const Color(0xFFD9FF00),

                                        fontSize:
                                        width * 0.07,

                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.035,
              ),

              /// =========================
              /// BOTTOM NAV
              /// =========================
              Container(

                padding: EdgeInsets.symmetric(

                  horizontal:
                  width * 0.03,

                  vertical:
                  height * 0.015,
                ),

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(35),

                  color:
                  Colors.white.withOpacity(0.05),
                ),

                child: Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

                  children: [

                    bottomItem(
                      0,
                      Icons.home_outlined,
                      width,
                    ),

                    bottomItem(
                      1,
                      Icons.calendar_month_rounded,
                      width,
                    ),

                    bottomItem(
                      2,
                      Icons.chat_bubble_outline_rounded,
                      width,
                    ),

                    bottomItem(
                      3,
                      Icons.groups_rounded,
                      width,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// CATEGORY CHIP
  /// =========================
  Widget categoryChip(
      String title,
      double width,
      ) {

    return Container(

      padding: EdgeInsets.symmetric(

        horizontal:
        width * 0.055,

        vertical:
        width * 0.04,
      ),

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(

          color:
          Colors.white.withOpacity(0.10),
        ),

        color:
        Colors.white.withOpacity(0.03),
      ),

      child: Text(

        title,

        style: TextStyle(

          color: Colors.white,

          fontWeight: FontWeight.w600,

          fontSize:
          width * 0.035,
        ),
      ),
    );
  }

  /// =========================
  /// GLASS CATEGORY
  /// =========================
  Widget glassCategory({

    required IconData icon,

    required double width,
  }) {

    return Container(

      height: width * 0.14,
      width: width * 0.14,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color:
        Colors.white.withOpacity(0.06),
      ),

      child: Icon(

        icon,

        color: Colors.white,

        size: width * 0.06,
      ),
    );
  }

  /// =========================
  /// GLASS BUTTON
  /// =========================
  Widget glassCircleButton({

    required IconData icon,

    required double size,
  }) {

    return Container(

      height: size,
      width: size,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color:
        Colors.white.withOpacity(0.06),
      ),

      child: Icon(

        icon,

        color: Colors.white,

        size: size * 0.42,
      ),
    );
  }

  /// =========================
  /// MEMBER
  /// =========================
  Widget memberAvatar(
      String text,
      double width,
      ) {

    return Transform.translate(

      offset: Offset(
        -width * 0.03,
        0,
      ),

      child: Container(

        height:
        width * 0.11,

        width:
        width * 0.11,

        decoration: BoxDecoration(

          shape:
          BoxShape.circle,

          color:
          const Color(0xFFD9FF00),

          border: Border.all(

            color: Colors.black,
            width: 2,
          ),
        ),

        child: Center(

          child: Text(

            text,

            style: TextStyle(

              color: Colors.black,

              fontWeight:
              FontWeight.bold,

              fontSize:
              width * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// BOTTOM ITEM
  /// =========================
  Widget bottomItem(
      int index,
      IconData icon,
      double width,
      ) {

    final isSelected =
        currentIndex == index;

    return GestureDetector(

      onTap: () {

        setState(() {

          currentIndex = index;
        });
      },

      child: Container(

        height:
        width * 0.14,

        width:
        width * 0.14,

        decoration: BoxDecoration(

          shape:
          BoxShape.circle,

          color: isSelected

              ? const Color(0xFFD9FF00)

              : Colors.white.withOpacity(0.05),
        ),

        child: Icon(

          icon,

          color: isSelected

              ? Colors.black

              : Colors.white,

          size:
          width * 0.06,
        ),
      ),
    );
  }
}