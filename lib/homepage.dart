import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/bottomnavbar/Calander.dart' show CalendarPage;
import 'package:office_meet/bottomnavbar/addmeeting.dart' show MeetingPage;
import 'package:office_meet/bottomnavbar/profile.dart' show ProfilePage;
import 'package:office_meet/bottomnavbar/meetingdate.dart' show MeetingBookingPage;
import 'package:office_meet/department_meetings_page.dart' show DepartmentMeetingsPage;
import 'package:office_meet/profile/drawerpage.dart' show AppDrawer;
import 'package:office_meet/workspace/employee_details_page.dart' show EmployeeDetailsPage;


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
  String profileImage = "";
  @override
  void initState() {
    getUserData();

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
  Future<void> getUserData() async {

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
                userData["fullName"]
                    ?? "User";

            profileImage =
                userData["profileImage"]
                    ?? "";
          });
        }
      });

    } catch (e) {

      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    /// =========================
    /// WORKSPACE SEARCH
    /// =========================
    void showWorkspaceSearch() {

      final searchController =
      TextEditingController();

      showModalBottomSheet(

        context: context,

        isScrollControlled: true,

        backgroundColor:
        Colors.transparent,

        builder: (context) {

          final width =
              MediaQuery.of(context)
                  .size
                  .width;

          final height =
              MediaQuery.of(context)
                  .size
                  .height;

          return StatefulBuilder(

            builder:
                (context, setState) {

              return Container(

                height:
                height * 0.85,

                padding:
                EdgeInsets.all(
                  width * 0.05,
                ),

                decoration:
                const BoxDecoration(

                  color:
                  Color(0xFF090014),

                  borderRadius:
                  BorderRadius.vertical(

                    top:
                    Radius.circular(
                      35,
                    ),
                  ),
                ),

                child: Column(

                  children: [

                    /// TOP BAR
                    Container(

                      width:
                      width * 0.18,

                      height: 5,

                      decoration:
                      BoxDecoration(

                        borderRadius:
                        BorderRadius.circular(
                          50,
                        ),

                        color:
                        Colors.white24,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.03,
                    ),

                    /// SEARCH FIELD
                    TextField(

                      controller:
                      searchController,

                      onChanged: (_) {

                        setState(() {});
                      },

                      style:
                      const TextStyle(

                        color:
                        Colors.white,
                      ),

                      decoration:
                      InputDecoration(

                        hintText:

                        "Search employees, meetings, departments...",

                        hintStyle:
                        const TextStyle(

                          color:
                          Colors.white54,
                        ),

                        prefixIcon:
                        const Icon(

                          Icons.search,

                          color:
                          Colors.white70,
                        ),

                        filled: true,

                        fillColor:
                        Colors.white
                            .withOpacity(
                          0.06,
                        ),

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(
                            22,
                          ),

                          borderSide:
                          BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.03,
                    ),

                    /// RESULTS
                    Expanded(

                      child:
                      StreamBuilder(

                        stream:
                        FirebaseFirestore
                            .instance
                            .collection(
                          "users",
                        )
                            .snapshots(),

                        builder:
                            (context, snapshot) {

                          if (!snapshot
                              .hasData) {

                            return const Center(

                              child:
                              CircularProgressIndicator(),
                            );
                          }

                          final users =
                              snapshot.data!
                                  .docs;

                          final query =

                          searchController
                              .text
                              .toLowerCase();

                          final filtered =

                          users.where((doc) {

                            final data =
                            doc.data();

                            final name =

                            data["fullName"]
                                .toString()
                                .toLowerCase();

                            final dept =

                            data["department"]
                                .toString()
                                .toLowerCase();

                            final designation =

                            data["designation"]
                                .toString()
                                .toLowerCase();

                            return

                              name.contains(
                                query,
                              )

                                  ||

                                  dept.contains(
                                    query,
                                  )

                                  ||

                                  designation.contains(
                                    query,
                                  );
                          }).toList();

                          if (filtered.isEmpty) {

                            return const Center(

                              child: Text(

                                "No Results Found",

                                style: TextStyle(

                                  color:
                                  Colors.white70,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(

                            physics:
                            const BouncingScrollPhysics(),

                            itemCount:
                            filtered.length,

                            itemBuilder:
                                (context, index) {

                              final data =
                              filtered[index]
                                  .data();

                              final image =

                                  data["profileImage"]
                                      ?? "";

                              return Container(

                                margin:
                                EdgeInsets.only(

                                  bottom:
                                  height * 0.02,
                                ),

                                padding:
                                EdgeInsets.all(
                                  width * 0.04,
                                ),

                                decoration:
                                BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(
                                    24,
                                  ),

                                  color:
                                  Colors.white
                                      .withOpacity(
                                    0.05,
                                  ),

                                  border:
                                  Border.all(

                                    color:
                                    Colors.white
                                        .withOpacity(
                                      0.06,
                                    ),
                                  ),
                                ),

                                child: Row(

                                  children: [

                                    /// AVATAR
                                    CircleAvatar(

                                      radius:
                                      width * 0.07,

                                      backgroundColor:
                                      Colors.white
                                          .withOpacity(
                                        0.08,
                                      ),

                                      backgroundImage:

                                      image
                                          .toString()
                                          .isNotEmpty

                                          ? NetworkImage(
                                        image,
                                      )

                                          : null,

                                      child:

                                      image
                                          .toString()
                                          .isEmpty

                                          ? Icon(

                                        Icons.person,

                                        color:
                                        Colors.white,

                                        size:
                                        width * 0.06,
                                      )

                                          : null,
                                    ),

                                    SizedBox(
                                      width:
                                      width * 0.04,
                                    ),

                                    /// INFO
                                    Expanded(

                                      child: Column(

                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                        children: [

                                          Text(

                                            data["fullName"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.white,

                                              fontWeight:
                                              FontWeight.bold,

                                              fontSize:
                                              width * 0.042,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 4,
                                          ),

                                          Text(

                                            data["designation"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.white70,

                                              fontSize:
                                              width * 0.033,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 4,
                                          ),

                                          Text(

                                            data["department"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.cyanAccent,

                                              fontWeight:
                                              FontWeight.w600,

                                              fontSize:
                                              width * 0.032,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// ICON
                                    Icon(

                                      Icons.arrow_forward_ios,

                                      color:
                                      Colors.white54,

                                      size:
                                      width * 0.04,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(

          userName: userName,

          profileImage: profileImage,
        ),
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

                  Builder(

                    builder: (context) {

                      return GestureDetector(

                        onTap: () {

                          Scaffold.of(context).openDrawer();
                        },

                        child: glassCircleButton(

                          icon:
                          Icons.menu_rounded,

                          size:
                          width * 0.14,
                        ),
                      );
                    },
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

                    GestureDetector(
                      onTap: () {

                        showWorkspaceSearch();
                      },
                      child: glassCategory(

                        icon:
                        Icons.search,

                        width:
                        width,
                      ),
                    ),

                    SizedBox(
                      width:
                      width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "CEO",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "CEO",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Nurion Lab",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Nurion Lab",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "IT",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "IT",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "UI/UX",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "UI/UX",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Digital Marketing",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Digital Marketing",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "HR Department",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "HR Department",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Account & Finance",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Account & Finance",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Business Development",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Business Development",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Nurion Studio",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Nurion Studio",
                        width,
                      ),
                    ),

                    SizedBox(
                      width: width * 0.03,
                    ),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                            const DepartmentMeetingsPage(

                              department: "Other Department",
                            ),
                          ),
                        );
                      },

                      child: categoryChip(
                        "Other Department",
                        width,
                      ),
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

                    /// =========================
                    /// SORT MEETINGS
                    /// =========================
                    meetings.sort((a, b) {

                      final aData =
                      a.data()
                      as Map<String, dynamic>;

                      final bData =
                      b.data()
                      as Map<String, dynamic>;

                      DateTime aDateTime;
                      DateTime bDateTime;

                      /// =========================
                      /// A DATETIME
                      /// =========================
                      if (aData.containsKey(
                        "startDateTime",
                      )) {

                        aDateTime =

                            (aData["startDateTime"]
                            as Timestamp)
                                .toDate();

                      } else {

                        final aDate =
                        DateTime.parse(

                          aData["meetingDate"],
                        );

                        final aParsed =
                        DateFormat.jm().parse(

                          aData["startTime"],
                        );

                        aDateTime = DateTime(

                          aDate.year,
                          aDate.month,
                          aDate.day,

                          aParsed.hour,
                          aParsed.minute,
                        );
                      }

                      /// =========================
                      /// B DATETIME
                      /// =========================
                      if (bData.containsKey(
                        "startDateTime",
                      )) {

                        bDateTime =

                            (bData["startDateTime"]
                            as Timestamp)
                                .toDate();

                      } else {

                        final bDate =
                        DateTime.parse(

                          bData["meetingDate"],
                        );

                        final bParsed =
                        DateFormat.jm().parse(

                          bData["startTime"],
                        );

                        bDateTime = DateTime(

                          bDate.year,
                          bDate.month,
                          bDate.day,

                          bParsed.hour,
                          bParsed.minute,
                        );
                      }

                      /// =========================
                      /// UPCOMING FIRST
                      /// =========================
                      return aDateTime.compareTo(
                        bDateTime,
                      );
                    });

                    /// =========================
                    /// REMOVE OLD MEETINGS
                    /// =========================
                    final now = DateTime.now();

                    meetings.removeWhere((doc) {

                      final data =
                      doc.data()
                      as Map<String, dynamic>;

                      DateTime endDateTime;

                      if (data.containsKey(
                        "endDateTime",
                      )) {

                        endDateTime =

                            (data["endDateTime"]
                            as Timestamp)
                                .toDate();

                      } else {

                        final date =
                        DateTime.parse(

                          data["meetingDate"],
                        );

                        final parsed =
                        DateFormat.jm().parse(

                          data["endTime"],
                        );

                        endDateTime = DateTime(

                          date.year,
                          date.month,
                          date.day,

                          parsed.hour,
                          parsed.minute,
                        );
                      }

                      /// OLD MEETING REMOVE
                      return endDateTime.isBefore(
                        now,
                      );
                    });

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

                                    GestureDetector(
                                      onTap: (){

                                        showMeetingDialog(

                                          meetingId:
                                          meetings[index].id,

                                          data: data,
                                        );
                                      },
                                      child: Container(

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
  /// SHOW MEETING DIALOG
  /// =========================
  void showMeetingDialog({

    required String meetingId,

    required Map<String, dynamic> data,
  }) {

    final membersController =
    TextEditingController(

      text:
      data["members"],
    );

    DateTime selectedDate =
    DateTime.parse(
      data["meetingDate"],
    );

    final startDateTime =
    convertToDateTime(

      time:
      data["startTime"],

      date:
      selectedDate,
    );

    final endDateTime =
    convertToDateTime(

      time:
      data["endTime"],

      date:
      selectedDate,
    );

    TimeOfDay startTime =
    TimeOfDay(

      hour:
      startDateTime.hour,

      minute:
      startDateTime.minute,
    );

    TimeOfDay endTime =
    TimeOfDay(

      hour:
      endDateTime.hour,

      minute:
      endDateTime.minute,
    );

    showDialog(

      context: context,

      builder: (context) {

        final width =
            MediaQuery.of(context)
                .size
                .width;

        final height =
            MediaQuery.of(context)
                .size
                .height;

        return StatefulBuilder(

          builder:
              (context, setDialogState) {

            return Dialog(

              backgroundColor:
              Colors.transparent,

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
                    Alignment.topLeft,

                    end:
                    Alignment.bottomRight,

                    colors: [

                      const Color(
                        0xFF151127,
                      ),

                      const Color(
                        0xFF090014,
                      ),
                    ],
                  ),

                  border:
                  Border.all(

                    color:
                    Colors.white
                        .withOpacity(
                      0.08,
                    ),
                  ),
                ),

                child: SingleChildScrollView(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      /// TITLE
                      Row(

                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                        children: [

                          Text(

                            "Meeting Details",

                            style: TextStyle(

                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,

                              fontSize:
                              width * 0.055,
                            ),
                          ),

                          GestureDetector(

                            onTap: () {

                              Navigator.pop(
                                context,
                              );
                            },

                            child: const Icon(

                              Icons.close,

                              color:
                              Colors.white,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        height * 0.03,
                      ),

                      /// DATE
                      buildButton(

                        title:
                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",

                        icon:
                        Icons.calendar_month,

                        onTap: () async {

                          final picked =
                          await showDatePicker(

                            context: context,

                            initialDate:
                            selectedDate,

                            firstDate:
                            DateTime.now(),

                            lastDate:
                            DateTime(2035),
                          );

                          if (picked != null) {

                            setDialogState(() {

                              selectedDate =
                                  picked;
                            });
                          }
                        },
                      ),

                      SizedBox(
                        height:
                        height * 0.02,
                      ),

                      /// START TIME
                      buildButton(

                        title:
                        startTime.format(
                          context,
                        ),

                        icon:
                        Icons.access_time,

                        onTap: () async {

                          final picked =
                          await showTimePicker(

                            context: context,

                            initialTime:
                            startTime,
                          );

                          if (picked != null) {

                            setDialogState(() {

                              startTime =
                                  picked;
                            });
                          }
                        },
                      ),

                      SizedBox(
                        height:
                        height * 0.02,
                      ),

                      /// END TIME
                      buildButton(

                        title:
                        endTime.format(
                          context,
                        ),

                        icon:
                        Icons.timer,

                        onTap: () async {

                          final picked =
                          await showTimePicker(

                            context: context,

                            initialTime:
                            endTime,
                          );

                          if (picked != null) {

                            setDialogState(() {

                              endTime =
                                  picked;
                            });
                          }
                        },
                      ),

                      SizedBox(
                        height:
                        height * 0.02,
                      ),

                      /// MEMBERS
                      TextField(

                        controller:
                        membersController,

                        style:
                        const TextStyle(
                          color:
                          Colors.white,
                        ),

                        decoration:
                        InputDecoration(

                          filled: true,

                          fillColor:
                          Colors.white
                              .withOpacity(
                            0.06,
                          ),

                          hintText:
                          "Members",

                          hintStyle:
                          const TextStyle(
                            color:
                            Colors.white54,
                          ),

                          prefixIcon:
                          const Icon(

                            Icons.groups,

                            color:
                            Colors.white70,
                          ),

                          border:
                          OutlineInputBorder(

                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                        height * 0.04,
                      ),

                      /// UPDATE BUTTON
                      GestureDetector(

                        onTap: () async {

                          /// =========================
                          /// START & END VALIDATION
                          /// =========================
                          final startMinutes =

                              startTime.hour * 60 +
                                  startTime.minute;

                          final endMinutes =

                              endTime.hour * 60 +
                                  endTime.minute;

                          if (endMinutes <= startMinutes) {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(

                                backgroundColor:
                                Colors.red,

                                content: Text(

                                  "End time must be after start time",
                                ),
                              ),
                            );

                            return;
                          }

                          /// =========================
                          /// CHECK CONFLICT
                          /// =========================
                          final hasConflict =
                          await checkConflict(

                            meetingId:
                            meetingId,

                            date:
                            selectedDate,

                            start:
                            startTime,

                            end:
                            endTime,
                          );

                          print(hasConflict);

                          if (hasConflict) {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(

                                backgroundColor:
                                Colors.red,

                                content: Text(

                                  "This meeting time is already booked.",
                                ),
                              ),
                            );

                            return;
                          }

                          /// =========================
                          /// DATETIME
                          /// =========================
                          final startDateTime = DateTime(

                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,

                            startTime.hour,
                            startTime.minute,
                          );

                          final endDateTime = DateTime(

                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,

                            endTime.hour,
                            endTime.minute,
                          );

                          /// =========================
                          /// UPDATE FIREBASE
                          /// =========================
                          await FirebaseFirestore
                              .instance
                              .collection("meetings")
                              .doc(meetingId)
                              .update({

                            "meetingDate":

                            DateFormat(
                              "yyyy-MM-dd",
                            ).format(selectedDate),

                            "startTime":
                            startTime.format(
                              context,
                            ),

                            "endTime":
                            endTime.format(
                              context,
                            ),

                            "startDateTime":
                            startDateTime,

                            "endDateTime":
                            endDateTime,

                            "members":
                            membersController.text,
                          });

                          print("UPDATED SUCCESS");

                          if (mounted) {

                            Navigator.pop(
                              context,
                            );

                            ScaffoldMessenger.of(
                              this.context,
                            ).showSnackBar(

                              const SnackBar(

                                backgroundColor:
                                Colors.green,

                                content: Text(

                                  "Meeting Updated Successfully",
                                ),
                              ),
                            );
                          }
                        },

                        child: Container(

                          width:
                          double.infinity,

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),

                          decoration:
                          BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(
                              22,
                            ),

                            gradient:
                            const LinearGradient(

                              colors: [

                                Color(
                                  0xFFD9FF00,
                                ),

                                Color(
                                  0xFFB6FF00,
                                ),
                              ],
                            ),
                          ),

                          child: const Center(

                            child: Text(

                              "Update Meeting",

                              style: TextStyle(

                                color:
                                Colors.black,

                                fontWeight:
                                FontWeight.bold,

                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                        height * 0.02,
                      ),

                      /// DELETE BUTTON
                      GestureDetector(

                        onTap: () async {

                          await FirebaseFirestore
                              .instance
                              .collection("meetings")
                              .doc(meetingId)
                              .delete();

                          if (mounted) {

                            Navigator.of(context).pop();

                            Future.delayed(

                              const Duration(
                                milliseconds: 200,
                              ),

                                  () {

                                setState(() {});
                              },
                            );

                            ScaffoldMessenger.of(
                              this.context,
                            ).showSnackBar(

                              const SnackBar(

                                backgroundColor:
                                Colors.red,

                                content: Text(
                                  "Meeting Deleted Successfully",
                                ),
                              ),
                            );
                          }
                        },

                        child: Container(

                          width:
                          double.infinity,

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),

                          decoration:
                          BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(
                              22,
                            ),

                            color:
                            Colors.red,
                          ),

                          child: const Center(

                            child: Text(

                              "Delete Meeting",

                              style: TextStyle(

                                color:
                                Colors.white,

                                fontWeight:
                                FontWeight.bold,

                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  DateTime convertToDateTime({

    required String time,

    required DateTime date,
  }) {

    final cleaned =

    time

        .replaceAll(
      RegExp(r'\s+'),
      ' ',
    )

        .replaceAll(
      '\u202F',
      ' ',
    )

        .trim();

    final parsed =
    DateFormat(
      "h:mm a",
    ).parse(cleaned);

    return DateTime(

      date.year,
      date.month,
      date.day,

      parsed.hour,
      parsed.minute,
    );
  }
  String normalizeTime(
      String time,
      ) {

    return time

        .replaceAll(
      RegExp(r'\s+'),
      ' ',
    )

        .replaceAll(
      ' ',
      ' ',
    )

        .trim();
  }

  Widget buildButton({

    required String title,

    required IconData icon,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding:
        const EdgeInsets.symmetric(

          horizontal: 18,
          vertical: 18,
        ),

        decoration:
        BoxDecoration(

          borderRadius:
          BorderRadius.circular(
            20,
          ),

          color:
          Colors.white
              .withOpacity(
            0.06,
          ),
        ),

        child: Row(

          children: [

            Icon(

              icon,

              color:
              Colors.white,
            ),

            const SizedBox(
              width: 12,
            ),

            Text(

              title,

              style:
              const TextStyle(

                color:
                Colors.white,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// =========================
  /// CHECK CONFLICT
  /// =========================
  Future<bool> checkConflict({

    required String meetingId,

    required DateTime date,

    required TimeOfDay start,

    required TimeOfDay end,
  }) async {

    try {

      /// =========================
      /// NEW START & END
      /// =========================
      final newStart = DateTime(

        date.year,
        date.month,
        date.day,

        start.hour,
        start.minute,
      );

      final newEnd = DateTime(

        date.year,
        date.month,
        date.day,

        end.hour,
        end.minute,
      );

      /// =========================
      /// GET SAME DATE MEETINGS
      /// =========================
      final snapshot =
      await FirebaseFirestore
          .instance
          .collection("meetings")
          .where(

        "meetingDate",

        isEqualTo:
        DateFormat(
          "yyyy-MM-dd",
        ).format(date),
      )
          .get();

      for (final doc in snapshot.docs) {

        /// =========================
        /// SKIP CURRENT MEETING
        /// =========================
        if (doc.id == meetingId) {
          continue;
        }

        DateTime existingStart;

        DateTime existingEnd;

        /// =========================
        /// NEW TIMESTAMP FORMAT
        /// =========================
        if (

        doc.data().containsKey(
          "startDateTime",
        )

            &&

            doc.data().containsKey(
              "endDateTime",
            )

        ) {

          existingStart =

              (doc["startDateTime"]
              as Timestamp)
                  .toDate();

          existingEnd =

              (doc["endDateTime"]
              as Timestamp)
                  .toDate();

        }

        /// =========================
        /// OLD STRING FORMAT
        /// =========================
        else {

          final startParsed =
          DateFormat.jm().parse(
            doc["startTime"],
          );

          final endParsed =
          DateFormat.jm().parse(
            doc["endTime"],
          );

          existingStart = DateTime(

            date.year,
            date.month,
            date.day,

            startParsed.hour,
            startParsed.minute,
          );

          existingEnd = DateTime(

            date.year,
            date.month,
            date.day,

            endParsed.hour,
            endParsed.minute,
          );
        }

        /// =========================
        /// OVERLAP CHECK
        /// =========================
        final overlap =

            newStart.isBefore(
              existingEnd,
            )

                &&

                newEnd.isAfter(
                  existingStart,
                );

        if (overlap) {

          return true;
        }
      }

      return false;

    } catch (e) {

      print(e);

      return true;
    }
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
  /// =========================
  /// WORKSPACE SEARCH
  /// =========================
  void showWorkspaceSearch() {

    final searchController =
    TextEditingController();

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      backgroundColor:
      Colors.transparent,

      builder: (context) {

        final width =
            MediaQuery.of(context)
                .size
                .width;

        final height =
            MediaQuery.of(context)
                .size
                .height;

        return StatefulBuilder(

          builder:
              (context, setState) {

            return Container(

              height:
              height * 0.85,

              padding:
              EdgeInsets.all(
                width * 0.05,
              ),

              decoration:
              const BoxDecoration(

                color:
                Color(0xFF090014),

                borderRadius:
                BorderRadius.vertical(

                  top:
                  Radius.circular(
                    35,
                  ),
                ),
              ),

              child: Column(

                children: [

                  /// TOP BAR
                  Container(

                    width:
                    width * 0.18,

                    height: 5,

                    decoration:
                    BoxDecoration(

                      borderRadius:
                      BorderRadius.circular(
                        50,
                      ),

                      color:
                      Colors.white24,
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.03,
                  ),

                  /// SEARCH FIELD
                  TextField(

                    controller:
                    searchController,

                    onChanged: (_) {

                      setState(() {});
                    },

                    style:
                    const TextStyle(

                      color:
                      Colors.white,
                    ),

                    decoration:
                    InputDecoration(

                      hintText:

                      "Search employees, meetings, departments...",

                      hintStyle:
                      const TextStyle(

                        color:
                        Colors.white54,
                      ),

                      prefixIcon:
                      const Icon(

                        Icons.search,

                        color:
                        Colors.white70,
                      ),

                      filled: true,

                      fillColor:
                      Colors.white
                          .withOpacity(
                        0.06,
                      ),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(
                          22,
                        ),

                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.03,
                  ),

                  /// RESULTS
                  Expanded(

                    child:
                    StreamBuilder(

                      stream:
                      FirebaseFirestore
                          .instance
                          .collection(
                        "users",
                      )
                          .snapshots(),

                      builder:
                          (context, snapshot) {

                        if (!snapshot
                            .hasData) {

                          return const Center(

                            child:
                            CircularProgressIndicator(),
                          );
                        }

                        final users =
                            snapshot.data!
                                .docs;

                        final query =

                        searchController
                            .text
                            .toLowerCase();

                        final filtered =

                        users.where((doc) {

                          final data =
                          doc.data();

                          final name =

                          data["fullName"]
                              .toString()
                              .toLowerCase();

                          final dept =

                          data["department"]
                              .toString()
                              .toLowerCase();

                          final designation =

                          data["designation"]
                              .toString()
                              .toLowerCase();

                          return

                            name.contains(
                              query,
                            )

                                ||

                                dept.contains(
                                  query,
                                )

                                ||

                                designation.contains(
                                  query,
                                );
                        }).toList();

                        if (filtered.isEmpty) {

                          return const Center(

                            child: Text(

                              "No Results Found",

                              style: TextStyle(

                                color:
                                Colors.white70,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(

                          physics:
                          const BouncingScrollPhysics(),

                          itemCount:
                          filtered.length,

                          itemBuilder:
                              (context, index) {

                            final data =
                            filtered[index]
                                .data();

                            final image =

                                data["profileImage"]
                                    ?? "";

                            return GestureDetector(
                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>

                                        EmployeeDetailsPage(

                                          userData: data,
                                        ),
                                  ),
                                );
                              },
                              child: Container(

                                margin:
                                EdgeInsets.only(

                                  bottom:
                                  height * 0.02,
                                ),

                                padding:
                                EdgeInsets.all(
                                  width * 0.04,
                                ),

                                decoration:
                                BoxDecoration(

                                  borderRadius:
                                  BorderRadius.circular(
                                    24,
                                  ),

                                  color:
                                  Colors.white
                                      .withOpacity(
                                    0.05,
                                  ),

                                  border:
                                  Border.all(

                                    color:
                                    Colors.white
                                        .withOpacity(
                                      0.06,
                                    ),
                                  ),
                                ),

                                child: Row(

                                  children: [

                                    /// AVATAR
                                    CircleAvatar(

                                      radius:
                                      width * 0.07,

                                      backgroundColor:
                                      Colors.white
                                          .withOpacity(
                                        0.08,
                                      ),

                                      backgroundImage:

                                      image
                                          .toString()
                                          .isNotEmpty

                                          ? NetworkImage(
                                        image,
                                      )

                                          : null,

                                      child:

                                      image
                                          .toString()
                                          .isEmpty

                                          ? Icon(

                                        Icons.person,

                                        color:
                                        Colors.white,

                                        size:
                                        width * 0.06,
                                      )

                                          : null,
                                    ),

                                    SizedBox(
                                      width:
                                      width * 0.04,
                                    ),

                                    /// INFO
                                    Expanded(

                                      child: Column(

                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                        children: [

                                          Text(

                                            data["fullName"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.white,

                                              fontWeight:
                                              FontWeight.bold,

                                              fontSize:
                                              width * 0.042,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 4,
                                          ),

                                          Text(

                                            data["designation"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.white70,

                                              fontSize:
                                              width * 0.033,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 4,
                                          ),

                                          Text(

                                            data["department"]
                                                ?? "",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.cyanAccent,

                                              fontWeight:
                                              FontWeight.w600,

                                              fontSize:
                                              width * 0.032,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// ICON
                                    Icon(

                                      Icons.arrow_forward_ios,

                                      color:
                                      Colors.white54,

                                      size:
                                      width * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}