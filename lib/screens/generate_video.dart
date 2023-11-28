import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:imagine_swe/screens/display_video.dart';
import 'package:lottie/lottie.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final TextEditingController _promptController = TextEditingController();
  String? _predictionId;
  bool _isLoading = false;
  String? _videoUrl;

  Future<void> _submitForm() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _videoUrl = null;
    });

    try {
      const apiUrl = 'https://api.replicate.com/v1/predictions';
      const apiToken = 'r8_XwC1tAfpl0NnhiEnrISiNNDm5rXgTNe242NrA';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $apiToken',
        },
        body: jsonEncode({
          'version':
              'b57dddff6ae2029be57eab3d17e0de5f1c83b822f0defd8ce49bee44d7b52ee6',
          'input': {
            'prompt': _promptController.text,
            'negative_prompt': 'blurry',
            'scheduler': 'EulerAncestralDiscreteScheduler',
            'steps': 30,
            'mp4': false,
          },
        }),
      );

      if (response.statusCode >= 200) {
        final Map<String, dynamic> predictionData = json.decode(response.body);
        print('Prediction Data: $predictionData');
        if (predictionData.containsKey('id')) {
          _predictionId = predictionData['id'];
          print('Prediction ID: $_predictionId');
          _waitForResponse();
        } else {
          print('Error: Response does not contain the "id" field.');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    // finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  Future<void> _checkPredictionStatus(String predictionId) async {
    try {
      const apiToken =
          'r8_XwC1tAfpl0NnhiEnrISiNNDm5rXgTNe242NrA'; // Replace with your API token
      final apiUrl = 'https://api.replicate.com/v1/predictions/$predictionId';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $apiToken',
        },
      );

      if (response.statusCode >= 200) {
        final Map<String, dynamic> predictionData = json.decode(response.body);
        if (predictionData.containsKey('output')) {
          final String videoUrl = predictionData['output'];
          setState(() {
            _videoUrl = videoUrl;
            _isLoading = false;
            _promptController.clear();
          });
        } else {
          print('Error: Response does not contain the "output" field.');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error checking prediction status: $error');
    }
  }

  Future<void> _waitForResponse() async {
    const pollInterval =
        Duration(seconds: 180); // Adjust the interval as needed
    Timer.periodic(pollInterval, (Timer timer) async {
      if (_predictionId != null) {
        await _checkPredictionStatus(_predictionId!);
        if (_videoUrl != null || _isLoading == false) {
          timer
              .cancel(); // Stop polling when response is ready or an error occurs
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Generation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 14, 123, 190), // Matched AppBar color
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    image: AssetImage(
                      'assets/images/generate_video_image.png', // Placeholder image for video
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _promptController,
                decoration: InputDecoration(
                  hintText: 'Enter your text prompt for the video',
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

            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 14, 123, 190), // Matched button color
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Generate Video',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (_videoUrl == null && _isLoading)
              Center(
                child: Lottie.asset(
                  "assets/animations/rocketForImage.json",
                  height: 150,
                ),
              ),
            const SizedBox(height: 20),

            if (_videoUrl != null && !_isLoading)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayGifScreen(gifUrl: _videoUrl!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 126, 158, 178), // Matched button color
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View Your Video',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            // If _videoUrl is null and _isLoading is false, then the generation has not started or finished

            // Show a message if no video URL is available after loading
          ],
        ),
      ),
    );
  }
}
