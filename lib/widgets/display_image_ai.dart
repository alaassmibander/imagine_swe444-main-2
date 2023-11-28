import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DisplayImageAi extends StatefulWidget {
  final Uint8List image;

  const DisplayImageAi({super.key, required this.image});

  @override
  State<DisplayImageAi> createState() => _DisplayImageAiState();
}

class _DisplayImageAiState extends State<DisplayImageAi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GeneratePhoto'),
        ),
        backgroundColor: Colors.white, // Matched AppBar color

        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 227, 227),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.memory(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Align the buttons in the center of the screen
              children: [
                IconButton(
                  icon: const Icon(Icons.share, size: 50),
                  onPressed: () async {
                    try {
                      final t = await getTemporaryDirectory();
                      final path = '${t.path}/sharedImage.jpg';
                      File(path).writeAsBytesSync(widget.image);

                      // Share the image using the Share plugin
                      // ignore: deprecated_member_use
                      Share.shareFiles([path]);
                    } catch (e) {
                      print('Error sharing image: $e');
                    }
                  },
                ),
              ],
            ),
          ]),
        ));
  }
}
