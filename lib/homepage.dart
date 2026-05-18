import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/bottomnavbar/Calander.dart' show CalendarPage;
import 'package:office_meet/bottomnavbar/addmeeting.dart' show MeetingPage;
import 'package:office_meet/bottomnavbar/profile.dart' show ProfilePage;
import 'package:office_meet/bottomnavbar/meetingdate.dart' show MeetingBookingPage;


class HomePage extends StatefulWidget {
  final int selectedIndex;

  const HomePage({

    super.key,

    this.selectedIndex = 0,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  @override
  void initState() {

    super.initState();

    currentIndex =
        widget.selectedIndex;
  }

  final user =
      FirebaseAuth.instance.currentUser;

  late int currentIndex;

  String userName = "User";

  bool isLoading = true;

  final List<Widget> pages = [

    const HomeContent(),

    const CalendarPage(),

    const MeetingBookingPage(),

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
/// ======================================================
/// HOME CONTENT
/// ======================================================

class HomeContent extends StatefulWidget {

  const HomeContent({
    super.key,
  });

  @override
  State<HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState
    extends State<HomeContent> {

  String userName = "User";

  String profileImage = "";

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    getUserData();
  }

  /// =========================
  /// GET USER DATA
  /// =========================
  Future<void> getUserData()
  async {

    try {

      final uid =
          FirebaseAuth
              .instance
              .currentUser!
              .uid;

      FirebaseFirestore
          .instance
          .collection("users")
          .doc(uid)
          .snapshots()
          .listen((userData) {

        if (userData.exists) {

          setState(() {

            userName =
                userData["fullName"] ??
                    "User";

            profileImage =
                userData["profileImage"] ??
                    "";

            isLoading = false;
          });
        }
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final height =
        MediaQuery.of(context)
            .size
            .height;

    return SafeArea(

      child:

      isLoading

          ? Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            SizedBox(

              height: 70,
              width: 70,

              child:
              CircularProgressIndicator(

                strokeWidth: 5,

                color:
                const Color(
                  0xFFD9FF00,
                ),
              ),
            ),

            SizedBox(
              height:
              height * 0.03,
            ),

            Text(

              "Loading Workspace...",

              style: TextStyle(

                color:
                Colors.white70,

                fontSize:
                width * 0.045,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ],
        ),
      )

          : SingleChildScrollView(

        physics:
        const BouncingScrollPhysics(),

        child: Padding(

          padding:
          EdgeInsets.symmetric(

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

                      /// =========================
                      /// REALTIME PROFILE IMAGE
                      /// =========================
                      Container(

                        padding:
                        const EdgeInsets.all(
                          2,
                        ),

                        decoration:
                        BoxDecoration(

                          shape:
                          BoxShape.circle,

                          border:
                          Border.all(

                            color:
                            const Color(
                              0xFFD9FF00,
                            ),

                            width: 2,
                          ),
                        ),

                        child:
                        CircleAvatar(

                          radius:
                          width * 0.06,

                          backgroundColor:
                          Colors.grey
                              .shade900,

                          backgroundImage:

                          profileImage
                              .isNotEmpty

                              ? NetworkImage(
                            profileImage,
                          )

                              : null,

                          child:

                          profileImage
                              .isEmpty

                              ? Icon(

                            Icons.person,

                            color:
                            Colors.white,

                            size:
                            width * 0.07,
                          )

                              : null,
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

                      text:
                      "Hello, ",

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
                  Colors.white
                      .withOpacity(
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

                      icon:
                      Icons.search,

                      width:
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "CEO",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Nurion Lab",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "IT",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "UI/UX",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Digital Marketing",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "HR Department",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Account & Finance",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Business Development",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Nurion Studio",
                      width,
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    categoryChip(
                      "Other Department",
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

                "My Schedule",

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
              /// REALTIME MEETING LIST
              /// =========================
              SizedBox(

                height:
                height * 0.4,

                child:
                StreamBuilder<QuerySnapshot>(

                  stream:
                  FirebaseFirestore
                      .instance
                      .collection("meetings")
                      .where(

                    "fullName",

                    isEqualTo:
                    userName,
                  )
                      .snapshots(),

                  builder:
                      (
                      context,
                      snapshot,
                      ) {

                    /// LOADING
                    if (!snapshot
                        .hasData) {

                      return const Center(

                        child:
                        CircularProgressIndicator(
                          color:
                          Colors.white,
                        ),
                      );
                    }

                    final meetings =
                        snapshot.data!.docs;

                    /// NO DATA
                    if (meetings.isEmpty) {

                      return Container(

                        width:
                        double.infinity,

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(
                            32,
                          ),

                          color:
                          Colors.white
                              .withOpacity(
                            0.05,
                          ),
                        ),

                        child: Column(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Icon(

                              Icons.calendar_month,

                              color:
                              Colors.white24,

                              size: 70,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            const Text(

                              "No Meeting Scheduled",

                              style: TextStyle(

                                color:
                                Colors.white70,

                                fontSize: 18,

                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    /// =========================
                    /// HORIZONTAL LISTVIEW
                    /// =========================
                    return ListView.builder(

                      scrollDirection:
                      Axis.horizontal,

                      physics:
                      const BouncingScrollPhysics(),

                      itemCount:
                      meetings.length,

                      itemBuilder:
                          (
                          context,
                          index,
                          ) {

                        final data =
                        meetings[index]
                            .data()
                        as Map<String,
                            dynamic>;

                        return Container(

                          width:
                          width * 0.82,

                          margin:
                          EdgeInsets.only(

                            right:
                            width * 0.04,
                          ),

                          decoration:
                          BoxDecoration(

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

                            decoration:
                            BoxDecoration(

                              borderRadius:
                              BorderRadius.circular(
                                32,
                              ),

                              gradient:
                              LinearGradient(

                                begin:
                                Alignment
                                    .topCenter,

                                end:
                                Alignment
                                    .bottomCenter,

                                colors: [

                                  Colors.black
                                      .withOpacity(
                                    0.15,
                                  ),

                                  Colors.black
                                      .withOpacity(
                                    0.80,
                                  ),
                                ],
                              ),
                            ),

                            child: Column(

                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                /// TOP
                                Row(

                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

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
                                            Colors.white
                                                .withOpacity(
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
                                          CrossAxisAlignment
                                              .start,

                                          children: [

                                            Text(

                                              data["meetingDate"],

                                              style:
                                              TextStyle(

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

                                              "${data["startTime"]} - ${data["endTime"]}",

                                              style:
                                              TextStyle(

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

                                        border:
                                        Border.all(

                                          color:
                                          Colors.white24,
                                        ),
                                      ),

                                      child: Icon(

                                        Icons
                                            .arrow_outward_rounded,

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

                                  data["department"],

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
                                  CrossAxisAlignment
                                      .start,

                                  children: [
                                    /// =========================
                                    /// USER INFO
                                    /// =========================
                                    Row(
                                      children: [

                                        Text(

                                          userName,

                                          maxLines: 1,

                                          overflow:
                                          TextOverflow.ellipsis,

                                          style: TextStyle(

                                            color:
                                            Colors.white70,

                                            fontWeight:
                                            FontWeight.w600,

                                            fontSize:
                                            width * 0.038,
                                          ),
                                        ),

                                       SizedBox(width: width* 0.02,),

                                        CircleAvatar(

                                          radius:
                                          width * 0.042,

                                          backgroundColor:
                                          Colors.white
                                              .withOpacity(
                                            0.12,
                                          ),

                                          backgroundImage:

                                          profileImage.isNotEmpty

                                              ? NetworkImage(
                                            profileImage,
                                          )

                                              : null,

                                          child:

                                          profileImage.isEmpty

                                              ? Icon(

                                            Icons.person,

                                            color:
                                            Colors.white,

                                            size:
                                            width * 0.04,
                                          )

                                              : null,
                                        ),
                                      ],
                                    ),


                                    Text(

                                      "Joined Members",

                                      style:
                                      TextStyle(

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

                                    Text(

                                      "${data["members"]} Members",

                                      style:
                                      TextStyle(

                                        color:
                                        const Color(
                                          0xFFD9FF00,
                                        ),

                                        fontWeight:
                                        FontWeight.bold,

                                        fontSize:
                                        width * 0.045,
                                      ),
                                    ),
                                  ],
                                ),

                                /// BOTTOM

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
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

  /// =========================
  /// CATEGORY CHIP
  /// =========================
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

      decoration:
      BoxDecoration(

        borderRadius:
        BorderRadius.circular(
          24,
        ),

        border:
        Border.all(

          color:
          Colors.white
              .withOpacity(
            0.10,
          ),
        ),

        color:
        Colors.white
            .withOpacity(
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

  /// =========================
  /// SEARCH CIRCLE
  /// =========================
  Widget glassCategory({

    required IconData icon,

    required double width,
  }) {

    return Container(

      height:
      width * 0.14,

      width:
      width * 0.14,

      decoration:
      BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        Colors.white
            .withOpacity(
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

  /// =========================
  /// TOP BUTTON
  /// =========================
  Widget glassCircleButton({

    required IconData icon,

    required double size,
  }) {

    return Container(

      height: size,
      width: size,

      decoration:
      BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        Colors.white
            .withOpacity(
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
}