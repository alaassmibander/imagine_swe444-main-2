import 'package:flutter/material.dart';
import 'package:imagine_swe/screens/home.dart';
import 'package:imagine_swe/widgets/scrolable_text.dart';

class Learn extends StatelessWidget {
  const Learn({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).primaryColor);
    TextStyle contentStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn About the App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 14, 123, 190),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildScrollableTextCard(
            title: 'What is Generative AI?',
            content:
                'Generative AI refers to the class of artificial intelligence algorithms designed '
                'to create new content based on training data. These algorithms understand patterns, '
                'structures, and features of the input data and use this understanding to generate similar, '
                'but original, outputs. This enables the creation of a wide array of digital media, from art '
                'to realistic scenes.',
            titleStyle: titleStyle,
            contentStyle: contentStyle,
          ),
          const SizedBox(height: 16),
          buildScrollableTextCard(
            title: 'How Does it Work?',
            content:
                'Our app utilizes state-of-the-art neural networks, which are forms of deep learning '
                'models that can understand and interpret human language. By providing a text prompt, the '
                'AI analyzes your input and synthesizes new content that corresponds with the given description. '
                'The process involves complex computations but is presented to you through a simple and '
                'user-friendly interface.',
            titleStyle: titleStyle,
            contentStyle: contentStyle,
          ),
          const SizedBox(height: 16),
          buildScrollableTextCard(
            title: 'What You Can Create',
            content:
                'With our app, the only limit is your imagination. From digital art to marketing materials, '
                'photorealistic images or animations, the possibilities are endless. Whether you are looking to '
                'create something entirely new or modify existing content, our AI tools are designed to accommodate '
                'a vast range of creative tasks.',
            titleStyle: titleStyle,
            contentStyle: contentStyle,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 14, 123, 190),
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Start Creating',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildScrollableTextCard({
    required String title,
    required String content,
    required TextStyle titleStyle,
    required TextStyle contentStyle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleStyle),
            const SizedBox(height: 8),
            Text(content, style: contentStyle),
          ],
        ),
      ),
    );
  }
}
