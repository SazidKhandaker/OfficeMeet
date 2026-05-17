import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/Auth/login.dart' show LoginPage;
import 'package:office_meet/Security%20and%20privacy/privacysecuritypage.dart' show PrivacySecurityPage;
import 'package:office_meet/homepage.dart' show HomePage;
import 'package:office_meet/profile/editprofile.dart';
import 'package:office_meet/workspace/workspcae.dart' show WorkspacePage;

class ProfilePage extends StatefulWidget {

  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFF0B0618),

      body:
      StreamBuilder<DocumentSnapshot>(

        stream:
        FirebaseFirestore
            .instance
            .collection("users")
            .doc(
          FirebaseAuth
              .instance
              .currentUser!
              .uid,
        )
            .snapshots(),

        builder:
            (context, snapshot) {

          /// =========================
          /// LOADING
          /// =========================
          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(

              child:
              CircularProgressIndicator(),
            );
          }

          /// =========================
          /// NO DATA
          /// =========================
          if (!snapshot.hasData ||
              !snapshot.data!.exists) {

            return const Center(

              child: Text(

                "No Profile Data",

                style: TextStyle(
                  color:
                  Colors.white,
                ),
              ),
            );
          }

          /// =========================
          /// FIREBASE DATA
          /// =========================
          final doc =
          snapshot.data!;

          final fullName =
              doc["fullName"] ?? "";

          final designation =
              doc["designation"] ?? "";

          final department =
              doc["department"] ?? "";

          final joiningDate =
              doc["joiningDate"] ?? "";

          final profileImage =
              doc["profileImage"] ?? "";

          final email =
              FirebaseAuth
                  .instance
                  .currentUser
                  ?.email ?? "";

          return SafeArea(

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
                      width * 0.06,

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
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            topButton(

                              Icons
                                  .arrow_back_ios_new,

                                  () {

                                    Navigator.pushReplacement(

                                      context,

                                      MaterialPageRoute(

                                        builder: (context) =>
                                        const HomePage(),
                                      ),
                                    );
                              },
                            ),

                            Text(

                              "Profile",

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
                                  .settings_outlined,

                                  () {},
                            ),
                          ],
                        ),

                        SizedBox(
                          height:
                          height * 0.05,
                        ),

                        /// =========================
                        /// PROFILE IMAGE
                        /// =========================
                        Container(

                          padding:
                          const EdgeInsets.all(
                            4,
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

                            boxShadow: [

                              BoxShadow(

                                color:
                                const Color(
                                  0xFF00E5FF,
                                ).withOpacity(
                                  0.45,
                                ),

                                blurRadius:
                                35,
                              ),
                            ],
                          ),

                          child: CircleAvatar(

                            radius:
                            width * 0.16,

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
                            profileImage
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
                        ),

                        SizedBox(
                          height:
                          height * 0.03,
                        ),

                        /// =========================
                        /// FULL NAME
                        /// =========================
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
                            width * 0.08,
                          ),
                        ),

                        SizedBox(
                          height:
                          height * 0.012,
                        ),

                        /// =========================
                        /// DESIGNATION
                        /// =========================
                        if (designation
                            .isNotEmpty)

                          Text(

                            designation,

                            style: TextStyle(

                              color:
                              const Color(
                                0xFF00E5FF,
                              ),

                              fontSize:
                              width * 0.042,

                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                        SizedBox(
                          height:
                          height * 0.012,
                        ),

                        /// =========================
                        /// EMAIL
                        /// =========================
                        Text(

                          email,

                          style: TextStyle(

                            color:
                            Colors.white60,

                            fontSize:
                            width * 0.036,
                          ),
                        ),

                        /// =========================
                        /// DEPARTMENT
                        /// =========================
                        if (department
                            .isNotEmpty)

                          Padding(

                            padding:
                            const EdgeInsets.only(
                              top: 10,
                            ),

                            child: Text(

                              department,

                              style: TextStyle(

                                color:
                                Colors.greenAccent,

                                fontWeight:
                                FontWeight.w600,

                                fontSize:
                                width * 0.040,
                              ),
                            ),
                          ),

                        /// =========================
                        /// JOINING DATE
                        /// =========================
                        if (joiningDate
                            .isNotEmpty)

                          Padding(

                            padding:
                            const EdgeInsets.only(
                              top: 10,
                            ),

                            child: Text(

                              "Joined $joiningDate",

                              style: TextStyle(

                                color:
                                Colors.white54,

                                fontSize:
                                width * 0.034,
                              ),
                            ),
                          ),

                        SizedBox(
                          height:
                          height * 0.05,
                        ),

                        /// =========================
                        /// STATS
                        /// =========================
                        Row(

                          children: [

                            Expanded(
                              child:
                              statCard(

                                "24",

                                "Meetings",

                                width,
                              ),
                            ),

                            SizedBox(
                              width:
                              width * 0.03,
                            ),

                            Expanded(
                              child:
                              statCard(

                                "Acote",

                                "No1",

                                width,
                              ),
                            ),

                            SizedBox(
                              width:
                              width * 0.03,
                            ),

                            Expanded(
                              child:
                              statCard(

                                "46",

                                "Teams",

                                width,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height:
                          height * 0.05,
                        ),

                        /// =========================
                        /// EDIT PROFILE
                        /// =========================
                        glassActionCard(

                          icon:
                          Icons.edit_outlined,

                          title:
                          "Edit Profile",

                          color:
                          const Color(
                            0xFF00E5FF,
                          ),

                          onTap: () async {
                            final result =
                                await Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder:
                                    (context) =>

                                const EditProfilePage(),
                              ),
                            );

                            if (result == true) {

                              setState(() {});
                            }
                          },
                        ),

                        SizedBox(
                          height:
                          height * 0.02,
                        ),

                        /// =========================
                        /// WORKSPACE
                        /// =========================
                        glassActionCard(

                          icon:
                          Icons.workspaces_outline,

                          title:
                          "Workspace",

                          color:
                          const Color(
                            0xFFB026FF,
                          ),

                          onTap: () {
                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (context) =>
                                const WorkspacePage(),
                              ),
                            );

                          },
                        ),

                        SizedBox(
                          height:
                          height * 0.02,
                        ),

                        /// =========================
                        /// SECURITY
                        /// =========================
                        glassActionCard(

                          icon:
                          Icons.security,

                          title:
                          "Privacy & Security",

                          color:
                          const Color(
                            0xFFFF5ACD,
                          ),

                          onTap: () {
                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (context) =>

                                const PrivacySecurityPage(),
                              ),
                            );
                          },
                        ),

                        SizedBox(
                          height:
                          height * 0.02,
                        ),

                        /// =========================
                        /// LOGOUT
                        /// =========================
                        glassActionCard(

                          icon:
                          Icons.logout_rounded,

                          title:
                          "Logout",

                          color:
                          Colors.redAccent,

              onTap: () async {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

              SnackBar(

              backgroundColor:
              Colors.green,

              content: const Text(

              "Logout successful",
              ),
              ),
              );

              await Future.delayed(
              const Duration(seconds: 1),
              );

              await FirebaseAuth
                  .instance
                  .signOut();

              Navigator.pushAndRemoveUntil(

              context,

              MaterialPageRoute(

              builder: (context) =>
              const LoginPage(),
              ),

              (route) => false,
              );
              },),

                        SizedBox(
                          height:
                          height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
  /// STATS CARD
  /// =========================
  Widget statCard(
      String value,
      String title,
      double width,
      ) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(24),

      child: BackdropFilter(

        filter: ImageFilter.blur(

          sigmaX: 25,
          sigmaY: 25,
        ),

        child: Container(

          padding:
          const EdgeInsets.symmetric(
            vertical: 22,
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
              0.08,
            ),
          ),

          child: Column(
            children: [

              Text(

                value,

                style: TextStyle(

                  color:

                  value == "Acote"

                      ? Colors.greenAccent

                      : Colors.white,

                  fontWeight:
                  FontWeight.bold,

                  fontSize:

                  value == "Acote"

                      ? width * 0.065

                      : width * 0.065,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(

                title,

                textAlign:
                TextAlign.center,

                style: TextStyle(

                  color:
                  Colors.white60,

                  fontSize:
                  width * 0.032,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// ACTION CARD
  /// =========================
  Widget glassActionCard({

    required IconData icon,

    required String title,

    required Color color,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

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
            const EdgeInsets.symmetric(

              horizontal: 22,
              vertical: 20,
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
            ),

            child: Row(

              children: [

                Container(

                  padding:
                  const EdgeInsets.all(
                    12,
                  ),

                  decoration:
                  BoxDecoration(

                    shape:
                    BoxShape.circle,

                    color:
                    color.withOpacity(
                      0.15,
                    ),
                  ),

                  child: Icon(

                    icon,

                    color:
                    color,
                  ),
                ),

                const SizedBox(
                  width: 18,
                ),

                Expanded(

                  child: Text(

                    title,

                    style:
                    const TextStyle(

                      color:
                      Colors.white,

                      fontWeight:
                      FontWeight.w600,

                      fontSize: 16,
                    ),
                  ),
                ),

                Icon(

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