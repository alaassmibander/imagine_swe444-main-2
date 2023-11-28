import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DisplayGifScreen extends StatefulWidget {
  final String gifUrl;

  const DisplayGifScreen({Key? key, required this.gifUrl}) : super(key: key);

  @override
  State<DisplayGifScreen> createState() => _DisplayGifScreenState();
}

class _DisplayGifScreenState extends State<DisplayGifScreen> {
  Future<File> _saveAndGetGifFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final gifFile = File('${documentDirectory.path}/gif.gif');
    return gifFile.writeAsBytes(response.bodyBytes);
  }

  void _shareGif(String path) {
    Share.shareFiles([path], mimeTypes: ["image/gif"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Video'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 227, 227),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    widget.gifUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.share, size: 50),
                  onPressed: () async {
                    try {
                      final gifFile = await _saveAndGetGifFile(widget.gifUrl);
                      _shareGif(gifFile.path);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error sharing gif: $e')),
                      );
                    }
                  },
                ),
                // Add more buttons here if needed, for example, a download button
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
