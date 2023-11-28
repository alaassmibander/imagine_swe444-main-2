// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// // import 'package:imagine_swe/API/image_api.dart';
// import 'package:imagine_swe/widgets/display_image_ai.dart';
// import 'package:lottie/lottie.dart';
// import 'package:http/http.dart' as http;

// class GeneratePhoto extends StatefulWidget {
//   const GeneratePhoto({super.key});

//   @override
//   State<GeneratePhoto> createState() => _GeneratePhotoState();
// }

// class _GeneratePhotoState extends State<GeneratePhoto> {
//   final textController = TextEditingController();
//   bool isLoading = false;

//   Future<dynamic> convertTextToImage(
//       String prompt, BuildContext context) async {
//     Uint8List imageData = Uint8List(0);

//     const baseURL = 'https://api.stability.ai';
//     final url = Uri.parse(
//         '$baseURL/v1/generation/stable-diffusion-512-v2-1/text-to-image'); // Git it from POST in text to image doc

//     //Make the HTTP POST request to the stability platform API

//     final response = await http.post(url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//               'Bearer sk-fADf39hwAaLMgmlmMOvqhoiplZeyh141p49xMk4n7h7RI3XO',
//           'Accept': 'image/png',
//         },
//         body: jsonEncode({
//           'cfg_scale': 15,
//           'clip_guidance_preset': 'FAST_BLUE',
//           "height": 512,
//           "width": 512,
//           "samples": 1,
//           "steps": 150,
//           'seed': 0,
//           'style_preset': '3d-model',
//           'text_prompts': [
//             {
//               'text': prompt,
//               'weight': 1,
//             }
//           ],
//         }));

//     if (response.statusCode == 200) {
//       try {
//         imageData = (response.bodyBytes);
//         // ignore: use_build_context_synchronously
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DisplayImageAi(image: imageData)));
//         return response.bodyBytes;
//       } on Exception {
//         return const Center(child: Text('Something went wrong'));
//       }
//     } else {
//       return const Center(child: Text('X'));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Generate Image',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 14, 123, 190),
//         ),
//         body: SingleChildScrollView(
//             child: Column(
//           children: [
//             const SizedBox(
//               height: 100,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                         //color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         image: const DecorationImage(
//                             alignment: Alignment.center,
//                             fit: BoxFit.contain,
//                             image: AssetImage(
//                                 'assets/images/sammy-searching.png')))),
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextField(
//                     autocorrect: true,
//                     autofocus: false,
//                     maxLength: 100,
//                     controller: textController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your promot',
//                       fillColor: const Color.fromARGB(153, 251, 251, 251),
//                       filled: true,
//                       contentPadding: const EdgeInsets.all(16),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             if (!isLoading)
//               SizedBox(
//                 width: 200,
//                 height: 60,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     convertTextToImage(textController.text, context);
//                     isLoading = true;

//                     setState(() {});
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 14, 123, 190),
//                       textStyle: const TextStyle(fontSize: 20),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12))),
//                   child: const Text(
//                     "Generate Image",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             if (isLoading)
//               Center(
//                 child: Lottie.asset(
//                   "assets/animations/rocketForImage.json",
//                   height: 200,
//                 ),
//               ),
//           ],
//         )));
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:imagine_swe/widgets/display_image_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class GeneratePhoto extends StatefulWidget {
  const GeneratePhoto({Key? key}) : super(key: key);

  @override
  State<GeneratePhoto> createState() => _GeneratePhotoState();
}

class _GeneratePhotoState extends State<GeneratePhoto> {
  final textController = TextEditingController();
  bool isLoading = false;

  Future<void> convertTextToImage(String prompt) async {
    setState(() {
      isLoading = true; // Start loading
    });

    const baseURL = 'https://api.stability.ai';
    final url = Uri.parse(
        '$baseURL/v1/generation/stable-diffusion-512-v2-1/text-to-image');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer sk-fADf39hwAaLMgmlmMOvqhoiplZeyh141p49xMk4n7h7RI3XO', // Replace with your actual API key
        'Accept': 'image/png',
      },
      body: jsonEncode({
        'cfg_scale': 15,
        'clip_guidance_preset': 'FAST_BLUE',
        "height": 512,
        "width": 512,
        "samples": 1,
        "steps": 150,
        'seed': 0,
        'style_preset': '3d-model',
        'text_prompts': [
          {
            'text': prompt,
            'weight': 1,
          },
        ],
      }),
    );

    // Handle the post-request process.
    if (mounted) {
      setState(() {
        isLoading = false; // Stop loading
      });
    }

    if (response.statusCode == 200) {
      Uint8List imageData = response.bodyBytes;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageAi(image: imageData),
        ),
      );
    } else {
      // Handle the error, maybe show an error dialog or a snackbar.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to generate image. Please try again later.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generate Image',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 123, 190),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/sammy-searching.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Enter your prompt',
                  fillColor: const Color.fromARGB(153, 251, 251, 251),
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLength: 100,
              ),
            ),
            const SizedBox(height: 30),
            if (!isLoading)
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    convertTextToImage(textController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 14, 123, 190),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Generate Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (isLoading)
              Center(
                child: Lottie.asset(
                  'assets/animations/rocketForImage.json',
                  height: 200,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
