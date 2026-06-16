import 'dart:io' show Platform;
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart' show AndroidDeviceInfo, DeviceInfoPlugin;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:office_meet/Service/notification_service.dart' show NotificationService;
import 'package:office_meet/widget/premium_snackbar.dart' show showPremiumSnackBar;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}

class _SettingsPageState
    extends State<SettingsPage> {
  String deviceName = "Loading...";
  Future<void> getDeviceInfo() async {

    try {

      final deviceInfo =
      DeviceInfoPlugin();

      if (Platform.isAndroid) {

        final androidInfo =

        await deviceInfo.androidInfo;

        setState(() {

          deviceName =

          "${androidInfo.brand} "
              "${androidInfo.model}";
        });
      }

    } catch (e) {

      setState(() {

        deviceName =
        "Android Device";
      });
    }
  }

  bool meetingNotification = true;

  @override
  void initState() {

    super.initState();

    loadSettings();
    getDeviceInfo();
  }

  /// =========================
  /// LOAD SETTINGS
  /// =========================
  Future<void> loadSettings() async {

    final prefs =
    await SharedPreferences.getInstance();

    final savedValue =
        prefs.getBool(
          "meetingNotification",
        ) ?? true;

    if (mounted) {

      setState(() {

        meetingNotification =
            savedValue;
      });
    }
  }

  /// =========================
  /// SAVE SETTINGS
  /// =========================
  Future<void> saveSettings() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(

      "meetingNotification",

      meetingNotification,
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

    final currentUser =
        FirebaseAuth
            .instance
            .currentUser;

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
            /// BODY
            /// =========================
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

                        icon:
                        Icons
                            .arrow_back_ios_new,

                        onTap: () {

                          Navigator.pop(
                            context,
                          );
                        },
                      ),

                      Text(

                        "Settings",

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

                        icon:
                        Icons.settings,

                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
                  ),

                  /// =========================
                  /// HEADER
                  /// =========================
                  premiumHeader(
                    width,
                    height,
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
                  ),

                  /// =========================
                  /// NOTIFICATION
                  /// =========================
                  sectionTitle(

                    width,

                    "Notification Settings",
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  settingsSwitchCard(

                    width,

                    icon:
                    Icons.notifications_active,

                    title:
                    "Meeting Notifications",

                    subtitle:
                    "Receive upcoming meeting reminders.",

                    color:
                    const Color(
                      0xFF00E5FF,
                    ),

                    value:
                    meetingNotification,
                      onChanged: (value) async {

                        if (value) {

                          final granted =
                          await NotificationService
                              .requestPermission();

                          if (!granted) {

                            showPremiumSnackBar(
                              context: context,
                              message: "Notification permission denied",
                              color: Colors.redAccent,
                              icon: Icons.notifications_off,
                            );

                            return;
                          }

                          await NotificationService
                              .testNotification();

                        } else {

                          await NotificationService
                              .cancelAllNotifications();
                        }
                        setState(() {

                          meetingNotification = value;
                        });

                        await saveSettings();

                        showPremiumSnackBar(

                          context: context,

                          message:

                          value
                              ? "Meeting notifications enabled"
                              : "Meeting notifications disabled",

                          color:

                          value
                              ? Colors.greenAccent
                              : Colors.orangeAccent,

                          icon:

                          value
                              ? Icons.notifications_active
                              : Icons.notifications_off,
                        );
                      }
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
                  ),

                  /// =========================
                  /// ACCOUNT
                  /// =========================
                  sectionTitle(

                    width,

                    "Account & Security",
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  /// EMAIL STATUS
                  actionCard(

                    width,

                    icon:

                    currentUser!
                        .emailVerified

                        ? Icons.verified

                        : Icons.warning_amber_rounded,

                    title:
                    "Email Verification",

                    subtitle:

                    currentUser
                        .emailVerified

                        ? "Verified Account"

                        : "Email not verified",

                    color:

                    currentUser
                        .emailVerified

                        ? Colors.greenAccent

                        : Colors.orangeAccent,

                    onTap: () async {

                      if (!currentUser
                          .emailVerified) {

                        await currentUser
                            .sendEmailVerification();

                        if (context
                            .mounted) {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            const SnackBar(

                              content: Text(

                                "Verification email sent",
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  /// CHANGE PASSWORD
                  actionCard(

                    width,

                    icon:
                    Icons.lock_reset,

                    title:
                    "Change Password",

                    subtitle:
                    "Send password reset email.",

                    color:
                    Colors.cyanAccent,

                    onTap: () async {

                      if (currentUser
                          .email !=
                          null) {

                        await FirebaseAuth
                            .instance
                            .sendPasswordResetEmail(

                          email:
                          currentUser.email!,
                        );

                        if (context
                            .mounted) {

                          showPremiumSnackBar(

                            context: context,

                            message:
                            "Password reset email sent successfully",

                            color:
                            Colors.greenAccent,

                            icon:
                            Icons.check_circle,
                          );

                        }
                      }
                    },
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  /// DELETE ACCOUNT
                  actionCard(

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

                        context:
                        context,

                        builder: (_) {

                          return AlertDialog(

                            backgroundColor:
                            const Color(
                              0xFF151025,
                            ),

                            shape:
                            RoundedRectangleBorder(

                              borderRadius:
                              BorderRadius.circular(
                                24,
                              ),
                            ),

                            title:
                            const Text(

                              "Delete Account",

                              style: TextStyle(

                                color:
                                Colors.white,
                              ),
                            ),

                            content:
                            const Text(

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

                                child:
                                const Text(

                                  "Cancel",
                                ),
                              ),

                              TextButton(

                                onPressed:
                                    () async {

                                  await currentUser
                                      .delete();

                                  if (context
                                      .mounted) {

                                    Navigator.pop(
                                      context,
                                    );
                                  }
                                },

                                child:
                                const Text(

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
                    height * 0.04,
                  ),

                  /// =========================
                  /// WORKSPACE INFO
                  /// =========================
                  sectionTitle(

                    width,

                    "Workspace Info",
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  infoCard(

                    width,

                    icon:
                    Icons.devices,

                    title:
                    "Current Device",

                    subtitle:
                    deviceName,
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  infoCard(

                    width,

                    icon:
                    Icons.info_outline,

                    title:
                    "App Version",

                    subtitle:
                    "Office Meet v1.0.0",
                  ),

                  SizedBox(
                    height:
                    height * 0.04,
                  ),

                  /// =========================
                  /// SUPPORT
                  /// =========================
                  sectionTitle(

                    width,

                    "Help & Support",
                  ),

                  SizedBox(
                    height:
                    height * 0.02,
                  ),

                  actionCard(

                    width,

                    icon:
                    Icons.support_agent,

                    title:
                    "Contact Support",

                    subtitle:
                    "Get help from support team.",

                    color:
                    Colors.pinkAccent,

                    onTap: () {
                      showPremiumSnackBar(

                        context: context,

                        message:
                        "Support team will contact you soon",

                        color:
                        Colors.pinkAccent,

                        icon:
                        Icons.support_agent,
                      );

                    },
                  ),

                  SizedBox(
                    height:
                    height * 0.06,
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
  /// HEADER
  /// =========================
  Widget premiumHeader(
      double width,
      double height,
      ) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(32),

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
              32,
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

              Container(

                padding:
                const EdgeInsets.all(
                  18,
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

                  Icons.settings,

                  color:
                  Colors.white,

                  size:
                  width * 0.11,
                ),
              ),

              SizedBox(
                height:
                height * 0.025,
              ),

              Text(

                "Workspace Settings",

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

              Text(

                "Manage your workspace preferences.",

                textAlign:
                TextAlign.center,

                style: TextStyle(

                  color:
                  Colors.white70,

                  fontSize:
                  width * 0.034,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// SECTION TITLE
  /// =========================
  Widget sectionTitle(
      double width,
      String title,
      ) {

    return Text(

      title,

      style: TextStyle(

        color:
        Colors.white,

        fontWeight:
        FontWeight.bold,

        fontSize:
        width * 0.048,
      ),
    );
  }

  /// =========================
  /// SWITCH CARD
  /// =========================
  Widget settingsSwitchCard(

      double width, {

        required IconData icon,

        required String title,

        required String subtitle,

        required Color color,

        required bool value,

        required Function(bool)
        onChanged,
      }) {

    return glassCard(

      child: Row(

        children: [

          iconCircle(
            icon,
            color,
          ),

          const SizedBox(
            width: 18,
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
                    Colors.white,

                    fontWeight:
                    FontWeight.bold,

                    fontSize:
                    width * 0.040,
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
                    width * 0.031,
                  ),
                ),
              ],
            ),
          ),

          Switch(

            value: value,

            activeColor:
            color,

            onChanged:
            onChanged,
          ),
        ],
      ),
    );
  }

  /// =========================
  /// ACTION CARD
  /// =========================
  Widget actionCard(

      double width, {

        required IconData icon,

        required String title,

        required String subtitle,

        required Color color,

        required VoidCallback onTap,
      }) {

    return GestureDetector(

      onTap: onTap,

      child: glassCard(

        child: Row(

          children: [

            iconCircle(
              icon,
              color,
            ),

            const SizedBox(
              width: 18,
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
                      Colors.white,

                      fontWeight:
                      FontWeight.bold,

                      fontSize:
                      width * 0.040,
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
                      width * 0.031,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(

              Icons.arrow_forward_ios,

              color:
              Colors.white54,

              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// INFO CARD
  /// =========================
  Widget infoCard(

      double width, {

        required IconData icon,

        required String title,

        required String subtitle,
      }) {

    return glassCard(

      child: Row(

        children: [

          iconCircle(
            icon,
            Colors.cyanAccent,
          ),

          const SizedBox(
            width: 18,
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
                    Colors.white,

                    fontWeight:
                    FontWeight.bold,

                    fontSize:
                    width * 0.040,
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
                    width * 0.031,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// GLASS CARD
  /// =========================
  Widget glassCard({
    required Widget child,
  }) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(28),

      child: BackdropFilter(

        filter:
        ImageFilter.blur(

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

            border:
            Border.all(

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

  /// =========================
  /// ICON CIRCLE
  /// =========================
  Widget iconCircle(
      IconData icon,
      Color color,
      ) {

    return Container(

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
    );
  }

  /// =========================
  /// TOP BUTTON
  /// =========================
  Widget topButton({

    required IconData icon,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: ClipRRect(

        borderRadius:
        BorderRadius.circular(18),

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