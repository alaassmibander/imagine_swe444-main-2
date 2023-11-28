import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagine_swe/authentication/controllers/profile_controller.dart';
import 'package:imagine_swe/authentication/models/usermodel.dart';
import 'package:imagine_swe/widgets/text_box.dart';
import 'package:lottie/lottie.dart';

class uProfile extends StatefulWidget {
  const uProfile({Key? key});

  @override
  State<uProfile> createState() => _uProfileState();
}

class _uProfileState extends State<uProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late usermodel userData;
  File? _image; // Variable to store the selected image

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final controller = profile_controller();
    final user = await controller.getUserData();
    setState(() {
      userData = user;
      _nameController.text = user.username;
      _emailController.text = user.email;
    });
  }

  Future<void> saveUserData() async {
    userData.username = _nameController.text;
    userData.email = _emailController.text;

    final controller = profile_controller();
    await controller.updateUserData(userData);

    // Show a confirmation dialog
    showAlertDialog(context, "Profile Updated");
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to show a confirmation dialog
  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = profile_controller();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              usermodel userData = snapshot.data as usermodel;

              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Open image picker when profile picture is tapped
                      _pickImage();
                    },
                    child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _image != null
                                  ? Image.file(_image!) // Display the selected image
                                  : userData.imgURL ==
                                      'assets/images/default-user1.png'
                                      ? Image.asset(userData.imgURL)
                                      : Image.network(userData.imgURL),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Open image picker when edit button is pressed
                                _pickImage();
                              },
                              child: Icon(Icons.edit),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(246, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            'My Information',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        // Editable username field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        // Editable email field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        MyTextBox(
                          text: "Free",
                          sectionName: 'Subscription plan',
                          onChanged: (value) {},
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Save changes when the button is pressed
                            saveUserData();
                          },
                          child: const Text('Save Changes'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return Center(
            child: Lottie.asset(
              "assets/animations/animation_rocket.json",
              height: 75,
            ),
          );
        },
      ),
    );
  }
}
