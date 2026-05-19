import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/Auth/login.dart' show LoginPage;
import 'package:office_meet/Security%20and%20privacy/settingpage.dart' show SettingsPage;
import 'package:office_meet/bottomnavbar/Calander.dart';
import 'package:office_meet/bottomnavbar/meetingdate.dart';
import 'package:office_meet/bottomnavbar/profile.dart';


class AppDrawer
    extends StatelessWidget {

  final String userName;

  final String profileImage;

  const AppDrawer({

    super.key,

    required this.userName,

    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {

    return Drawer(

      backgroundColor:
      const Color(0xFF090014),

      child: SafeArea(

        child: Column(

          children: [

            /// =========================
            /// HEADER
            /// =========================
            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(
                20,
              ),

              decoration:
              BoxDecoration(

                gradient:
                LinearGradient(

                  colors: [

                    const Color(
                      0xFF7F00FF,
                    ).withOpacity(
                      0.4,
                    ),

                    const Color(
                      0xFF00D1FF,
                    ).withOpacity(
                      0.2,
                    ),
                  ],
                ),
              ),

              child: Column(

                children: [

                  CircleAvatar(

                    radius: 42,

                    backgroundColor:
                    Colors.white12,

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

                        ? const Icon(

                      Icons.person,

                      color:
                      Colors.white,

                      size: 40,
                    )

                        : null,
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Text(

                    userName,

                    style:
                    const TextStyle(

                      color:
                      Colors.white,

                      fontWeight:
                      FontWeight.bold,

                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Text(

                    "Workspace Employee",

                    style: TextStyle(

                      color:
                      Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            /// =========================
            /// EMAIL VERIFICATION
            /// =========================
            Padding(

              padding:
              const EdgeInsets.symmetric(

                horizontal: 16,
              ),

              child: Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(
                  16,
                ),

                decoration:
                BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(
                    22,
                  ),

                  gradient:
                  LinearGradient(

                    colors: [

                      FirebaseAuth
                          .instance
                          .currentUser!
                          .emailVerified

                          ? Colors.green
                          .withOpacity(0.25)

                          : Colors.orange
                          .withOpacity(0.25),

                      const Color(
                        0xFF1A1A2E,
                      ),
                    ],
                  ),

                  border:
                  Border.all(

                    color:

                    FirebaseAuth
                        .instance
                        .currentUser!
                        .emailVerified

                        ? Colors.greenAccent
                        .withOpacity(0.4)

                        : Colors.orangeAccent
                        .withOpacity(0.4),
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

                        FirebaseAuth
                            .instance
                            .currentUser!
                            .emailVerified

                            ? Colors.green
                            .withOpacity(0.18)

                            : Colors.orange
                            .withOpacity(0.18),
                      ),

                      child: Icon(

                        FirebaseAuth
                            .instance
                            .currentUser!
                            .emailVerified

                            ? Icons.verified

                            : Icons.warning_amber_rounded,

                        color:

                        FirebaseAuth
                            .instance
                            .currentUser!
                            .emailVerified

                            ? Colors.greenAccent

                            : Colors.orangeAccent,
                      ),
                    ),

                    const SizedBox(
                      width: 14,
                    ),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const Text(

                            "Email Verification",

                            style: TextStyle(

                              color:
                              Colors.white70,

                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(

                            FirebaseAuth
                                .instance
                                .currentUser!
                                .emailVerified

                                ? "Verified Account"

                                : "Email Not Verified",

                            style:
                            const TextStyle(

                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    FirebaseAuth
                        .instance
                        .currentUser!
                        .emailVerified

                        ? const Icon(

                      Icons.check_circle,

                      color:
                      Colors.greenAccent,
                    )

                        : GestureDetector(

                      onTap: () async {

                        await FirebaseAuth
                            .instance
                            .currentUser!
                            .sendEmailVerification();

                        if (context.mounted) {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            const SnackBar(

                              backgroundColor:
                              Colors.orange,

                              content: Text(

                                "Verification email sent",
                              ),
                            ),
                          );
                        }
                      },

                      child: Container(

                        padding:
                        const EdgeInsets.symmetric(

                          horizontal: 14,

                          vertical: 8,
                        ),

                        decoration:
                        BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(
                            14,
                          ),

                          color:
                          Colors.orange
                              .withOpacity(
                            0.15,
                          ),
                        ),

                        child: const Text(

                          "Verify",

                          style: TextStyle(

                            color:
                            Colors.orangeAccent,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /// =========================
            /// ITEMS
            /// =========================

            drawerTile(

              icon:
              Icons.home_rounded,

              title:
              "Home",

              onTap: () {

                Navigator.pop(
                  context,
                );
              },
            ),

            drawerTile(

              icon:
              Icons.calendar_month,

              title:
              "Calendar",

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const CalendarPage(),
                  ),
                );
              },
            ),

            drawerTile(

              icon:
              Icons.video_call,

              title:
              "Meetings",

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const MeetingBookingPage(),
                  ),
                );
              },
            ),

            drawerTile(

              icon:
              Icons.person,

              title:
              "Profile",

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const ProfilePage(),
                  ),
                );
              },
            ),

            drawerTile(

              icon:
              Icons.settings,

              title:
              "Settings",

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const SettingsPage(),
                  ),
                );
              },
            ),

            const Spacer(),

            /// =========================
            /// LOGOUT
            /// =========================
            Padding(

              padding:
              const EdgeInsets.all(
                20,
              ),

              child: GestureDetector(

                onTap: () async {

                  await FirebaseAuth
                      .instance
                      .signOut();

                  if (context.mounted) {

                    Navigator.pushAndRemoveUntil(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>

                        const LoginPage(),
                      ),

                          (route) => false,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(

                      const SnackBar(

                        backgroundColor:
                        Colors.red,

                        content: Text(

                          "Logged out successfully",
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

                    vertical: 16,
                  ),

                  decoration:
                  BoxDecoration(

                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                    gradient:
                    const LinearGradient(

                      colors: [

                        Color(
                          0xFFFF4D4D,
                        ),

                        Color(
                          0xFFFF0000,
                        ),
                      ],
                    ),
                  ),

                  child: const Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      Icon(

                        Icons.logout,

                        color:
                        Colors.white,
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Text(

                        "Logout",

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// DRAWER TILE
  /// =========================
  Widget drawerTile({

    required IconData icon,

    required String title,

    required VoidCallback onTap,
  }) {

    return ListTile(

      onTap: onTap,

      leading: Icon(

        icon,

        color: Colors.white,
      ),

      title: Text(

        title,

        style: const TextStyle(

          color: Colors.white,

          fontWeight: FontWeight.w600,
        ),
      ),

      trailing: const Icon(

        Icons.arrow_forward_ios,

        color: Colors.white54,

        size: 16,
      ),
    );
  }
}