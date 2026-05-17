import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkspacePage extends StatelessWidget {

  const WorkspacePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    final departments = [

      {
        "name": "IT",
        "icon": Icons.computer,
      },

      {
        "name": "UI/UX",
        "icon": Icons.palette,
      },

      {
        "name": "Digital Marketing",
        "icon": Icons.campaign,
      },

      {
        "name": "HR Department",
        "icon": Icons.people,
      },

      {
        "name": "Account & Finance",
        "icon": Icons.account_balance_wallet,
      },

      {
        "name": "Business Development",
        "icon": Icons.business_center,
      },

      {
        "name": "Nurion Lab",
        "icon": Icons.science,
      },

      {
        "name": "Nurion Studio",
        "icon": Icons.video_collection,
      },

      {
        "name": "CEO",
        "icon": Icons.workspace_premium,
      },

      {
        "name": "Other Department",
        "icon": Icons.apartment,
      },
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

                      Text(

                        "Workspace",

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

                        Icons.search,

                            () {},
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
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

                              "Office Workspace",

                              style: TextStyle(

                                color:
                                Colors.white,

                                fontWeight:
                                FontWeight.bold,

                                fontSize:
                                width * 0.07,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.01,
                            ),

                            Text(

                              "Manage all departments & employees in one place.",

                              style: TextStyle(

                                color:
                                Colors.white70,

                                fontSize:
                                width * 0.035,
                              ),
                            ),

                            SizedBox(
                              height:
                              height * 0.025,
                            ),

                            StreamBuilder<QuerySnapshot>(

                              stream:
                              FirebaseFirestore
                              .instance
                              .collection(
                              "users",
                            )
                                .where(
                              "verified",
                              isEqualTo: true,
                            )
                                .snapshots(),

                              builder:
                                  (context, snapshot) {

                                if (!snapshot
                                    .hasData) {

                                  return const SizedBox();
                                }

                                final total =
                                    snapshot
                                        .data!
                                        .docs
                                        .length;

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
                    height * 0.04,
                  ),

                  /// =========================
                  /// TITLE
                  /// =========================
                  Text(

                    "Departments",

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
                    height * 0.025,
                  ),

                  /// =========================
                  /// GRID
                  /// =========================
                  Expanded(

                    child: GridView.builder(

                      physics:
                      const BouncingScrollPhysics(),

                      itemCount:
                      departments.length,

                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount:

                        width > 900

                            ? 4

                            : width > 600

                            ? 3

                            : 2,

                        crossAxisSpacing:
                        18,

                        mainAxisSpacing:
                        18,

                        childAspectRatio:

                        width < 380

                            ? 0.78

                            : 0.90,
                      ),

                      itemBuilder:
                          (context, index) {

                        final department =
                        departments[index];

                        return departmentCard(

                          width,

                          icon:
                          department["icon"]
                          as IconData,

                          department:
                          department["name"]
                          as String,
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
  /// DEPARTMENT CARD
  /// =========================
  Widget departmentCard(

      double width, {

        required IconData icon,

        required String department,
      }) {

    return StreamBuilder<QuerySnapshot>(

      stream:
      FirebaseFirestore
          .instance
          .collection("users")
          .where(

        "department",

        isEqualTo:
        department,
      )
          .snapshots(),

      builder:
          (context, snapshot) {

        int totalEmployees = 0;

        if (snapshot.hasData) {

          totalEmployees =
              snapshot
                  .data!
                  .docs
                  .length;
        }

        return GestureDetector(

          onTap: () {

            /// NEXT PAGE
          },

          child: ClipRRect(

            borderRadius:
            BorderRadius.circular(28),

            child: BackdropFilter(

              filter: ImageFilter.blur(

                sigmaX: 20,
                sigmaY: 20,
              ),

              child: Container(

                padding:
                EdgeInsets.all(
                  width * 0.05,
                ),

                decoration:
                BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(
                    28,
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

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [

                    Container(

                      padding:
                      const EdgeInsets.all(
                        14,
                      ),

                      decoration:
                      BoxDecoration(

                        shape:
                        BoxShape.circle,

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
                      ),

                      child: Icon(

                        icon,

                        color:
                        Colors.white,

                        size:
                        width * 0.06,
                      ),
                    ),

                    const Spacer(),

                    Text(

                      department,

                      maxLines: 2,

                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight.bold,

                        fontSize:
                        width * 0.042,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(

                      "$totalEmployees Employees",

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
            ),
          ),
        );
      },
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