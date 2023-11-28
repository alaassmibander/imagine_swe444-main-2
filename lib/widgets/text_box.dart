import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;

  const MyTextBox({super.key, required this.text, required this.sectionName, required Null Function(dynamic value) onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(204, 225, 219, 219),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(fontSize: 18, color: Colors.grey[700]),),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings))
            ],
          ),

          //text
          Text(text, style: TextStyle(fontSize: 16 ,color: const Color.fromARGB(255, 0, 0, 0)),),
        ],
      ),
    );
  }
}
