import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/material.dart';
import 'package:office_meet/Auth/login.dart' show LoginPage;
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(

      backgroundColor: const Color(0xFF020617),

      body: SafeArea(

        child: Stack(
          children: [

            /// BACKGROUND
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

            /// LEFT BALL
            Positioned(

              left: -90,
              top: size.height * 0.34,

              child: glowBall(
                size: size.width * 0.42,
              ),
            ),

            /// TOP BALL
            Positioned(

              top: size.height * 0.03,
              left: size.width * 0.30,

              child: glowBall(
                size: size.width * 0.28,
              ),
            ),

            /// RIGHT BALL
            Positioned(

              right: -90,
              bottom: size.height * 0.15,

              child: glowBall(
                size: size.width * 0.45,
              ),
            ),

            /// BOTTOM BALL
            Positioned(

              bottom: size.height * 0.03,
              left: size.width * 0.40,

              child: glowBall(
                size: size.width * 0.16,
              ),
            ),

            /// MAIN CARD
            SingleChildScrollView(

            physics:
            const BouncingScrollPhysics(),

            child: ConstrainedBox(

    constraints: BoxConstraints(
    minHeight:
    MediaQuery.of(context).size.height,
    ),
              child: Center(
              
                child: SingleChildScrollView(
              
                  physics:
                  const BouncingScrollPhysics(),
              
                  child: Padding(
              
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
              
                    child: ClipRRect(
              
                      borderRadius:
                      BorderRadius.circular(34),
              
                      child: BackdropFilter(
              
                        filter: ImageFilter.blur(
                          sigmaX: 18,
                          sigmaY: 18,
                        ),
              
                        child: Container(
              
                          width: double.infinity,
              
                          padding:
                          EdgeInsets.symmetric(
              
                            horizontal: 24,
              
                            vertical:
                            isSmall ? 28 : 34,
                          ),
              
                          decoration: BoxDecoration(
              
                            borderRadius:
                            BorderRadius.circular(34),
              
                            color:
                            Colors.white.withOpacity(0.05),
              
                            border: Border.all(
              
                              color:
                              Colors.white.withOpacity(0.12),
              
                              width: 1,
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
              
                                  "Create Account",
              
                                  style: TextStyle(
              
                                    color: Colors.white,
              
                                    fontSize:
                                    isSmall ? 30 : 38,
              
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
              
                              const SizedBox(height: 10),
              
                              /// SUBTITLE
                              Text(
              
                                "Join Acote and start smart workspace collaboration.",
              
                                textAlign:
                                TextAlign.center,
              
                                style: TextStyle(
              
                                  color:
                                  Colors.white70,
              
                                  fontSize:
                                  isSmall ? 13 : 15,
              
                                  height: 1.6,
                                ),
                              ),
              
                              SizedBox(
                                  height:
                                  isSmall ? 28 : 36),
              
                              /// FULL NAME
                              buildInputField(
              
                                hint: "Full Name",
              
                                icon:
                                Icons.person_outline,
              
                                controller:
                                nameController,
                              ),
              
                              const SizedBox(height: 18),
              
                              /// EMAIL
                              buildInputField(
              
                                hint: "Email Address",
              
                                icon:
                                Icons.email_outlined,
              
                                controller:
                                emailController,
                              ),
              
                              const SizedBox(height: 18),
              
                              /// PASSWORD
                              buildPasswordField(
              
                                hint: "Password",
              
                                controller:
                                passwordController,
              
                                obscureText:
                                obscurePassword,
              
                                onToggle: () {
              
                                  setState(() {
              
                                    obscurePassword =
                                    !obscurePassword;
                                  });
                                },
                              ),
              
                              const SizedBox(height: 18),
              
                              /// CONFIRM PASSWORD
                              buildPasswordField(
              
                                hint:
                                "Confirm Password",
              
                                controller:
                                confirmPasswordController,
              
                                obscureText:
                                obscureConfirmPassword,
              
                                onToggle: () {
              
                                  setState(() {
              
                                    obscureConfirmPassword =
                                    !obscureConfirmPassword;
                                  });
                                },
                              ),
              
                              const SizedBox(height: 16),
              
                              /// PASSWORD STRENGTH
                              Column(
              
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
              
                                children: [
              
                                  Row(
              
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
              
                                    children: [
              
                                      Text(
              
                                        "Password Strength",
              
                                        style: TextStyle(
              
                                          color:
                                          Colors.white70,
              
                                          fontSize:
                                          isSmall ? 12 : 13,
                                        ),
                                      ),
              
                                      Text(
              
                                        getPasswordStrength(
                                            passwordController.text),
              
                                        style: TextStyle(
              
                                          color:
                                          getPasswordStrengthColor(
                                              passwordController.text),
              
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
              
                                  const SizedBox(height: 8),
              
                                  ClipRRect(
              
                                    borderRadius:
                                    BorderRadius.circular(20),
              
                                    child: LinearProgressIndicator(
              
                                      minHeight: 8,
              
                                      value:
                                      passwordController.text.isEmpty
                                          ? 0
                                          : passwordController.text.length / 12,
              
                                      backgroundColor:
                                      Colors.white10,
              
                                      valueColor:
                                      AlwaysStoppedAnimation(
              
                                        getPasswordStrengthColor(
                                            passwordController.text),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
              
                              const SizedBox(height: 18),
              
                              /// TERMS
                              Row(
              
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
              
                                children: [
              
                                  Checkbox(
              
                                    value: agreeTerms,
              
                                    activeColor:
                                    const Color(0xFF2CE6A6),
              
                                    onChanged: (value) {
              
                                      setState(() {
              
                                        agreeTerms = value!;
                                      });
                                    },
                                  ),
              
                                  Expanded(
              
                                    child: Wrap(
              
                                      children: [
              
                                        const Text(
              
                                          "I agree to the ",
              
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
              
                                        GestureDetector(
              
                                          onTap: () {
              
                                            showTermsBottomSheet();
                                          },
              
                                          child: const Text(
              
                                            "Terms & Conditions",
              
                                            style: TextStyle(
              
                                              color: Color(0xFF2CE6A6),
              
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
              
                              SizedBox(
                                  height:
                                  isSmall ? 30 : 38),
              
                              /// SIGNUP BUTTON
                              GestureDetector(
              
                                onTap: ()async  {
              
                                  if (nameController.text
                                      .trim()
                                      .isEmpty ||
              
                                      emailController.text
                                          .trim()
                                          .isEmpty ||
              
                                      passwordController.text
                                          .trim()
                                          .isEmpty ||
              
                                      confirmPasswordController
                                          .text
                                          .trim()
                                          .isEmpty) {
              
                                    showCustomSnackBar(
                                      "Please fill in all required fields.",
                                    );
              
                                    return;
                                  }
              
                                  if (!emailController.text
                                      .trim()
                                      .endsWith(
                                      "@acotegroup.com")) {
              
                                    showCustomSnackBar(
                                      "Please use your official Acote Group email address.",
                                    );
              
                                    return;
                                  }
              
                                  if (passwordController.text.length < 6) {
              
                                    showCustomSnackBar(
                                      "Password must contain at least 6 characters.",
                                    );
              
                                    return;
                                  }
              
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
              
                                    showCustomSnackBar(
                                      "Passwords do not match. Please try again.",
                                    );
              
                                    return;
                                  }
              
                                  if (!agreeTerms) {
              
                                    showCustomSnackBar(
                                      "Please accept the Terms & Conditions to continue.",
                                    );
              
                                    return;
                                  }

                                  try {

                                    final credential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(

                                      email:
                                      emailController.text.trim(),

                                      password:
                                      passwordController.text.trim(),
                                    );

                                    await credential.user!
                                        .sendEmailVerification();

                                    /// SAVE USER DATA
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(credential.user!.uid)
                                        .set({

                                      "fullName":
                                      nameController.text.trim(),

                                      "email":
                                      emailController.text.trim(),

                                      "designation": "",

                                      "department": "",

                                      "joiningDate": "",

                                      "profileImage": "",

                                      "verified": false,

                                      "createdAt":
                                      DateTime.now(),
                                    });

                                    showCustomSnackBar(

                                      "Verification email has been sent. Please verify your account before signing in.",
                                    );

                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );

                                    Navigator.pushReplacement(

                                      context,

                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPage(),
                                      ),
                                    );

                                  } on FirebaseAuthException catch (e) {

                                    showCustomSnackBar(

                                      e.message ??
                                          "Signup failed.",
                                    );
                                  }
                                },
              
                                child: Container(
              
                                  height:
                                  isSmall ? 56 : 62,
              
                                  width: double.infinity,
              
                                  decoration: BoxDecoration(
              
                                    borderRadius:
                                    BorderRadius.circular(
                                        40),
              
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
                                        const Color(
                                            0xFF2CE6A6)
                                            .withOpacity(
                                            0.35),
              
                                        blurRadius: 22,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
              
                                  child: Center(
              
                                    child: Text(
              
                                      "SIGN UP",
              
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
              
                              const SizedBox(height: 24),
              
                              /// LOGIN TEXT
                              Row(
              
                                mainAxisAlignment:
                                MainAxisAlignment.center,
              
                                children: [
              
                                  Text(
              
                                    "Already have an account?",
              
                                    style: TextStyle(
              
                                      color:
                                      Colors.white70,
              
                                      fontSize:
                                      isSmall ? 13 : 14,
                                    ),
                                  ),
              
                                  const SizedBox(width: 6),
              
                                   GestureDetector(
                                     onTap: (){
                                       Navigator.push(

                                         context,

                                         MaterialPageRoute(
                                           builder: (context) =>
                                           const LoginPage(),
                                         ),
                                       );
                                     },
                                     child: Text(

                                      "Sign In",

                                      style: TextStyle(

                                        color:
                                        Color(0xFF2CE6A6),

                                        fontWeight:
                                        FontWeight.bold,
                                      ),
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
            ),
    )],
        ),
      ),
    );
  }

  /// INPUT FIELD
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

  /// PASSWORD FIELD
  Widget buildPasswordField({

    required String hint,

    required TextEditingController controller,

    required bool obscureText,

    required VoidCallback onToggle,
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

        obscureText: obscureText,

        onChanged: (value) {

          setState(() {});
        },

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

          prefixIcon: const Icon(

            Icons.lock_outline,

            color:
            Color(0xFF6BFFA7),
          ),

          suffixIcon: IconButton(

            onPressed: onToggle,

            icon: Icon(

              obscureText
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

  /// PASSWORD STRENGTH
  String getPasswordStrength(String password) {

    if (password.isEmpty) {
      return "";
    }

    if (password.length < 6) {
      return "Weak";
    }

    if (password.length < 10) {
      return "Medium";
    }

    return "Strong";
  }

  Color getPasswordStrengthColor(String password) {

    if (password.isEmpty) {
      return Colors.grey;
    }

    if (password.length < 6) {
      return Colors.redAccent;
    }

    if (password.length < 10) {
      return Colors.orangeAccent;
    }

    return const Color(0xFF2CE6A6);
  }

  /// GLOW BALL
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

  /// SNACKBAR
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

  /// TERMS BOTTOM SHEET
  void showTermsBottomSheet() {

    showModalBottomSheet(

      context: context,

      backgroundColor:
      Colors.transparent,

      isScrollControlled: true,

      builder: (context) {

        return SafeArea(
          child: Container(
          
            height:
            MediaQuery.of(context).size.height * 0.70,
          
            padding: const EdgeInsets.all(24),
          
            decoration: const BoxDecoration(
          
              color: Color(0xFF071120),
          
              borderRadius: BorderRadius.only(
          
                topLeft:
                Radius.circular(30),
          
                topRight:
                Radius.circular(30),
              ),
            ),
          
            child: Column(
          
              crossAxisAlignment:
              CrossAxisAlignment.start,
          
              children: [
          
                Center(
          
                  child: Container(
          
                    height: 5,
                    width: 70,
          
                    decoration: BoxDecoration(
          
                      color: Colors.white24,
          
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                  ),
                ),
          
                const SizedBox(height: 28),
          
                const Text(
          
                  "Terms & Conditions",
          
                  style: TextStyle(
          
                    color: Color(0xFF2CE6A6),
          
                    fontSize: 24,
          
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
          
                const SizedBox(height: 20),
          
                Expanded(
          
                  child: SingleChildScrollView(
          
                    child: Text(
          
                      """
1. Your Acote account is strictly for official workspace collaboration.

2. Users must use a valid @acotegroup.com email address.

3. Sharing confidential workspace data outside the organization is prohibited.

4. Users are responsible for maintaining account security and password confidentiality.

5. Any misuse of the platform may result in temporary or permanent account suspension.

6. Acote reserves the right to update policies and system features at any time.

7. By creating an account, you agree to comply with all company collaboration and security policies.
                    """,
          
                      style: TextStyle(
          
                        color: Colors.white70,
          
                        fontSize: 15,
          
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 20),
          
                GestureDetector(
          
                  onTap: () {
          
                    Navigator.pop(context);
          
                    setState(() {
          
                      agreeTerms = true;
                    });
                  },
          
                  child: Container(
          
                    height: 58,
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
                    ),
          
                    child: const Center(
          
                      child: Text(
          
                        "I AGREE",
          
                        style: TextStyle(
          
                          color: Colors.white,
          
                          fontSize: 16,
          
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}