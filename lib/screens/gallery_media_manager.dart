import 'package:flutter/material.dart';

class RoomAndProfileMediaSheet {
  // 1. रूम का पोस्टर / कवर फ़ोटो और रूम नाम सेट करने का सिस्टम
  static void showRoomCoverPicker({
    required BuildContext context,
    required String currentRoomName,
    required String currentCoverUrl,
    required Function(String newName, String newCoverUrl, String selectedBadge) onSave,
  }) {
    final nameCtrl = TextEditingController(text: currentRoomName);
    final urlCtrl = TextEditingController(text: currentCoverUrl);
    String selectedTheme = "👑 Official Club";

    final sampleCovers = [
      "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7", // DJ Party
      "https://images.unsplash.com/photo-1514525253161-7a46d19cd819", // Club Neon
      "https://images.unsplash.com/photo-1470225620780-dba8ba36b745", // Music Stage
      "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4", // VIP Audio
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setSheet) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("🎙️ Room Cover Poster & Title", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "Live Room Name", labelStyle: TextStyle(color: Colors.grey)),
                ),
                TextField(
                  controller: urlCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "Custom Gallery Image Link / URL", labelStyle: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 10),
                const Text("Or Select Club HD Wallpaper Cover:", style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sampleCovers.length,
                    itemBuilder: (_, i) => InkWell(
                      onTap: () => setSheet(() => urlCtrl.text = sampleCovers[i]),
                      child: Container(
                        width: 90,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: urlCtrl.text == sampleCovers[i] ? Colors.pinkAccent : Colors.white24, width: 2),
                          image: DecorationImage(image: NetworkImage(sampleCovers[i]), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                    onPressed: () {
                      onSave(nameCtrl.text.trim().isEmpty ? currentRoomName : nameCtrl.text.trim(), urlCtrl.text.trim(), selectedTheme);
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Room Poster & Name Updated!"), backgroundColor: Colors.green));
                    },
                    child: const Text("Save Room Poster", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 2. प्रोफाइल फ़ोटो (Gallery Upload Link) सेट करने का सिस्टम
  static void showProfilePhotoPicker({
    required BuildContext context,
    required String currentPhotoUrl,
    required Function(String newPhotoUrl) onPhotoSaved,
  }) {
    final photoCtrl = TextEditingController(text: currentPhotoUrl);

    final avatarPresets = [
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
      "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61",
      "https://images.unsplash.com/photo-1527980965255-d3b416303d12",
      "https://images.unsplash.com/photo-1580489944761-15a19d654956",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E193D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (c, setP) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("🖼️ Upload Profile Photo from Gallery", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.amber,
                    backgroundImage: photoCtrl.text.isNotEmpty ? NetworkImage(photoCtrl.text) : null,
                    child: photoCtrl.text.isEmpty ? const Icon(Icons.add_a_photo, size: 30, color: Colors.black) : null,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: photoCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: "Paste Photo Link (ImgBB/PostImages/Google Drive)", labelStyle: TextStyle(color: Colors.grey)),
                  onChanged: (_) => setP(() {}),
                ),
                const SizedBox(height: 10),
                const Text("Or Select VIP Gallery Avatar:", style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: avatarPresets.map((img) => InkWell(
                    onTap: () => setP(() => photoCtrl.text = img),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(img),
                      child: photoCtrl.text == img ? const Icon(Icons.check_circle, color: Colors.pinkAccent) : null,
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007F)),
                    onPressed: () {
                      onPhotoSaved(photoCtrl.text.trim());
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Profile Photo Saved!"), backgroundColor: Colors.green));
                    },
                    child: const Text("Save Photo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

