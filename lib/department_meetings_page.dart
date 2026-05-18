import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'homepage.dart';

class DepartmentMeetingsPage
    extends StatelessWidget {

  final String department;

  const DepartmentMeetingsPage({

    super.key,

    required this.department,
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

    final premiumColors = [

      [
        const Color(0xFF7F00FF),
        const Color(0xFFE100FF),
      ],

      [
        const Color(0xFF00C6FF),
        const Color(0xFF0072FF),
      ],

      [
        const Color(0xFFFF512F),
        const Color(0xFFDD2476),
      ],

      [
        const Color(0xFF11998E),
        const Color(0xFF38EF7D),
      ],

      [
        const Color(0xFFFF9966),
        const Color(0xFFFF5E62),
      ],
    ];

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

            Column(
              children: [

                /// =========================
                /// APPBAR
                /// =========================
                Padding(

                  padding:
                  EdgeInsets.symmetric(

                    horizontal:
                    width * 0.05,

                    vertical:
                    height * 0.015,
                  ),

                  child: Row(

                    children: [

                      GestureDetector(

                        onTap: () {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>
                              const HomePage(),
                            ),
                          );
                        },

                        child: glassButton(
                          Icons.arrow_back_ios_new,
                        ),
                      ),

                      SizedBox(
                        width:
                        width * 0.04,
                      ),

                      Expanded(

                        child: Text(

                          department,

                          maxLines: 1,

                          overflow:
                          TextOverflow.ellipsis,

                          style: TextStyle(

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                            fontSize:
                            width * 0.065,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                /// =========================
                /// BODY
                /// =========================
                Expanded(

                  child:
                  StreamBuilder(

                    stream:
                    FirebaseFirestore
                        .instance
                        .collection(
                      "meetings",
                    )
                        .where(

                      "department",

                      isEqualTo:
                      department,
                    )
                        .snapshots(),

                    builder:
                        (context, snapshot) {

                      /// LOADING
                      if (!snapshot
                          .hasData) {

                        return const Center(

                          child:
                          CircularProgressIndicator(),
                        );
                      }

                      final docs =
                          snapshot.data!
                              .docs;

                      /// SORT
                      docs.sort((a, b) {

                        return b["meetingDate"]
                            .compareTo(
                          a["meetingDate"],
                        );
                      });

                      /// EMPTY
                      if (docs.isEmpty) {

                        return FutureBuilder(

                          future:
                          Future.delayed(

                            const Duration(
                              seconds: 2,
                            ),
                          ),

                          builder:
                              (context, snap) {

                            if (snap.connectionState !=
                                ConnectionState.done) {

                              return const Center(

                                child:
                                CircularProgressIndicator(),
                              );
                            }

                            return Center(

                              child: Text(

                                "No Data Found",

                                style: TextStyle(

                                  color:
                                  Colors.white70,

                                  fontSize:
                                  width * 0.045,

                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return ListView.builder(

                        physics:
                        const BouncingScrollPhysics(),

                        padding:
                        EdgeInsets.only(

                          left:
                          width * 0.05,

                          right:
                          width * 0.05,

                          bottom:
                          height * 0.04,
                        ),

                        itemCount:
                        docs.length,

                        itemBuilder:
                            (context, index) {

                          final data =
                          docs[index]
                              .data();

                          final colors =
                          premiumColors[
                          Random()
                              .nextInt(
                            premiumColors
                                .length,
                          )];

                          final image =

                          data.containsKey(
                            "profileImage",
                          )

                              ? data["profileImage"] ?? ""
                              : "";

                          return Container(

                            margin:
                            EdgeInsets.only(

                              bottom:
                              height * 0.025,
                            ),

                            child: ClipRRect(

                              borderRadius:
                              BorderRadius.circular(
                                32,
                              ),

                              child: BackdropFilter(

                                filter:
                                ImageFilter.blur(

                                  sigmaX: 25,
                                  sigmaY: 25,
                                ),

                                child: Container(

                                  padding:
                                  EdgeInsets.all(
                                    width * 0.045,
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

                                        colors[0]
                                            .withOpacity(
                                          0.35,
                                        ),

                                        colors[1]
                                            .withOpacity(
                                          0.16,
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

                                  child: Row(

                                    children: [

                                      /// AVATAR
                                      CircleAvatar(

                                        radius:
                                        width * 0.08,

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
                                          width * 0.07,
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

                                              data["department"]
                                                  ?? "",

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
                                                width * 0.048,
                                              ),
                                            ),

                                            SizedBox(
                                              height:
                                              height * 0.008,
                                            ),

                                            Text(

                                              data["fullName"]
                                                  ?? "",

                                              maxLines: 1,

                                              overflow:
                                              TextOverflow
                                                  .ellipsis,

                                              style: TextStyle(

                                                color:
                                                Colors.white70,

                                                fontWeight:
                                                FontWeight.w500,

                                                fontSize:
                                                width * 0.036,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width:
                                        width * 0.02,
                                      ),

                                      /// RIGHT
                                      Column(

                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,

                                        children: [

                                          Text(

                                            "${data["members"] ?? "0"} Members",

                                            style: TextStyle(

                                              color:
                                              Colors.white,

                                              fontWeight:
                                              FontWeight.bold,

                                              fontSize:
                                              width * 0.034,
                                            ),
                                          ),

                                          SizedBox(
                                            height:
                                            height * 0.012,
                                          ),

                                          Text(

                                            DateFormat(
                                              "dd MMM yyyy",
                                            ).format(

                                              DateTime.parse(
                                                data["meetingDate"],
                                              ),
                                            ),

                                            style: TextStyle(

                                              color:
                                              Colors.white60,

                                              fontSize:
                                              width * 0.031,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
          ],
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
          0.24,
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

  /// =========================
  /// GLASS BUTTON
  /// =========================
  Widget glassButton(
      IconData icon,
      ) {

    return ClipRRect(

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
    );
  }
}