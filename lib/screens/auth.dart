import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imagine_swe/screens/forgot_password.dart';
import 'package:imagine_swe/services/auth_service.dart';

import 'package:imagine_swe/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lottie/lottie.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLoggin = true;
  var _enteredEmail = "";
  var _enteredUsername = "";
  var _enteredPassword = "";
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLoggin) {
        // Login
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        // Signup
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        if (_selectedImage != null) {
          // Only upload the image if it's not null.
          final storageRef = FirebaseStorage.instance
              .ref()
              .child("user_images")
              .child("${userCredential.user!.uid}.jpg");

          // Upload image
          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();

          // Create document and set data in the database
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.uid)
              .set({
            "username": _enteredUsername,
            "email": _enteredEmail,
            "image_url": imageUrl,
          });
        } else {
          // If no image was selected, use a default image URL or a placeholder.
          const defaultImageUrl = "assets/images/default-user1.png";
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.uid)
              .set({
            "username": _enteredUsername,
            "email": _enteredEmail,
            "image_url": defaultImageUrl,
          });
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("The email is already used, Try another one or Sign up"),
          ),
        );
        setState(() {
          _isAuthenticating = false;
        });
      } else {
        // User does not exist
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User does not exist. Please sign up."),
          ),
        );
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 0,
                  left: 20,
                  right: 20,
                ),
                // width: 300,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                      "assets/images/rocket.png",
                      width: _isLoggin ? 300 : 250,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLoggin)
                            UserImagePicker(
                              onPickedImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            //Email
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return "please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          if (!_isLoggin)
                            TextFormField(
                              //username in Signup only
                              decoration:
                                  const InputDecoration(labelText: "Username"),
                              keyboardType: TextInputType.name,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return "Please enter at least 4 character";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _enteredUsername = newValue!;
                              },
                            ),
                          TextFormField(
                            //password
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return "password must be at least 8 character long";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating) //Loading after submit
                            //To do: Lottie Animation
                            Lottie.asset(
                              "assets/animations/animation_rocket.json",
                              height: 100,
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (!_isAuthenticating)
                            GestureDetector(
                              onTap: _submit,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _isLoggin ? "Login" : "Signup",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isLoggin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ForgotPasswordPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              ],
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLoggin = !_isLoggin;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _isLoggin
                                        ? "Do not have an account? "
                                        : "Already have an account? ",
                                    style: const TextStyle(
                                        // Style for the "Do not have an account?" and "Already have an account?" part
                                        ),
                                  ),
                                  Text(
                                    _isLoggin ? "Signup" : "Login",
                                    style: const TextStyle(
                                      fontWeight: FontWeight
                                          .bold, // Make "Signup" and "Login" text bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              final result =
                                  await AuthService().signInWithGoogle();
                              if (result != null) {
                                setState(() {
                                  _isAuthenticating = true;
                                });
                              } else {
                                setState(() {
                                  _isAuthenticating = false;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFFFAFDFD),
                              ),
                              child: Image.asset(
                                "assets/images/google.png",
                                height: 25,
                              ),
                            ),
                          ),
                        ],
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
}
