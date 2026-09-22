import 'package:flutter/material.dart';

// =======================
// PAGE COLORS
// =======================

class PageColors {
  static const maroon = Color(0xFF8B0018);
  static const darkMaroon = Color(0xFF5C0010);
  static const gold = Color(0xFFFFC400);
  static const cream = Color(0xFFFFF8E8);
  static const blue = Color(0xFF124B8C);
  static const green = Color(0xFF237A3B);
}

// =======================
// GENERIC MENU LIST SCREEN
// =======================

class MenuListScreen extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final List<Map<String, String>> items;

  const MenuListScreen({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageColors.cream,
      appBar: AppBar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: color,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item['subtitle']!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
