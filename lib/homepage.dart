import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/bottomnavbar/Calander.dart' show CalendarPage;
import 'package:office_meet/bottomnavbar/addmeeting.dart' show MeetingPage;
import 'package:office_meet/bottomnavbar/profile.dart' show ProfilePage;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  final user =
      FirebaseAuth.instance.currentUser;

  int currentIndex = 0;

  String userName = "User";

  bool isLoading = true;

  final List<Widget> pages = [

    const HomeContent(),

    const CalendarPage(),

    const MeetingPage(),

    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
      
        backgroundColor:
        const Color(0xFF020617),
      
        extendBody: true,
      
        body: IndexedStack(
      
          index: currentIndex,
      
          children: pages,
        ),
      
        /// =========================
        /// FLOATING NAVIGATION BAR
        /// =========================
        bottomNavigationBar: Padding(
      
          padding: EdgeInsets.only(
      
            left: width * 0.05,
      
            right: width * 0.05,
      
            bottom: height * 0.025,
          ),
      
          child: Container(
      
            height: height * 0.09,
      
            decoration: BoxDecoration(
      
              color:
              Colors.white.withOpacity(
                0.06,
              ),
      
              borderRadius:
              BorderRadius.circular(
                40,
              ),
      
              border: Border.all(
      
                color:
                Colors.white.withOpacity(
                  0.08,
                ),
              ),
      
              boxShadow: [
      
                BoxShadow(
      
                  color:
                  Colors.black.withOpacity(
                    0.25,
                  ),
      
                  blurRadius: 25,
      
                  offset:
                  const Offset(0, 10),
                ),
              ],
            ),
      
            child: Row(
      
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
      
              children: [
      
                navItem(
                  0,
                  Icons.home_rounded,
                ),
      
                navItem(
                  1,
                  Icons.calendar_month_rounded,
                ),
      
                navItem(
                  2,
                  Icons.video_call_rounded,
                ),
      
                navItem(
                  3,
                  Icons.person_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// NAV ITEM
  /// =========================
  Widget navItem(
      int index,
      IconData icon,
      ) {

    final isSelected =
        currentIndex == index;

    return GestureDetector(

      onTap: () {

        setState(() {

          currentIndex = index;
        });
      },

      child: AnimatedContainer(

        duration:
        const Duration(
          milliseconds: 250,
        ),

        height:
        isSelected ? 58 : 48,

        width:
        isSelected ? 58 : 48,

        decoration: BoxDecoration(

          shape:
          BoxShape.circle,

          gradient: isSelected

              ? const LinearGradient(

            colors: [

              Color(0xFFD9FF00),

              Color(0xFFB6FF00),
            ],
          )

              : null,

          color: isSelected
              ? null
              : Colors.transparent,

          boxShadow: isSelected

              ? [

            BoxShadow(

              color:
              const Color(
                0xFFD9FF00,
              ).withOpacity(0.4),

              blurRadius: 18,
            ),
          ]

              : [],
        ),

        child: Icon(

          icon,

          color: isSelected

              ? Colors.black

              : Colors.white,

          size: 28,
        ),
      ),
    );
  }
}

/// ======================================================
/// HOME CONTENT
/// ======================================================
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState
    extends State<HomeContent> {

  String userName = "User";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  /// =========================
  /// GET USER DATA
  /// =========================
  Future<void> getUserData() async {

    try {

      final uid =
          FirebaseAuth.instance.currentUser!.uid;

      final userData =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (userData.exists) {

        setState(() {

          userName =
          userData["fullName"];

          isLoading = false;
        });
      }

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return SafeArea(

      child: SingleChildScrollView(

        physics:
        const BouncingScrollPhysics(),

        child: Padding(

          padding: EdgeInsets.symmetric(

            horizontal:
            width * 0.05,

            vertical:
            height * 0.02,
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
                        width:
                        width * 0.03,
                      ),

                      Container(

                        padding:
                        const EdgeInsets.all(2),

                        decoration: BoxDecoration(

                          shape:
                          BoxShape.circle,

                          border: Border.all(

                            color:
                            const Color(
                              0xFFD9FF00,
                            ),

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

                            color:
                            Colors.white,

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
                height:
                height * 0.04,
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

                        color:
                        Colors.white,

                        fontSize:
                        width * 0.10,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    TextSpan(

                      text:
                      userName,

                      style: TextStyle(

                        color:
                        const Color(
                          0xFFD9FF00,
                        ),

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
                height:
                height * 0.01,
              ),

              Text(

                "Welcome back to Acote workspace",

                style: TextStyle(

                  color:
                  Colors.white.withOpacity(
                    0.6,
                  ),

                  fontSize:
                  width * 0.040,
                ),
              ),

              SizedBox(
                height:
                height * 0.035,
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
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "HRD Meeting",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Developer Team",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Workspace",
                      width,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height:
                height * 0.04,
              ),

              /// =========================
              /// TITLE
              /// =========================
              Text(

                "My Task",

                style: TextStyle(

                  color:
                  Colors.white,

                  fontSize:
                  width * 0.075,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              SizedBox(
                height:
                height * 0.025,
              ),

              /// =========================
              /// TASK CARD
              /// =========================
              Container(

                height:
                height * 0.60,

                width:
                double.infinity,

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(
                    32,
                  ),

                  image:
                  const DecorationImage(

                    image:
                    AssetImage(
                      "assets/images/meeting.png",
                    ),

                    fit:
                    BoxFit.cover,
                  ),
                ),

                child: Container(

                  padding:
                  EdgeInsets.all(
                    width * 0.06,
                  ),

                  decoration: BoxDecoration(

                    borderRadius:
                    BorderRadius.circular(
                      32,
                    ),

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
                          0.80,
                        ),
                      ],
                    ),
                  ),

                  child: Column(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      /// TOP
                      Row(

                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                        children: [

                          Row(
                            children: [

                              Container(

                                height:
                                width * 0.12,

                                width:
                                width * 0.12,

                                decoration:
                                BoxDecoration(

                                  shape:
                                  BoxShape.circle,

                                  color:
                                  Colors.white.withOpacity(
                                    0.12,
                                  ),
                                ),

                                child: Icon(

                                  Icons
                                      .calendar_today_rounded,

                                  color:
                                  Colors.white,

                                  size:
                                  width * 0.05,
                                ),
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
                                      Colors.white70,

                                      fontSize:
                                      width * 0.03,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Text(

                                    "10:00 - 11:00 AM",

                                    style: TextStyle(

                                      color:
                                      Colors.white,

                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize:
                                      width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Container(

                            height:
                            width * 0.12,

                            width:
                            width * 0.12,

                            decoration:
                            BoxDecoration(

                              shape:
                              BoxShape.circle,

                              border: Border.all(

                                color:
                                Colors.white24,
                              ),
                            ),

                            child: Icon(

                              Icons.arrow_outward_rounded,

                              color:
                              Colors.white,

                              size:
                              width * 0.055,
                            ),
                          ),
                        ],
                      ),

                      /// TITLE
                      Text(

                        "Development\nSprint Team\nMeeting",

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                          height: 1,

                          fontSize:
                          width * 0.085,
                        ),
                      ),

                      /// MEMBERS
                      Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(

                            "Joined Members",

                            style: TextStyle(

                              color:
                              Colors.white70,

                              fontSize:
                              width * 0.035,
                            ),
                          ),

                          SizedBox(
                            height:
                            height * 0.015,
                          ),

                          Row(
                            children: [

                              memberImage(
                                "assets/images/p1.jpg",
                              ),

                              memberImage(
                                "assets/images/p2.jpg",
                              ),

                              memberImage(
                                "assets/images/p3.jpg",
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// BOTTOM
                      Container(

                        padding:
                        EdgeInsets.symmetric(

                          horizontal:
                          width * 0.05,

                          vertical:
                          height * 0.018,
                        ),

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),

                          color:
                          Colors.black.withOpacity(
                            0.35,
                          ),
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

                                fontWeight:
                                FontWeight.w500,

                                fontSize:
                                width * 0.04,
                              ),
                            ),

                            Text(

                              "80%",

                              style: TextStyle(

                                color:
                                const Color(
                                  0xFFD9FF00,
                                ),

                                fontWeight:
                                FontWeight.bold,

                                fontSize:
                                width * 0.06,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height:
                height * 0.14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryChip(
      String title,
      double width,
      ) {

    return Container(

      padding:
      EdgeInsets.symmetric(

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
          Colors.white.withOpacity(
            0.10,
          ),
        ),

        color:
        Colors.white.withOpacity(
          0.03,
        ),
      ),

      child: Text(

        title,

        style: TextStyle(

          color:
          Colors.white,

          fontWeight:
          FontWeight.w600,

          fontSize:
          width * 0.035,
        ),
      ),
    );
  }

  Widget glassCategory({

    required IconData icon,

    required double width,
  }) {

    return Container(

      height:
      width * 0.14,

      width:
      width * 0.14,

      decoration: BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        Colors.white.withOpacity(
          0.06,
        ),
      ),

      child: Icon(

        icon,

        color:
        Colors.white,

        size:
        width * 0.06,
      ),
    );
  }

  Widget glassCircleButton({

    required IconData icon,

    required double size,
  }) {

    return Container(

      height: size,
      width: size,

      decoration: BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        Colors.white.withOpacity(
          0.06,
        ),
      ),

      child: Icon(

        icon,

        color:
        Colors.white,

        size:
        size * 0.42,
      ),
    );
  }

  Widget memberImage(
      String image,
      ) {

    return Transform.translate(

      offset:
      const Offset(-10, 0),

      child: CircleAvatar(

        radius: 20,

        backgroundColor:
        Colors.black,

        backgroundImage:
        AssetImage(image),
      ),
    );
  }
}