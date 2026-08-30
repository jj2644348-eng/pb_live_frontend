import 'package:flutter/material.dart';

class VipShopScreen extends StatefulWidget {
  final int userDiamonds;
  final Function(int remainingDiamonds) onDiamondUpdated;
  final Function(Map<String, dynamic> equippedFrame) onFrameEquipped;

  const VipShopScreen({
    super.key,
    required this.userDiamonds,
    required this.onDiamondUpdated,
    required this.onFrameEquipped,
  });

  static void show(
    BuildContext context,
    int diamonds,
    Function(int) onUpdate,
    Function(Map<String, dynamic>) onFrameEquipped,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.85,
        child: VipShopScreen(
          userDiamonds: diamonds,
          onDiamondUpdated: onUpdate,
          onFrameEquipped: onFrameEquipped,
        ),
      ),
    );
  }

  @override
  State<VipShopScreen> createState() => _VipShopScreenState();
}

class _VipShopScreenState extends State<VipShopScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int currentDiamonds;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    currentDiamonds = widget.userDiamonds;
  }

  // 🐉 VIP Animated Frames & National Flag Frames List
  final List<Map<String, dynamic>> shopItems = [
    {
      "name": "🐉 Dragon Fire Frame",
      "type": "Frame",
      "duration": "7 Days",
      "price": 800,
      "icon": "🐉",
      "color": Colors.redAccent,
      "borderGlow": Colors.orange
    },
    {
      "name": "🇮🇳 Indian Flag Pride",
      "type": "Frame",
      "duration": "30 Days",
      "price": 1200,
      "icon": "🇮🇳",
      "color": Colors.green,
      "borderGlow": Colors.amber
    },
    {
      "name": "🦁 Royal Lion Crown",
      "type": "Frame",
      "duration": "30 Days",
      "price": 1500,
      "icon": "🦁",
      "color": Colors.amber,
      "borderGlow": Colors.yellowAccent
    },
    {
      "name": "⚡ Neon Lightning",
      "type": "Frame",
      "duration": "7 Days",
      "price": 600,
      "icon": "⚡",
      "color": Colors.purpleAccent,
      "borderGlow": Colors.cyanAccent
    },
    {
      "name": "🌹 Rose Luxury Ride",
      "type": "Ride",
      "duration": "7 Days",
      "price": 1000,
      "icon": "🌹",
      "color": Colors.pinkAccent,
      "borderGlow": Colors.pink
    },
    {
      "name": "🏎️ Super Sport Car",
      "type": "Ride",
      "duration": "30 Days",
      "price": 3000,
      "icon": "🏎️",
      "color": Colors.blueAccent,
      "borderGlow": Colors.blue
    },
  ];

  void _buyAndEquipItem(Map<String, dynamic> item) {
    int price = item["price"];
    if (currentDiamonds >= price) {
      setState(() {
        currentDiamonds -= price;
      });
      widget.onDiamondUpdated(currentDiamonds);
      widget.onFrameEquipped(item); // Apply frame directly to profile
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("🎉 Purchased & Equipped ${item["name"]} (${item["duration"]})!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Not enough diamonds! Recharge to buy."), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF141026),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              const Text("🛍️ VIP Avatar Shop & Flag Mall", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: const Color(0xFF2A2456), borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    const Text("💎 ", style: TextStyle(fontSize: 12)),
                    Text("$currentDiamonds", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tabs
        TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFF007F),
          labelColor: Colors.amberAccent,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "VIP & Flag Frames"),
            Tab(text: "Entry Rides"),
          ],
        ),

        // Grid View Items
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildItemGrid("Frame"),
              _buildItemGrid("Ride"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemGrid(String category) {
    final filtered = shopItems.where((i) => i["type"] == category).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filtered.length,
      itemBuilder: (ctx, index) {
        final item = filtered[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2456),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: item["color"].withOpacity(0.6), width: 2),
            boxShadow: [
              BoxShadow(
                color: item["borderGlow"].withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Preview Icon Box mimicking profile frame
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: item["borderGlow"], width: 3),
                  color: Colors.black26,
                ),
                child: Center(child: Text(item["icon"], style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(height: 8),
              Text(item["name"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text("Validity: ${item["duration"]}", style: const TextStyle(color: Colors.grey, fontSize: 10)),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: item["color"],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(100, 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _buyAndEquipItem(item),
                child: Text("💎 ${item["price"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
              )
            ],
          ),
        );
      },
    );
  }
}

