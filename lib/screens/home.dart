import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imagine_swe/authentication/models/usermodel.dart';
import 'package:imagine_swe/authentication/controllers/profile_controller.dart';
import 'package:imagine_swe/screens/generate_image.dart';
import 'package:imagine_swe/screens/drawer.dart';
import 'package:imagine_swe/screens/generate_video.dart';
import 'package:imagine_swe/widgets/custom_slider.dart';
import 'package:imagine_swe/widgets/promo_card.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final controller = profile_controller();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings or perform other actions
            },
          ),
        ],
      ),
      drawer: const drawer(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                usermodel userData = snapshot.data as usermodel;
                var name =
                    userData.username; // upload the username from firebase
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi $name',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ready to imagine?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 30,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your previous works',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomSlider(),
                      const SizedBox(height: 20),
                      const PromoCard(
                        image: 'assets/images/draw.png',
                        text: 'Generate Image',
                        destinationScreen: GeneratePhoto(),
                      ),
                      const SizedBox(height: 10),
                      const PromoCard(
                        image: 'assets/images/vid.png',
                        text: 'Generate Video',
                        destinationScreen: VideoScreen(),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('An error occurred'));
              } else {
                return const Center(child: Text('No data found'));
              }
            } else {
              return Center(
                child: Lottie.asset(
                  "assets/animations/animation_rocket.json",
                  height: 75,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
