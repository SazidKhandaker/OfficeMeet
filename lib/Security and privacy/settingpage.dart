import 'dart:ui';

import 'package:flutter/material.dart';

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

  bool darkMode = true;

  bool meetingNotification = true;

  bool workspaceAlert = true;

  bool securityAlert = true;

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

                          Icons.settings,

                              () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.045,
                    ),

                    /// =========================
                    /// HEADER CARD
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
                    /// THEME SETTINGS
                    /// =========================
                    sectionTitle(

                      width,

                      "Theme Settings",
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    settingsSwitchCard(

                      width,

                      icon:
                      darkMode

                          ? Icons.dark_mode

                          : Icons.light_mode,

                      title:
                      darkMode

                          ? "Dark Mode"

                          : "Light Mode",

                      subtitle:
                      "Customize your app appearance.",

                      color:
                      const Color(
                        0xFFB026FF,
                      ),

                      value:
                      darkMode,

                      onChanged: (value) {

                        setState(() {

                          darkMode =
                              value;
                        });
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
                    ),

                    /// =========================
                    /// NOTIFICATIONS
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
                      "Receive meeting reminders.",

                      color:
                      const Color(
                        0xFF00E5FF,
                      ),

                      value:
                      meetingNotification,

                      onChanged: (value) {

                        setState(() {

                          meetingNotification =
                              value;
                        });
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    settingsSwitchCard(

                      width,

                      icon:
                      Icons.workspace_premium,

                      title:
                      "Workspace Alerts",

                      subtitle:
                      "Workspace updates & alerts.",

                      color:
                      Colors.greenAccent,

                      value:
                      workspaceAlert,

                      onChanged: (value) {

                        setState(() {

                          workspaceAlert =
                              value;
                        });
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    settingsSwitchCard(

                      width,

                      icon:
                      Icons.security,

                      title:
                      "Security Alerts",

                      subtitle:
                      "Security login notifications.",

                      color:
                      Colors.orangeAccent,

                      value:
                      securityAlert,

                      onChanged: (value) {

                        setState(() {

                          securityAlert =
                              value;
                        });
                      },
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
                    ),

                    /// =========================
                    /// HELP & SUPPORT
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
                      "Get help from our support team.",

                      color:
                      Colors.pinkAccent,

                      onTap: () {

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(

                          const SnackBar(

                            content: Text(

                              "Support team coming soon.",
                            ),
                          ),
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

                "App Settings",

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

                "Customize your workspace experience.",

                textAlign:
                TextAlign.center,

                style: TextStyle(

                  color:
                  Colors.white70,

                  fontSize:
                  width * 0.035,
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

    return ClipRRect(

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
        ),
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