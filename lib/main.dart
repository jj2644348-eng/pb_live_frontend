import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Official Tech Love PB Party App',
      theme: ThemeData.dark(),
      home: const PartyRoomScreen(),
    );
  }
}

class PartyRoomScreen extends StatefulWidget {
  const PartyRoomScreen({super.key});

  @override
  State<PartyRoomScreen> createState() => _PartyRoomScreenState();
}

class _PartyRoomScreenState extends State<PartyRoomScreen> {
  // यहाँ टाइप को सही कर दिया गया है ताकि एरर न आए
  final List<Map<String, String?>> seats = List.generate(15, (index) {
    if (index == 0) {
      return {'name': 'Love Party Owner', 'dp': '001'};
    }
    return null; // Null safety fix
  }).where((seat) => seat != null).cast<Map<String, String?>>().toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Voice & Video Party'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // यहाँ से आगे का UI पार्ट 2 में है
                        Expanded(
              child: GridView.builder(
                itemCount: seats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisC ount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  bool isOccupied = seat['name'] != null;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isOccupied ? Colors.pinkAccent : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.pink,
                          child: Text(seat['dp'] ?? '${index + 1}'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          seat['name'] ?? 'Empty Seat',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

