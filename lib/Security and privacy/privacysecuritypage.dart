import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrivacySecurityPage
    extends StatefulWidget {

  const PrivacySecurityPage({
    super.key,
  });

  @override
  State<PrivacySecurityPage>
  createState() =>
      _PrivacySecurityPageState();
}

class _PrivacySecurityPageState
    extends State<PrivacySecurityPage> {

  bool isLoading = false;

  /// =========================
  /// CHANGE PASSWORD
  /// =========================
  Future<void> changePassword() async {

    try {

      final email =
          FirebaseAuth
              .instance
              .currentUser
              ?.email;

      if (email != null) {

        await FirebaseAuth
            .instance
            .sendPasswordResetEmail(
          email: email,
        );

        customSnackBar(

          "Password reset email sent.",
        );
      }

    } catch (e) {

      customSnackBar(
        "Something went wrong.",
      );
    }
  }

  /// =========================
  /// DELETE ACCOUNT
  /// =========================
  Future<void> deleteAccount() async {

    try {

      setState(() {

        isLoading = true;
      });

      await FirebaseAuth
          .instance
          .currentUser!
          .delete();

      if (mounted) {

        customSnackBar(
          "Account deleted successfully.",
        );

        Navigator.pop(context);
      }

    } catch (e) {

      customSnackBar(

        "Please login again before deleting account.",
      );
    }

    setState(() {

      isLoading = false;
    });
  }

  /// =========================
  /// SNACKBAR
  /// =========================
  void customSnackBar(
      String message,
      ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
        const Color(
          0xFF00E5FF,
        ),

        content: Text(
          message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    final isVerified =
        user?.emailVerified ?? false;

    final securityScore =
    isVerified ? 92 : 45;

    return Scaffold(

      backgroundColor:
      const Color(0xFF0B0618),

      body: SafeArea(

        child: Stack(
          children: [

            /// =========================
            /// GLOW EFFECT
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

                          "Privacy & Security",

                          style: TextStyle(

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                            fontSize:
                            width * 0.055,
                          ),
                        ),

                        topButton(

                          Icons.shield_outlined,

                              () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
                    ),

                    /// =========================
                    /// SECURITY CARD
                    /// =========================
                    ClipRRect(

                      borderRadius:
                      BorderRadius.circular(
                        32,
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
                              32,
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

                          child: Column(

                            children: [

                              Container(

                                padding:
                                const EdgeInsets.all(
                                  20,
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

                                child: Icon(

                                  Icons.shield,

                                  color:
                                  Colors.greenAccent,

                                  size:
                                  width * 0.12,
                                ),
                              ),

                              SizedBox(
                                height:
                                height * 0.025,
                              ),

                              Text(

                                "$securityScore% Secure",

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
                                height * 0.01,
                              ),

                              Text(

                                "Your account security status is active.",

                                textAlign:
                                TextAlign.center,

                                style: TextStyle(

                                  color:
                                  Colors.white70,

                                  fontSize:
                                  width * 0.036,
                                ),
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
                    /// EMAIL VERIFIED
                    /// =========================
                    securityCard(

                      width,

                      icon:
                      isVerified

                          ? Icons.verified

                          : Icons.warning_amber,

                      title:
                      "Email Verification",

                      subtitle:

                      isVerified

                          ? "Your email is verified."

                          : "Email not verified.",

                      color:

                      isVerified

                          ? Colors.greenAccent

                          : Colors.orangeAccent,

                      onTap: () {},
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    /// =========================
                    /// CHANGE PASSWORD
                    /// =========================
                    securityCard(

                      width,

                      icon:
                      Icons.lock_reset,

                      title:
                      "Change Password",

                      subtitle:
                      "Send reset password email.",

                      color:
                      const Color(
                        0xFF00E5FF,
                      ),

                      onTap: changePassword,
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    /// =========================
                    /// DELETE ACCOUNT
                    /// =========================
                    securityCard(

                      width,

                      icon:
                      Icons.delete_forever,

                      title:
                      "Delete Account",

                      subtitle:
                      "Permanently delete your account.",

                      color:
                      Colors.redAccent,

                      onTap: () {

                        showDialog(

                          context: context,

                          builder: (context) {

                            return AlertDialog(

                              backgroundColor:
                              const Color(
                                0xFF151127,
                              ),

                              title: const Text(

                                "Delete Account",

                                style: TextStyle(
                                  color:
                                  Colors.white,
                                ),
                              ),

                              content: const Text(

                                "Are you sure you want to permanently delete your account?",

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

                                    deleteAccount();
                                  },

                                  child: const Text(

                                    "Delete",

                                    style: TextStyle(
                                      color:
                                      Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.05,
                    ),
                  ],
                ),
              ),
            ),

            /// =========================
            /// LOADING
            /// =========================
            if (isLoading)

              Container(

                color:
                Colors.black54,

                child: const Center(

                  child:
                  CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// SECURITY CARD
  /// =========================
  Widget securityCard(

      double width, {

        required IconData icon,

        required String title,

        required String subtitle,

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

              border: Border.all(

                color:
                color.withOpacity(
                  0.25,
                ),
              ),
            ),

            child: Row(

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

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Text(

                        title,

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
                        height: 6,
                      ),

                      Text(

                        subtitle,

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