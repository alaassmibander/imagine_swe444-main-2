// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:imagine_swe/widgets/display_image_ai.dart';

// Future<dynamic> convertTextToImage(String prompt, BuildContext context) async {
//   Uint8List imageData = Uint8List(0);

//   const baseURL = 'https://api.stability.ai';
//   final url = Uri.parse(
//       '$baseURL/v1/generation/stable-diffusion-512-v2-1/text-to-image'); // Git it from POST in text to image doc

//   //Make the HTTP POST request to the stability platform API

//   final response = await http.post(url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization':
//             'Bearer sk-DUMTRSIaJyzOjKEoTAOC8rv5xQ41aItradG8u6xY2wI2ggu9',
//         'Accept': 'image/png',
//       },
//       body: jsonEncode({
//         'cfg_scale': 15,
//         'clip_guidance_preset': 'FAST_BLUE',
//         "height": 512,
//         "width": 512,
//         "samples": 1,
//         "steps": 150,
//         'seed': 0,
//         'style_preset': '3d-model',
//         'text_prompts': [
//           {
//             'text': prompt,
//             'weight': 1,
//           }
//         ],
//       }));

//   if (response.statusCode == 200) {
//     try {
//       imageData = (response.bodyBytes);
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => DisplayImageAi(image: imageData)));
//       return response.bodyBytes;
//     } on Exception {
//       return const Center(child: Text('Something went wrong'));
//     }
//   } else {
//     return const Center(child: Text('X'));
//   }
// }
