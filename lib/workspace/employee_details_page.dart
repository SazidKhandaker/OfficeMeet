import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailsPage
    extends StatelessWidget {

  final Map<String, dynamic> userData;

  const EmployeeDetailsPage({

    super.key,

    required this.userData,
  });

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

    final image =
        userData["profileImage"]
            ?? "";

    final email =
        userData["email"]
            ?? "";

    final fullName =
        userData["fullName"]
            ?? "";

    final department =
        userData["department"]
            ?? "";

    final designation =
        userData["designation"]
            ?? "";

    final joiningDate =
        userData["joiningDate"]
            ?? "";

    return Scaffold(

      backgroundColor:
      const Color(
        0xFF05010D,
      ),

      body: SafeArea(

        child: Stack(
          children: [

            /// TOP GLOW
            Positioned(

              top: -120,
              left: -80,

              child: glowCircle(

                280,

                const Color(
                  0xFF6A00FF,
                ),
              ),
            ),

            /// BOTTOM GLOW
            Positioned(

              bottom: -130,
              right: -70,

              child: glowCircle(

                260,

                const Color(
                  0xFF00D1FF,
                ),
              ),
            ),

            SingleChildScrollView(

              physics:
              const BouncingScrollPhysics(),

              padding:
              EdgeInsets.symmetric(

                horizontal:
                width * 0.05,

                vertical:
                height * 0.02,
              ),

              child: Column(

                children: [

                  /// APPBAR
                  Row(

                    children: [

                      glassButton(

                        context,

                        Icons.arrow_back_ios_new,
                      ),

                      SizedBox(
                        width:
                        width * 0.04,
                      ),

                      Text(

                        "Employee Profile",

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                          fontSize:
                          width * 0.06,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
                  ),

                  /// PROFILE CARD
                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(
                      35,
                    ),

                    child: BackdropFilter(

                      filter:
                      ImageFilter.blur(

                        sigmaX: 25,
                        sigmaY: 25,
                      ),

                      child: Container(

                        width:
                        double.infinity,

                        padding:
                        EdgeInsets.all(
                          width * 0.06,
                        ),

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(
                            35,
                          ),

                          gradient:
                          LinearGradient(

                            begin:
                            Alignment.topLeft,

                            end:
                            Alignment.bottomRight,

                            colors: [

                              const Color(
                                0xFF7F00FF,
                              ).withOpacity(
                                0.35,
                              ),

                              const Color(
                                0xFF00D1FF,
                              ).withOpacity(
                                0.18,
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

                        child: Column(

                          children: [

                            /// IMAGE
                            CircleAvatar(

                              radius:
                              width * 0.16,

                              backgroundColor:
                              Colors.white
                                  .withOpacity(
                                0.10,
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
                                width * 0.12,
                              )

                                  : null,
                            ),

                            SizedBox(
                              height:
                              height * 0.025,
                            ),

                            /// NAME
                            Text(

                              fullName,

                              textAlign:
                              TextAlign.center,

                              style: TextStyle(

                                color:
                                Colors.white,

                                fontWeight:
                                FontWeight.bold,

                                fontSize:
                                width * 0.065,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.01,
                            ),

                            /// DESIGNATION
                            Text(

                              designation,

                              style: TextStyle(

                                color:
                                Colors.white70,

                                fontWeight:
                                FontWeight.w500,

                                fontSize:
                                width * 0.042,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.03,
                            ),

                            /// INFO CARDS
                            infoTile(

                              width,

                              Icons.apartment,

                              "Department",

                              department,
                            ),

                            SizedBox(
                              height:
                              height * 0.018,
                            ),

                            infoTile(

                              width,

                              Icons.badge,

                              "Designation",

                              designation,
                            ),

                            SizedBox(
                              height:
                              height * 0.018,
                            ),

                            infoTile(

                              width,

                              Icons.calendar_month,

                              "Joining Date",

                              joiningDate,
                            ),

                            SizedBox(
                              height:
                              height * 0.018,
                            ),

                            /// EMAIL
                            ClipRRect(

                              borderRadius:
                              BorderRadius.circular(
                                22,
                              ),

                              child: BackdropFilter(

                                filter:
                                ImageFilter.blur(

                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),

                                child: Container(

                                  padding:
                                  EdgeInsets.symmetric(

                                    horizontal:
                                    width * 0.04,

                                    vertical:
                                    height * 0.02,
                                  ),

                                  decoration:
                                  BoxDecoration(

                                    borderRadius:
                                    BorderRadius.circular(
                                      22,
                                    ),

                                    color:
                                    Colors.white
                                        .withOpacity(
                                      0.05,
                                    ),
                                  ),

                                  child: Row(

                                    children: [

                                      CircleAvatar(

                                        radius:
                                        width * 0.06,

                                        backgroundColor:
                                        Colors.white
                                            .withOpacity(
                                          0.08,
                                        ),

                                        child: Icon(

                                          Icons.email,

                                          color:
                                          Colors.white,

                                          size:
                                          width * 0.055,
                                        ),
                                      ),

                                      SizedBox(
                                        width:
                                        width * 0.04,
                                      ),

                                      Expanded(

                                        child: Column(

                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                          children: [

                                            Text(

                                              "Email",

                                              style: TextStyle(

                                                color:
                                                Colors.white60,

                                                fontSize:
                                                width * 0.032,
                                              ),
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),

                                            Text(

                                              email,

                                              overflow:
                                              TextOverflow
                                                  .ellipsis,

                                              style: TextStyle(

                                                color:
                                                Colors.white,

                                                fontWeight:
                                                FontWeight.w600,

                                                fontSize:
                                                width * 0.037,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      GestureDetector(

                                        onTap: () async {

                                          final uri =
                                          Uri.parse(

                                            "mailto:$email",
                                          );
                                          try {

                                            final Uri emailUri = Uri(

                                              scheme: 'mailto',

                                              path: email,
                                            );

                                            await launchUrl(

                                              emailUri,

                                              mode:
                                              LaunchMode.externalApplication,
                                            );

                                          } catch (e) {

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(

                                              const SnackBar(

                                                content: Text(

                                                  "Mail app not found",
                                                ),
                                              ),
                                            );
                                          }


                                        },

                                        child: Container(

                                          padding:
                                          EdgeInsets.all(
                                            width * 0.03,
                                          ),

                                          decoration:
                                          BoxDecoration(

                                            shape:
                                            BoxShape.circle,

                                            gradient:
                                            const LinearGradient(

                                              colors: [

                                                Color(
                                                  0xFF00D1FF,
                                                ),

                                                Color(
                                                  0xFF7F00FF,
                                                ),
                                              ],
                                            ),
                                          ),

                                          child: Icon(

                                            Icons.send,

                                            color:
                                            Colors.white,

                                            size:
                                            width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.025,
                            ),

                            /// MEETING COUNT
                            StreamBuilder(

                              stream:
                              FirebaseFirestore
                                  .instance
                                  .collection(
                                "meetings",
                              )
                                  .where(

                                "fullName",

                                isEqualTo:
                                fullName,
                              )
                                  .snapshots(),

                              builder:
                                  (context, snapshot) {

                                final totalMeetings =

                                snapshot.hasData

                                    ? snapshot
                                    .data!
                                    .docs
                                    .length

                                    : 0;

                                return infoTile(

                                  width,

                                  Icons.video_call,

                                  "Meetings Count",

                                  totalMeetings
                                      .toString(),
                                );
                              },
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
  /// INFO TILE
  /// =========================
  Widget infoTile(

      double width,

      IconData icon,

      String title,

      String value,
      ) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(
        22,
      ),

      child: BackdropFilter(

        filter:
        ImageFilter.blur(

          sigmaX: 20,
          sigmaY: 20,
        ),

        child: Container(

          padding:
          EdgeInsets.symmetric(

            horizontal:
            width * 0.04,

            vertical: 18,
          ),

          decoration:
          BoxDecoration(

            borderRadius:
            BorderRadius.circular(
              22,
            ),

            color:
            Colors.white
                .withOpacity(
              0.05,
            ),
          ),

          child: Row(

            children: [

              CircleAvatar(

                radius:
                width * 0.055,

                backgroundColor:
                Colors.white
                    .withOpacity(
                  0.08,
                ),

                child: Icon(

                  icon,

                  color:
                  Colors.white,

                  size:
                  width * 0.05,
                ),
              ),

              SizedBox(
                width:
                width * 0.04,
              ),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      title,

                      style: TextStyle(

                        color:
                        Colors.white60,

                        fontSize:
                        width * 0.032,
                      ),
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Text(

                      value,

                      style: TextStyle(

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight.w600,

                        fontSize:
                        width * 0.038,
                      ),
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
  /// BACK BUTTON
  /// =========================
  Widget glassButton(
      BuildContext context,
      IconData icon,
      ) {

    return GestureDetector(

      onTap: () {

        Navigator.pop(
          context,
        );
      },

      child: ClipRRect(

        borderRadius:
        BorderRadius.circular(
          18,
        ),

        child: BackdropFilter(

          filter:
          ImageFilter.blur(

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

              border:
              Border.all(

                color:
                Colors.white
                    .withOpacity(
                  0.08,
                ),
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
              0.55,
            ),

            blurRadius:
            140,
          ),
        ],
      ),
    );
  }
}