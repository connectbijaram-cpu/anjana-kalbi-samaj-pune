import 'package:flutter/material.dart';

class TabColors {
  static const maroon = Color(0xFF8B0018);
  static const darkMaroon = Color(0xFF5C0010);
  static const gold = Color(0xFFFFC400);
  static const cream = Color(0xFFFFF8E8);
  static const blue = Color(0xFF124B8C);
  static const green = Color(0xFF237A3B);
}

// =======================
// MEMBERS SCREEN
// =======================

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'Ramesh Kumar', 'village': 'Pune', 'mobile': '9876543210'},
      {'name': 'Suresh Patil', 'village': 'Satara', 'mobile': '9876543211'},
      {'name': 'Mahesh Jadhav', 'village': 'Kolhapur', 'mobile': '9876543212'},
      {'name': 'Ganesh Shinde', 'village': 'Sangli', 'mobile': '9876543213'},
      {'name': 'Vijay More', 'village': 'Solapur', 'mobile': '9876543214'},
      {'name': 'Anil Deshmukh', 'village': 'Nashik', 'mobile': '9876543215'},
    ];

    return Scaffold(
      backgroundColor: TabColors.cream,
      appBar: AppBar(
        backgroundColor: TabColors.maroon,
        foregroundColor: Colors.white,
        title: const Text('Members', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: TabColors.maroon),
                hintText: 'Search members...',
                filled: true,
                fillColor: TabColors.cream,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final m = members[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: TabColors.gold,
                        child: Text(
                          (m['name'] as String)[0],
                          style: const TextStyle(color: TabColors.maroon, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: TabColors.darkMaroon)),
                            const SizedBox(height: 3),
                            Text('${m['village']} • ${m['mobile']}', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                          ],
                        ),
                      ),
                      IconButton(icon: const Icon(Icons.phone, color: TabColors.green), onPressed: () {}),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// CHAT SCREEN
// =======================

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'name': 'Society Group', 'msg': 'Meeting tomorrow at 5 PM', 'time': '10:30 AM', 'count': '3', 'url': 'https://i.pravatar.cc/150?img=10'},
      {'name': 'Ramesh Kumar', 'msg': 'Thanks for the update!', 'time': 'Yesterday', 'count': '', 'url': 'https://i.pravatar.cc/150?img=11'},
      {'name': 'Suresh Patil', 'msg': 'Please share the photos', 'time': 'Yesterday', 'count': '', 'url': 'https://i.pravatar.cc/150?img=12'},
      {'name': 'Event Committee', 'msg': 'Venue confirmed for 25 Dec', 'time': 'Mon', 'count': '1', 'url': 'https://i.pravatar.cc/150?img=13'},
      {'name': 'Mahesh Jadhav', 'msg': 'See you at the meeting', 'time': 'Sun', 'count': '', 'url': 'https://i.pravatar.cc/150?img=14'},
    ];

    return Scaffold(
      backgroundColor: TabColors.cream,
      appBar: AppBar(
        backgroundColor: TabColors.maroon,
        foregroundColor: Colors.white,
        title: const Text('Chats', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final c = chats[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        barrierColor: Colors.black54,
                        pageBuilder: (_, _, _) => FullNetworkImage(imageUrl: c['url']!),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: TabColors.gold,
                    backgroundImage: NetworkImage(c['url']!),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: TabColors.darkMaroon)),
                      const SizedBox(height: 3),
                      Text(c['msg']!, style: const TextStyle(fontSize: 13, color: Colors.black54), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(c['time']!, style: const TextStyle(fontSize: 11, color: Colors.black38)),
                    const SizedBox(height: 5),
                    if ((c['count'] as String).isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: TabColors.green, shape: BoxShape.circle),
                        child: Text(c['count']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =======================
// FULL NETWORK IMAGE VIEWER (Blur Background)
// =======================

class FullNetworkImage extends StatelessWidget {
  final String imageUrl;
  const FullNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black.withValues(alpha: 0.85),
          child: Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: Hero(
                tag: imageUrl,
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =======================
// UPDATES SCREEN
// =======================

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TabColors.cream,
      appBar: AppBar(
        backgroundColor: TabColors.maroon,
        foregroundColor: Colors.white,
        title: const Text('Updates', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _updateCard('New Member Joined', 'Suresh Patil joined the society today', Icons.person_add, TabColors.blue),
          _updateCard('Announcement Posted', 'Mass Marriage Conference on 25 Dec 2025', Icons.campaign, TabColors.maroon),
          _updateCard('Event Created', 'Annual General Meeting scheduled', Icons.event, TabColors.green),
          _updateCard('Blood Donor Added', 'New O+ donor registered', Icons.bloodtype, Colors.red),
          _updateCard('Gallery Updated', '120 new photos added to Annual Function', Icons.photo_library, Colors.purple),
        ],
      ),
    );
  }

  Widget _updateCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
