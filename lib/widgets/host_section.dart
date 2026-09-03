import 'package:flutter/material.dart';

class HostSection extends StatelessWidget {
  const HostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 24, backgroundColor: Colors.amber, child: Icon(Icons.mic, color: Colors.black)),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Official Host Room", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text("Broadcasting live audio stream...", style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

