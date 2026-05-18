import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_meet/bottomnavbar/addmeeting.dart' show MeetingPage;

class MeetingBookingPage extends StatefulWidget {

  const MeetingBookingPage({
    super.key,
  });

  @override
  State<MeetingBookingPage> createState() =>
      _MeetingBookingPageState();
}

class _MeetingBookingPageState
    extends State<MeetingBookingPage> {

  final memberController =
  TextEditingController();

  String fullName = "";

  String department = "";

  DateTime? selectedDate;

  TimeOfDay? startTime;

  TimeOfDay? endTime;

  bool isLoading = false;

  @override
  void initState() {

    super.initState();

    loadUserData();
  }

  /// =========================
  /// LOAD USER DATA
  /// =========================
  Future<void> loadUserData() async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    final doc =
    await FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .get();

    if (doc.exists) {

      setState(() {

        fullName =
            doc["fullName"] ?? "";

        department =
            doc["department"] ?? "";
      });
    }
  }

  /// =========================
  /// PICK DATE
  /// =========================
  Future<void> pickDate() async {

    final picked =
    await showDatePicker(

      context: context,

      initialDate:
      DateTime.now(),

      firstDate:
      DateTime.now(),

      lastDate:
      DateTime(2035),
    );

    if (picked != null) {

      setState(() {

        selectedDate = picked;
      });
    }
  }

  /// =========================
  /// PICK START TIME
  /// =========================
  Future<void> pickStartTime() async {

    final picked =
    await showTimePicker(

      context: context,

      initialTime:
      TimeOfDay.now(),
    );

    if (picked != null) {

      setState(() {

        startTime = picked;
      });
    }
  }

  /// =========================
  /// PICK END TIME
  /// =========================
  Future<void> pickEndTime() async {

    final picked =
    await showTimePicker(

      context: context,

      initialTime:
      TimeOfDay.now(),
    );

    if (picked != null) {

      setState(() {

        endTime = picked;
      });
    }
  }

  /// =========================
  /// CONVERT TIME
  /// =========================
  DateTime combineDateTime(
      DateTime date,
      TimeOfDay time,
      ) {

    return DateTime(

      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  /// =========================
  /// CHECK CONFLICT
  /// =========================
  Future<bool> hasConflict() async {

    final start =
    combineDateTime(

      selectedDate!,
      startTime!,
    );

    final end =
    combineDateTime(

      selectedDate!,
      endTime!,
    );

    final meetings =
    await FirebaseFirestore
        .instance
        .collection("meetings")
        .where(

      "meetingDate",

      isEqualTo:
      DateFormat(
        "yyyy-MM-dd",
      ).format(selectedDate!),
    )
        .get();

    for (var doc in meetings.docs) {

      final existingStart =
      (doc["startDateTime"]
      as Timestamp)
          .toDate();

      final existingEnd =
      (doc["endDateTime"]
      as Timestamp)
          .toDate();

      /// =========================
      /// OVERLAP CHECK
      /// =========================
      if (

      start.isBefore(existingEnd)
          &&
          end.isAfter(existingStart)

      ) {

        return true;
      }
    }

    return false;
  }

  /// =========================
  /// SAVE MEETING
  /// =========================
  Future<void> saveMeeting() async {

    if (

    selectedDate == null ||
        startTime == null ||
        endTime == null ||
        memberController
            .text
            .trim()
            .isEmpty

    ) {

      showBox(
        "Please fill all fields.",
      );

      return;
    }

    final start =
    combineDateTime(

      selectedDate!,
      startTime!,
    );

    final end =
    combineDateTime(

      selectedDate!,
      endTime!,
    );

    if (!end.isAfter(start)) {

      showBox(

        "End time must be after start time.",
      );

      return;
    }

    setState(() {

      isLoading = true;
    });

    final conflict =
    await hasConflict();

    if (conflict) {

      setState(() {

        isLoading = false;
      });

      showDialog(

        context: context,

        builder: (context) {

          return AlertDialog(

            backgroundColor:
            const Color(
              0xFF151127,
            ),

            title: const Text(

              "Meeting Conflict",

              style: TextStyle(
                color:
                Colors.white,
              ),
            ),

            content: const Text(

              "Another meeting is already booked during this time.",

              style: TextStyle(
                color:
                Colors.white70,
              ),
            ),

            actions: [

              TextButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "OK",
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    await FirebaseFirestore
        .instance
        .collection("meetings")
        .add({

      "fullName":
      fullName,

      "department":
      department,

      "members":
      memberController.text
          .trim(),

      "meetingDate":
      DateFormat(
        "yyyy-MM-dd",
      ).format(selectedDate!),

      "startTime":
      startTime!
          .format(context),

      "endTime":
      endTime!
          .format(context),

      "startDateTime":
      start,

      "endDateTime":
      end,

      "createdAt":
      FieldValue
          .serverTimestamp(),
    });

    setState(() {

      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        backgroundColor:
        Colors.green,

        content: Text(

          "Meeting booked successfully.",
        ),
      ),
    );
  }

  /// =========================
  /// ALERT BOX
  /// =========================
  void showBox(String message) {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor:
          const Color(
            0xFF151127,
          ),

          title: const Text(

            "Alert",

            style: TextStyle(
              color:
              Colors.white,
            ),
          ),

          content: Text(

            message,

            style: const TextStyle(
              color:
              Colors.white70,
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
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

    return Scaffold(

      backgroundColor:
      const Color(
        0xFF0B0618,
      ),

      body: SafeArea(

        child: Stack(
          children: [

            /// =========================
            /// BACKGROUND GLOW
            /// =========================
            Positioned(

              top: -120,
              left: -80,

              child: glowCircle(

                260,

                const Color(
                  0xFFB026FF,
                ),
              ),
            ),

            Positioned(

              bottom: -100,
              right: -70,

              child: glowCircle(

                220,

                const Color(
                  0xFF00E5FF,
                ),
              ),
            ),

            /// =========================
            /// MAIN BODY
            /// =========================
            SingleChildScrollView(

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
                  CrossAxisAlignment
                      .start,

                  children: [

                    /// =========================
                    /// TOP BAR
                    /// =========================
                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                      children: [

                        topButton(

                          Icons
                              .arrow_back_ios_new,

                              () {

                            Navigator.pop(
                              context,
                            );
                          },
                        ),

                        Text(

                          "Book Meeting",

                          style: TextStyle(

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                            fontSize:
                            width * 0.06,
                          ),
                        ),

                        topButton(

                          Icons
                              .calendar_month,

                              () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
                    ),

                    /// =========================
                    /// FORM CARD
                    /// =========================
                    glassContainer(

                      child: Column(

                        children: [

                          customField(

                            label:
                            "Your Name",

                            value:
                            fullName,

                            icon:
                            Icons.person,

                            enabled:
                            false,
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          customField(

                            label:
                            "Department",

                            value:
                            department,

                            icon:
                            Icons.apartment,

                            enabled:
                            false,
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          TextField(

                            controller:
                            memberController,

                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                            ),

                            decoration:
                            inputDecoration(

                              "Members",

                              Icons.groups,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.03,
                    ),

                    /// =========================
                    /// DATE
                    /// =========================
                    dateCard(

                      title:

                      selectedDate == null

                          ? "Select Date"

                          : DateFormat(
                        "dd MMM yyyy",
                      ).format(
                        selectedDate!,
                      ),

                      icon:
                      Icons.calendar_today,

                      onTap:
                      pickDate,
                    ),

                    SizedBox(
                      height:
                      height * 0.025,
                    ),

                    /// =========================
                    /// TIME
                    /// =========================
                    Row(
                      children: [

                        Expanded(

                          child: dateCard(

                            title:

                            startTime == null

                                ? "Start Time"

                                : startTime!
                                .format(
                              context,
                            ),

                            icon:
                            Icons.access_time,

                            onTap:
                            pickStartTime,
                          ),
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        Expanded(

                          child: dateCard(

                            title:

                            endTime == null

                                ? "End Time"

                                : endTime!
                                .format(
                              context,
                            ),

                            icon:
                            Icons.timer,

                            onTap:
                            pickEndTime,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.05,
                    ),

                    /// =========================
                    /// BUTTON
                    /// =========================
                    GestureDetector(

                      onTap:

                      isLoading

                          ? null

                          : saveMeeting,

                      child: Container(

                        width:
                        double.infinity,

                        padding:
                        const EdgeInsets
                            .symmetric(

                          vertical: 20,
                        ),

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius
                              .circular(
                            28,
                          ),

                          gradient:
                          const LinearGradient(

                            colors: [

                              Color(
                                0xFF00E5FF,
                              ),

                              Color(
                                0xFFB026FF,
                              ),
                            ],
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                              const Color(
                                0xFF00E5FF,
                              ).withOpacity(
                                0.35,
                              ),

                              blurRadius:
                              30,
                            ),
                          ],
                        ),

                        child: Center(

                          child:

                          isLoading

                              ? const CircularProgressIndicator(
                            color:
                            Colors.white,
                          )

                              : const Text(

                            "Book Meeting",

                            style:
                            TextStyle(

                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,

                              fontSize:
                              18,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.07,
                    ),


                    /// =========================
                    /// VIDEO CONFERENCE
                    /// =========================
                    GestureDetector(

                      onTap: () {

                        showDialog(

                          context: context,

                          builder: (context) {

                            return AlertDialog(

                              backgroundColor:
                              const Color(
                                0xFF151127,
                              ),

                              shape: RoundedRectangleBorder(

                                borderRadius:
                                BorderRadius.circular(
                                  24,
                                ),
                              ),

                              title: const Text(

                                "Video Conference",

                                style: TextStyle(
                                  color:
                                  Colors.white,
                                ),
                              ),

                              content: const Text(

                                "This page is currently under development. Are you interested in visiting the meeting page?",

                                style: TextStyle(
                                  color:
                                  Colors.white70,
                                ),
                              ),

                              actions: [

                                TextButton(

                                  onPressed: () {

                                    Navigator.pop(
                                      context,
                                    );
                                  },

                                  child: const Text(

                                    "Cancel",
                                  ),
                                ),

                                TextButton(

                                  onPressed: () {

                                    Navigator.pop(
                                      context,
                                    );

                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(

                                        builder: (context) =>

                                        const MeetingPage(),
                                      ),
                                    );
                                  },

                                  child: const Text(

                                    "Continue",

                                    style: TextStyle(
                                      color:
                                      Colors.greenAccent,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: ClipRRect(

                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),

                        child: BackdropFilter(

                          filter: ImageFilter.blur(

                            sigmaX: 20,
                            sigmaY: 20,
                          ),

                          child: Container(

                            width:
                            double.infinity,

                            padding:
                            const EdgeInsets.all(
                              22,
                            ),

                            decoration:
                            BoxDecoration(

                              borderRadius:
                              BorderRadius.circular(
                                30,
                              ),

                              gradient:
                              LinearGradient(

                                colors: [

                                  const Color(
                                    0xFF00E5FF,
                                  ).withOpacity(
                                    0.22,
                                  ),

                                  const Color(
                                    0xFFB026FF,
                                  ).withOpacity(
                                    0.22,
                                  ),
                                ],
                              ),

                              border: Border.all(

                                color:
                                Colors.white
                                    .withOpacity(
                                  0.08,
                                ),
                              ),
                            ),

                            child: Row(

                              children: [

                                Container(

                                  padding:
                                  const EdgeInsets.all(
                                    16,
                                  ),

                                  decoration:
                                  BoxDecoration(

                                    shape:
                                    BoxShape.circle,

                                    color:
                                    Colors.white
                                        .withOpacity(
                                      0.08,
                                    ),
                                  ),

                                  child: const Icon(

                                    Icons.video_call,

                                    color:
                                    Colors.white,

                                    size: 30,
                                  ),
                                ),

                                const SizedBox(
                                  width: 18,
                                ),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      Text(

                                        "Video Conference",

                                        style: TextStyle(

                                          color:
                                          Colors.white,

                                          fontWeight:
                                          FontWeight.bold,

                                          fontSize:
                                          width * 0.045,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 6,
                                      ),

                                      Text(

                                        "Create & join online workspace meetings.",

                                        style: TextStyle(

                                          color:
                                          Colors.white70,

                                          fontSize:
                                          width * 0.032,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(

                                  Icons.arrow_forward_ios,

                                  color:
                                  Colors.white54,

                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// GLASS CONTAINER
  /// =========================
  Widget glassContainer({

    required Widget child,
  }) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(
        30,
      ),

      child: BackdropFilter(

        filter: ImageFilter.blur(

          sigmaX: 20,
          sigmaY: 20,
        ),

        child: Container(

          padding:
          const EdgeInsets.all(
            20,
          ),

          decoration:
          BoxDecoration(

            borderRadius:
            BorderRadius.circular(
              30,
            ),

            color:
            Colors.white
                .withOpacity(
              0.08,
            ),

            border: Border.all(

              color:
              Colors.white
                  .withOpacity(
                0.08,
              ),
            ),
          ),

          child: child,
        ),
      ),
    );
  }

  Widget customField({

    required String label,

    required String value,

    required IconData icon,

    required bool enabled,
  }) {

    return TextField(

      enabled: enabled,

      controller:
      TextEditingController(
        text: value,
      ),

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration:
      inputDecoration(
        label,
        icon,
      ),
    );
  }

  InputDecoration inputDecoration(
      String hint,
      IconData icon,
      ) {

    return InputDecoration(

      filled: true,

      fillColor:
      Colors.white
          .withOpacity(
        0.05,
      ),

      prefixIcon: Icon(

        icon,

        color:
        Colors.white70,
      ),

      hintText: hint,

      hintStyle:
      const TextStyle(
        color:
        Colors.white54,
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
    );
  }

  Widget dateCard({

    required String title,

    required IconData icon,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: glassContainer(

        child: Column(

          children: [

            Icon(

              icon,

              color:
              Colors.white,

              size: 28,
            ),

            const SizedBox(
              height: 14,
            ),

            Text(

              title,

              textAlign:
              TextAlign.center,

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

  Widget topButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: ClipRRect(

        borderRadius:
        BorderRadius.circular(
          18,
        ),

        child: BackdropFilter(

          filter: ImageFilter.blur(

            sigmaX: 20,
            sigmaY: 20,
          ),

          child: Container(

            height: 52,
            width: 52,

            decoration:
            BoxDecoration(

              borderRadius:
              BorderRadius.circular(
                18,
              ),

              color:
              Colors.white
                  .withOpacity(
                0.08,
              ),
            ),

            child: Icon(

              icon,

              color:
              Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget glowCircle(
      double size,
      Color color,
      ) {

    return Container(

      height: size,
      width: size,

      decoration:
      BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        color.withOpacity(
          0.25,
        ),

        boxShadow: [

          BoxShadow(

            color:
            color.withOpacity(
              0.45,
            ),

            blurRadius:
            120,
          ),
        ],
      ),
    );
  }
}