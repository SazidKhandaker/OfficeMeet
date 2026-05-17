import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/profile/editprofile.dart' show EditProfilePage;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {

  String fullName = "Loading...";
  String email = "";
  String designation =
      "Flutter Developer";

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

      final doc =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (doc.exists) {

        setState(() {

          fullName =
              doc["fullName"] ?? "";

          email =
              doc["email"] ?? "";

          designation =
              doc["designation"] ??
                  "Flutter Developer";

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
                      MainAxisAlignment.spaceBetween,

                      children: [

                        topButton(
                          Icons.arrow_back_ios_new,
                              () {

                            Navigator.pop(
                              context,
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
                          Icons.settings_outlined,
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

                      decoration: BoxDecoration(

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
                              0.5,
                            ),

                            blurRadius:
                            30,
                          ),
                        ],
                      ),

                      child: CircleAvatar(

                        radius:
                        width * 0.16,

                        backgroundColor:
                        Colors.black,

                        backgroundImage:
                        const AssetImage(
                          "assets/images/profile.jpg",
                        ),
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.025,
                    ),

                    /// =========================
                    /// NAME
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
                      height * 0.008,
                    ),

                    /// DESIGNATION
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
                        FontWeight.w500,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.008,
                    ),

                    /// EMAIL
                    Text(

                      email,

                      style: TextStyle(

                        color:
                        Colors.white60,

                        fontSize:
                        width * 0.036,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.045,
                    ),

                    /// =========================
                    /// STATS
                    /// =========================
                    Row(

                      children: [

                        Expanded(
                          child: statCard(
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
                          child: statCard(
                            "85",
                            "Projects",
                            width,
                          ),
                        ),

                        SizedBox(
                          width:
                          width * 0.03,
                        ),

                        Expanded(
                          child: statCard(
                            "46",
                            "Teams",
                            width,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.045,
                    ),

                    /// =========================
                    /// ACTION CARD
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

                      onTap: () {
                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (context) =>
                            const EditProfilePage(),
                          ),
                        );


                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    glassActionCard(

                      icon:
                      Icons.workspaces_outline,

                      title:
                      "Workspace",

                      color:
                      const Color(
                        0xFFB026FF,
                      ),

                      onTap: () {},
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    glassActionCard(

                      icon:
                      Icons.security,

                      title:
                      "Privacy & Security",

                      color:
                      const Color(
                        0xFFFF5ACD,
                      ),

                      onTap: () {},
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    glassActionCard(

                      icon:
                      Icons.logout_rounded,

                      title:
                      "Logout",

                      color:
                      Colors.redAccent,

                      onTap: () async {

                        await FirebaseAuth
                            .instance
                            .signOut();
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
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

            decoration: BoxDecoration(

              borderRadius:
              BorderRadius.circular(
                18,
              ),

              color:
              Colors.white.withOpacity(
                0.08,
              ),

              border: Border.all(

                color:
                Colors.white.withOpacity(
                  0.08,
                ),
              ),
            ),

            child: Icon(

              icon,

              color: Colors.white,
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

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(24),

            color:
            Colors.white.withOpacity(
              0.08,
            ),

            border: Border.all(

              color:
              Colors.white.withOpacity(
                0.08,
              ),
            ),
          ),

          child: Column(
            children: [

              Text(

                value,

                style: TextStyle(

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight.bold,

                  fontSize:
                  width * 0.065,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(

                title,

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

            decoration: BoxDecoration(

              borderRadius:
              BorderRadius.circular(
                28,
              ),

              color:
              Colors.white.withOpacity(
                0.08,
              ),

              border: Border.all(

                color:
                color.withOpacity(
                  0.35,
                ),
              ),

              boxShadow: [

                BoxShadow(

                  color:
                  color.withOpacity(
                    0.15,
                  ),

                  blurRadius: 25,
                ),
              ],
            ),

            child: Row(

              children: [

                Container(

                  padding:
                  const EdgeInsets.all(
                    12,
                  ),

                  decoration: BoxDecoration(

                    shape:
                    BoxShape.circle,

                    color:
                    color.withOpacity(
                      0.15,
                    ),
                  ),

                  child: Icon(

                    icon,

                    color: color,
                  ),
                ),

                const SizedBox(
                  width: 18,
                ),

                Expanded(

                  child: Text(

                    title,

                    style: const TextStyle(

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

      decoration: BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        color.withOpacity(0.25),

        boxShadow: [

          BoxShadow(

            color:
            color.withOpacity(0.45),

            blurRadius: 120,
          ),
        ],
      ),
    );
  }
}