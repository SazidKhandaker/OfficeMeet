import 'dart:ui';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obscurePassword = true;
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final isSmall = size.height < 700;

    return SafeArea(
      child: Scaffold(

        backgroundColor: const Color(0xFF020617),

        body: SafeArea(

          child: Stack(
            children: [

              /// =========================
              /// BACKGROUND
              /// =========================
              Container(

                decoration: const BoxDecoration(

                  gradient: LinearGradient(

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: [

                      Color(0xFF071120),
                      Color(0xFF020617),
                      Color(0xFF08152A),
                    ],
                  ),
                ),
              ),

              /// =========================
              /// LEFT BALL
              /// =========================
              Positioned(

                left: -size.width * 0.20,
                top: size.height * 0.32,

                child: glowBall(
                  size: size.width * 0.45,
                ),
              ),

              /// =========================
              /// TOP BALL
              /// =========================
              Positioned(

                top: size.height * 0.03,
                left: size.width * 0.30,

                child: glowBall(
                  size: size.width * 0.32,
                ),
              ),

              /// =========================
              /// RIGHT BALL
              /// =========================
              Positioned(

                right: -size.width * 0.22,
                bottom: size.height * 0.15,

                child: glowBall(
                  size: size.width * 0.52,
                ),
              ),

              /// =========================
              /// BOTTOM SMALL BALL
              /// =========================
              Positioned(

                bottom: size.height * 0.03,
                left: size.width * 0.38,

                child: glowBall(
                  size: size.width * 0.18,
                ),
              ),

              /// =========================
              /// MAIN CARD
              /// =========================
              /// =========================
              /// MAIN CARD
              /// =========================
              Center(

                child: SingleChildScrollView(

                  physics:
                  const BouncingScrollPhysics(),

                  child: Padding(

                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                    ),

                    child: ClipRRect(

                      borderRadius:
                      BorderRadius.circular(36),

                      child: BackdropFilter(

                        filter: ImageFilter.blur(
                          sigmaX: 20,
                          sigmaY: 20,
                        ),

                        child: Container(

                          width: double.infinity,

                          /// CARD SMALL KORA
                          padding: EdgeInsets.symmetric(

                            horizontal:
                            size.width * 0.06,

                            vertical:
                            size.height * 0.035,
                          ),

                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(36),

                            color:
                            Colors.white.withOpacity(0.05),

                            border: Border.all(

                              color:
                              Colors.white.withOpacity(0.12),

                              width: 1.2,
                            ),
                          ),

                          child: Column(

                            mainAxisSize:
                            MainAxisSize.min,

                            children: [

                              /// TITLE
                              ShaderMask(

                                shaderCallback: (bounds) {

                                  return const LinearGradient(

                                    colors: [

                                      Color(0xFF2CE6A6),

                                      Color(0xFF8BFFD8),
                                    ],
                                  ).createShader(bounds);
                                },

                                child: Text(

                                  "Welcome Back",

                                  textAlign:
                                  TextAlign.center,

                                  style: TextStyle(

                                    color: Colors.white,

                                    fontSize:
                                    isSmall ? 30 : 38,

                                    fontWeight:
                                    FontWeight.bold,

                                    letterSpacing: 1,
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.012),

                              /// SUBTITLE
                              Text(

                                "Sign in to continue workspace collaboration.",

                                textAlign:
                                TextAlign.center,

                                style: TextStyle(

                                  color:
                                  const Color(0xFF94A3B8),

                                  fontSize:
                                  isSmall ? 13 : 15,

                                  height: 1.5,
                                ),
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.04),

                              /// EMAIL
                              buildInputField(

                                hint: "Email Address",

                                icon: Icons.email_outlined,

                                controller: emailController,
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.02),

                              /// PASSWORD
                              buildPasswordField(
                                controller: passwordController,
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.015),

                              /// FORGOT PASSWORD
                              Align(

                                alignment:
                                Alignment.centerRight,

                                child: Text(

                                  "Forgot Password?",

                                  style: TextStyle(

                                    color:
                                    Colors.white70,

                                    fontSize:
                                    isSmall ? 13 : 14,
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.035),

                              /// LOGIN BUTTON
                              GestureDetector(
                                onTap: () {

                                  /// EMPTY CHECK
                                  if (emailController.text.trim().isEmpty ||
                                      passwordController.text.trim().isEmpty) {

                                    showCustomSnackBar(
                                      "Please enter your email and password.",
                                    );

                                    return;
                                  }

                                  /// EMAIL DOMAIN CHECK
                                  if (!emailController.text
                                      .trim()
                                      .endsWith("@acotegroup.com")) {

                                    showCustomSnackBar(
                                      "Please use your official Acote Group email address.",
                                    );

                                    return;
                                  }

                                  /// SUCCESS
                                  showCustomSnackBar(
                                    "Login successful. Welcome back!",
                                  );
                                },
                                child: Container(

                                  height:
                                  isSmall ? 54 : 60,

                                  width: double.infinity,

                                  decoration: BoxDecoration(

                                    borderRadius:
                                    BorderRadius.circular(40),

                                    gradient:
                                    const LinearGradient(

                                      colors: [

                                        Color(0xFF2CE6A6),

                                        Color(0xFF16A34A),
                                      ],
                                    ),

                                    boxShadow: [

                                      BoxShadow(

                                        color:
                                        const Color(0xFF2CE6A6)
                                            .withOpacity(0.35),

                                        blurRadius: 22,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),

                                  child: Center(

                                    child: Text(

                                      "SIGN IN",

                                      style: TextStyle(

                                        color: Colors.white,

                                        fontSize:
                                        isSmall ? 16 : 18,

                                        fontWeight:
                                        FontWeight.bold,

                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height:
                                  size.height * 0.025),

                              /// SIGNUP
                              Row(

                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [

                                  Text(

                                    "Don't have an account?",

                                    style: TextStyle(

                                      color:
                                      Colors.white70,

                                      fontSize:
                                      isSmall ? 13 : 14,
                                    ),
                                  ),

                                  const SizedBox(width: 6),

                                  const Text(

                                    "Sign Up",

                                    style: TextStyle(

                                      color:
                                      Color(0xFF2CE6A6),

                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// INPUT FIELD
  /// =========================
  Widget buildInputField({

    required String hint,

    required IconData icon,

    required TextEditingController controller,
  }) {

    return Container(

      height: 60,

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(20),

        color:
        Colors.white.withOpacity(0.04),

        border: Border.all(

          color:
          const Color(0xFF7DFFB1)
              .withOpacity(0.35),
        ),
      ),

      child: TextField(

        controller: controller,

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(

          border: InputBorder.none,

          hintText: hint,

          hintStyle: const TextStyle(

            color: Colors.white60,
            fontSize: 15,
          ),

          prefixIcon: Icon(

            icon,

            color:
            const Color(0xFF6BFFA7),
          ),

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }

  /// =========================
  /// PASSWORD FIELD
  /// =========================
  Widget buildPasswordField({

    required TextEditingController controller,
  }) {

    return Container(

      height: 60,

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(20),

        color:
        Colors.white.withOpacity(0.04),

        border: Border.all(

          color:
          const Color(0xFF7DFFB1)
              .withOpacity(0.35),
        ),
      ),

      child: TextField(

        controller: controller,

        obscureText: obscurePassword,

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(

          border: InputBorder.none,

          hintText: "Password",

          hintStyle: const TextStyle(

            color: Colors.white60,
            fontSize: 15,
          ),

          prefixIcon: const Icon(

            Icons.lock_outline,

            color:
            Color(0xFF6BFFA7),
          ),

          suffixIcon: IconButton(

            onPressed: () {

              setState(() {

                obscurePassword =
                !obscurePassword;
              });
            },

            icon: Icon(

              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,

              color: Colors.white70,
            ),
          ),

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }

  /// =========================
  /// SOCIAL BUTTON
  /// =========================
  Widget socialButton(String text) {

    return Container(

      height: 58,
      width: 58,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color:
        Colors.white.withOpacity(0.05),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Center(

        child: Text(

          text,

          style: const TextStyle(

            color: Colors.white,

            fontSize: 24,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// =========================
  /// GLOW BALL
  /// =========================
  Widget glowBall({
    required double size,
  }) {

    return Container(

      height: size,
      width: size,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        boxShadow: [

          BoxShadow(

            color:
            const Color(0xFF2CE6A6)
                .withOpacity(0.30),

            blurRadius: 45,
            spreadRadius: 4,
          ),
        ],
      ),

      child: ClipOval(

        child: Container(

          color: Colors.white,

          child: Center(

            child: ShaderMask(

              shaderCallback: (bounds) {

                return const LinearGradient(

                  colors: [

                    Color(0xFF65B741),

                    Color(0xFF2CE6A6),
                  ],
                ).createShader(bounds);
              },

              child: Text(

                "acote",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: size * 0.20,

                  fontWeight:
                  FontWeight.bold,

                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showCustomSnackBar(String message) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
        SnackBarBehavior.floating,

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        margin: const EdgeInsets.all(18),

        content: Container(

          padding:
          const EdgeInsets.symmetric(

            horizontal: 20,
            vertical: 16,
          ),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(18),

            gradient:
            const LinearGradient(

              colors: [

                Color(0xFF1A2E22),

                Color(0xFF102117),
              ],
            ),

            border: Border.all(

              color:
              const Color(0xFF3BFF95)
                  .withOpacity(0.45),
            ),

            boxShadow: [

              BoxShadow(

                color:
                const Color(0xFF3BFF95)
                    .withOpacity(0.18),

                blurRadius: 18,
                spreadRadius: 1,
              ),
            ],
          ),

          child: Row(
            children: [

              const Icon(

                Icons.info_outline,

                color: Color(0xFF6BFFA7),
              ),

              const SizedBox(width: 14),

              Expanded(

                child: Text(

                  message,

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize: 14,

                    height: 1.5,

                    fontWeight:
                    FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        duration:
        const Duration(seconds: 3),
      ),
    );
  }
}