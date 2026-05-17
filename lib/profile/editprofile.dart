import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:office_meet/API/upload_image.dart'
    show CloudinaryService;

class EditProfilePage
    extends StatefulWidget {

  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage>
  createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {

  final fullNameController =
  TextEditingController();

  final designationController =
  TextEditingController();

  final joiningDateController =
  TextEditingController();

  String email = "";

  String profileImage = "";

  bool isLoading = true;

  File? selectedImage;
  final emailController = TextEditingController();

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
          FirebaseAuth
              .instance
              .currentUser!
              .uid;

      final userData =
      await FirebaseFirestore
          .instance
          .collection("users")
          .doc(uid)
          .get();

      if (userData.exists) {

        fullNameController.text =
            userData["fullName"] ?? "";

        designationController.text =
            userData["designation"] ?? "";

        joiningDateController.text =
            userData["joiningDate"] ?? "";
        emailController.text =
            FirebaseAuth
                .instance
                .currentUser
                ?.email ?? "";



        profileImage =
            userData["profileImage"] ?? "";
      }

      setState(() {

        isLoading = false;
      });

    } catch (e) {

      setState(() {

        isLoading = false;
      });
    }
  }

  /// =========================
  /// PICK IMAGE
  /// =========================
  Future<void> pickImage() async {

    final picker = ImagePicker();

    final pickedImage =
    await picker.pickImage(

      source:
      ImageSource.gallery,
    );

    if (pickedImage != null) {

      selectedImage =
          File(
            pickedImage.path,
          );

      setState(() {});

      await uploadProfileImage();
    }
  }

  /// =========================
  /// UPLOAD IMAGE
  /// =========================
  Future<void>
  uploadProfileImage() async {

    if (selectedImage == null) return;

    final imageUrl =
    await CloudinaryService
        .uploadImage(
      selectedImage!,
    );

    if (imageUrl != null) {

      profileImage = imageUrl;

      await FirebaseFirestore
          .instance
          .collection("users")
          .doc(
        FirebaseAuth
            .instance
            .currentUser!
            .uid,
      )
          .update({

        "profileImage":
        profileImage,
      });

      setState(() {});

      customSnackBar(
        "Profile image updated",
      );
    }
  }

  /// =========================
  /// SAVE PROFILE
  /// =========================
  Future<void> saveProfile() async {

    try {

      await FirebaseFirestore
          .instance
          .collection("users")
          .doc(
        FirebaseAuth
            .instance
            .currentUser!
            .uid,
      )
          .update({

        "fullName":
        fullNameController.text
            .trim(),

        "designation":
        designationController.text
            .trim(),

        "joiningDate":
        joiningDateController.text
            .trim(),
      });

      customSnackBar(
        "Profile updated successfully",
      );

    } catch (e) {

      customSnackBar(
        "Something went wrong",
      );
    }
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

        content:
        Text(message),

        backgroundColor:
        Colors.purpleAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor:
      const Color(0xFF070B1A),

      body: isLoading

          ? const Center(

        child:
        CircularProgressIndicator(),
      )

          : SafeArea(

        child: SingleChildScrollView(

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

                    circleButton(

                      Icons.arrow_back_ios_new,

                          () {

                        Navigator.pop(
                          context,
                        );
                      },
                    ),

                    Text(

                      "Edit Profile",

                      style: TextStyle(

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight.bold,

                        fontSize:
                        width * 0.06,
                      ),
                    ),

                    circleButton(

                      Icons.settings,

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
                Center(

                  child: Stack(
                    children: [

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

                      Positioned(

                        bottom: 0,
                        right: 0,

                        child:
                        GestureDetector(

                          onTap:
                          pickImage,

                          child:
                          Container(

                            padding:
                            const EdgeInsets.all(
                              12,
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

                            child:
                            const Icon(

                              Icons.edit,

                              color:
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height:
                  height * 0.05,
                ),

                /// =========================
                /// FULL NAME
                /// =========================
                buildTitle(
                  "Full Name",
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                buildTextField(

                  controller:
                  fullNameController,

                  hint:
                  "Enter full name",

                  onChanged: (value) async {

                    await FirebaseFirestore
                        .instance
                        .collection("users")
                        .doc(
                      FirebaseAuth
                          .instance
                          .currentUser!
                          .uid,
                    )
                        .update({

                      "fullName": value,
                    });
                  },
                ),

                SizedBox(
                  height:
                  height * 0.03,
                ),

                /// =========================
                /// EMAIL
                /// =========================
                buildTitle(
                  "Email",
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                buildTextField(

                  enabled: false,

                  controller:
                  emailController,

                  hint:
                  "Email",
                ),

                SizedBox(
                  height:
                  height * 0.03,
                ),

                /// =========================
                /// DESIGNATION
                /// =========================
                buildTitle(
                  "Designation",
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                buildTextField(

                  controller:
                  designationController,

                  hint:
                  "Write your designation",

                  onChanged: (value) async {

                    await FirebaseFirestore
                        .instance
                        .collection("users")
                        .doc(
                      FirebaseAuth
                          .instance
                          .currentUser!
                          .uid,
                    )
                        .update({

                      "designation": value,
                    });
                  },
                ),

                SizedBox(
                  height:
                  height * 0.03,
                ),

                /// =========================
                /// JOINING DATE
                /// =========================
                buildTitle(
                  "Joining Date",
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                buildTextField(

                  controller:
                  joiningDateController,

                  hint:
                  "22 May 2025",

                  onChanged: (value) async {

                    await FirebaseFirestore
                        .instance
                        .collection("users")
                        .doc(
                      FirebaseAuth
                          .instance
                          .currentUser!
                          .uid,
                    )
                        .update({

                      "joiningDate": value,
                    });
                  },
                ),

                SizedBox(
                  height:
                  height * 0.06,
                ),
                /// =========================
                /// DEPARTMENT
                /// =========================
                buildTitle(
                  "Department",
                ),

                SizedBox(
                  height:
                  height * 0.015,
                ),

                Container(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  decoration: BoxDecoration(

                    borderRadius:
                    BorderRadius.circular(20),

                    color:
                    Colors.white.withOpacity(
                      0.05,
                    ),
                  ),

                  child: DropdownButtonHideUnderline(

                    child: DropdownButton<String>(

                      value:
                      selectedDepartment,

                      dropdownColor:
                      const Color(0xFF111827),

                      isExpanded: true,

                      icon: const Icon(

                        Icons.keyboard_arrow_down,

                        color: Colors.white,
                      ),

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 16,
                      ),

                      hint: const Text(

                        "Select Department",

                        style: TextStyle(

                          color: Colors.white54,
                        ),
                      ),

                      items:
                      departments.map((department) {

                        return DropdownMenuItem(

                          value: department,

                          child: Text(
                            department,
                          ),
                        );
                      }).toList(),

                      onChanged: (value) async {

                        setState(() {

                          selectedDepartment =
                          value!;
                        });

                        await FirebaseFirestore
                            .instance
                            .collection("users")
                            .doc(
                          FirebaseAuth
                              .instance
                              .currentUser!
                              .uid,
                        )
                            .update({

                          "department":
                          selectedDepartment,
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  height * 0.03,
                ),
                SizedBox(
                  height:
                  height * 0.06,
                ),
                /// =========================
                /// SAVE BUTTON
                /// =========================
                GestureDetector(

                  onTap:
                  saveProfile,

                  child: Container(

                    height:
                    height * 0.075,

                    width:
                    double.infinity,

                    decoration:
                    BoxDecoration(

                      borderRadius:
                      BorderRadius.circular(
                        22,
                      ),

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
                          Colors
                              .purpleAccent
                              .withOpacity(
                            0.35,
                          ),

                          blurRadius:
                          25,
                        ),
                      ],
                    ),

                    child: Center(

                      child: Text(

                        "Save Changes",

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,

                          fontSize:
                          width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:
                  height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// TITLE
  /// =========================
  Widget buildTitle(
      String title,
      ) {

    return Text(

      title,

      style: const TextStyle(

        color:
        Colors.white,

        fontWeight:
        FontWeight.w600,

        fontSize: 16,
      ),
    );
  }

  /// =========================
  /// TEXTFIELD
  /// =========================
  Widget buildTextField({

    required TextEditingController
    controller,

    required String hint,

    bool enabled = true,

    Function(String)? onChanged,
  }) {

    return TextField(

      controller:
      controller,

      enabled:
      enabled,

      onChanged:
      onChanged,

      style:
      const TextStyle(

        color:
        Colors.white,
      ),

      decoration:
      InputDecoration(

        hintText:
        hint,

        hintStyle:
        TextStyle(

          color:
          Colors.white
              .withOpacity(
            0.45,
          ),
        ),

        filled:
        true,

        fillColor:
        Colors.white
            .withOpacity(
          0.05,
        ),

        contentPadding:
        const EdgeInsets.symmetric(

          horizontal: 20,
          vertical: 18,
        ),

        border:
        OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(
            20,
          ),

          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }

  /// =========================
  /// CIRCLE BUTTON
  /// =========================
  Widget circleButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        height: 50,
        width: 50,

        decoration: BoxDecoration(

          shape:
          BoxShape.circle,

          color:
          Colors.white
              .withOpacity(
            0.06,
          ),
        ),

        child: Icon(

          icon,

          color:
          Colors.white,
        ),
      ),
    );
  }
}