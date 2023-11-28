import 'package:flutter/material.dart';

Widget buildScrollableTextBox({
  required BuildContext context,
  required String title,
  required String content,
}) {
  Color primaryColor =
      Theme.of(context).colorScheme.primary; // Getting the primary color

  return Card(
    elevation: 2,
    margin: const EdgeInsets.all(8.0), // This adds space around the card
    color:
        primaryColor, // Using the primary color as the card's background color
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Fit content in the column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            // Flexible widget used to make the text scrollable within the card
            child: SingleChildScrollView(
              child: Text(
                content,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 26, 34, 59)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
