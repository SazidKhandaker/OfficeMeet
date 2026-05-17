import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DepartmentDetailsPage
    extends StatelessWidget {

  final String department;

  const DepartmentDetailsPage({

    super.key,

    required this.department,
  });

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    final descriptions = {

      "IT":
      "Handles all software, server and technical operations.",

      "UI/UX":
      "Creates premium user experiences and modern interfaces.",

      "Digital Marketing":
      "Manages branding, promotions and digital growth.",

      "HR Department":
      "Manages employees, hiring and office relationships.",

      "Account & Finance":
      "Handles company financial operations and budgeting.",

      "Business Development":
      "Creates new business opportunities and partnerships.",

      "Nurion Lab":
      "Research and BPO department.",

      "Nurion Studio":
      "Creative production and Part of ui/ux team.",

      "CEO":
      "Company leadership and executive management.",

      "Other Department":
      "Additional organizational departments.",
    };

    final randomColors = [

      const Color(0xFF00E5FF),

      const Color(0xFFB026FF),

      const Color(0xFFFF5ACD),

      const Color(0xFF4DFFB4),

      const Color(0xFFFFA351),
    ];

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
            Padding(

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

                      Expanded(

                        child: Center(

                          child: Text(

                            department,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style: TextStyle(

                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,

                              fontSize:
                              width * 0.06,
                            ),
                          ),
                        ),
                      ),

                      topButton(

                        Icons.search,

                            () {},
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    height * 0.03,
                  ),

                  /// =========================
                  /// HEADER CARD
                  /// =========================
                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(
                      30,
                    ),

                    child: BackdropFilter(

                      filter: ImageFilter.blur(

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
                            30,
                          ),

                          gradient:
                          LinearGradient(

                            colors: [

                              const Color(
                                0xFF00E5FF,
                              ).withOpacity(
                                0.25,
                              ),

                              const Color(
                                0xFFB026FF,
                              ).withOpacity(
                                0.25,
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

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            Text(

                              department,

                              style: TextStyle(

                                color:
                                Colors.white,

                                fontWeight:
                                FontWeight.bold,

                                fontSize:
                                width * 0.075,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.015,
                            ),

                            Text(

                              descriptions[
                              department] ??
                                  "",

                              style: TextStyle(

                                color:
                                Colors.white70,

                                fontSize:
                                width * 0.036,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.025,
                            ),

                            StreamBuilder<
                                QuerySnapshot>(

                              stream:
                              FirebaseFirestore
                                  .instance
                                  .collection(
                                "users",
                              )
                                  .where(

                                "department",

                                isEqualTo:
                                department,
                              )
                                  .where(

                                "verified",

                                isEqualTo:
                                true,
                              )
                                  .snapshots(),

                              builder:
                                  (context,
                                  snapshot) {

                                int total =
                                0;

                                if (snapshot
                                    .hasData) {

                                  total =
                                      snapshot
                                          .data!
                                          .docs
                                          .length;
                                }

                                return Text(

                                  "$total Employees",

                                  style: TextStyle(

                                    color:
                                    Colors.greenAccent,

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize:
                                    width * 0.045,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.035,
                  ),

                  /// =========================
                  /// EMPLOYEE TITLE
                  /// =========================
                  Text(

                    "Employees",

                    style: TextStyle(

                      color:
                      Colors.white,

                      fontWeight:
                      FontWeight.bold,

                      fontSize:
                      width * 0.05,
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  /// =========================
                  /// EMPLOYEE LIST
                  /// =========================
                  Expanded(

                    child:
                    StreamBuilder<QuerySnapshot>(

                      stream:
                      FirebaseFirestore
                          .instance
                          .collection("users")
                          .where(

                        "department",

                        isEqualTo:
                        department,
                      )
                          .where(

                        "verified",

                        isEqualTo:
                        true,
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
                            snapshot
                                .data!
                                .docs;

                        if (users.isEmpty) {

                          return Center(

                            child: Text(

                              "No Employees Found",

                              style: TextStyle(

                                color:
                                Colors.white54,

                                fontSize:
                                width * 0.04,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(

                          physics:
                          const BouncingScrollPhysics(),

                          itemCount:
                          users.length,

                          itemBuilder:
                              (context, index) {

                            final user =
                            users[index];

                            final glowColor =
                            randomColors[
                            Random()
                                .nextInt(
                              randomColors
                                  .length,
                            )
                            ];

                            return employeeCard(

                              width,

                              color:
                              glowColor,

                              fullName:
                              user["fullName"] ??
                                  "",

                              designation:
                              user["designation"] ??
                                  "Employee",

                              joiningDate:
                              user["joiningDate"] ??
                                  "",

                              profileImage:
                              user["profileImage"] ??
                                  "",
                            );
                          },
                        );
                      },
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
  /// EMPLOYEE CARD
  /// =========================
  Widget employeeCard(

      double width, {

        required Color color,

        required String fullName,

        required String designation,

        required String joiningDate,

        required String profileImage,
      }) {

    return Container(

      margin:
      const EdgeInsets.only(
        bottom: 18,
      ),

      child: ClipRRect(

        borderRadius:
        BorderRadius.circular(30),

        child: BackdropFilter(

          filter: ImageFilter.blur(

            sigmaX: 25,
            sigmaY: 25,
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

              gradient:
              LinearGradient(

                begin:
                Alignment.topLeft,

                end:
                Alignment.bottomRight,

                colors: [

                  color.withOpacity(
                    0.30,
                  ),

                  Colors.white
                      .withOpacity(
                    0.05,
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

              boxShadow: [

                BoxShadow(

                  color:
                  color.withOpacity(
                    0.25,
                  ),

                  blurRadius:
                  35,
                ),
              ],
            ),

            child: Row(

              children: [

                /// =========================
                /// LEFT SIDE
                /// =========================
                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Text(

                        fullName,

                        maxLines: 1,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                          fontSize:
                          width * 0.055,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(

                        designation,

                        style: TextStyle(

                          color:
                          Colors.white70,

                          fontWeight:
                          FontWeight.w500,

                          fontSize:
                          width * 0.036,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(

                        "Joined $joiningDate",

                        style: TextStyle(

                          color:
                          Colors.greenAccent,

                          fontWeight:
                          FontWeight.w600,

                          fontSize:
                          width * 0.032,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width:
                  width * 0.04,
                ),

                /// =========================
                /// RIGHT IMAGE
                /// =========================
                Container(

                  padding:
                  const EdgeInsets.all(
                    3,
                  ),

                  decoration:
                  BoxDecoration(

                    shape:
                    BoxShape.circle,

                    gradient:
                    LinearGradient(

                      colors: [

                        color,

                        Colors.white,
                      ],
                    ),
                  ),

                  child: CircleAvatar(

                    radius:
                    width * 0.09,

                    backgroundColor:
                    Colors.black,

                    backgroundImage:
                    profileImage
                        .isNotEmpty

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
                      width * 0.08,
                    )

                        : null,
                  ),
                ),
              ],
            ),
          ),
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

  /// =========================
  /// GLOW CIRCLE
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