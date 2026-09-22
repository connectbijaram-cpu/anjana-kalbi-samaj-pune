import 'package:flutter/material.dart';

// =======================
// ADMIN COLORS (यही रंग रखेंगे)
// =======================

class AdminColors {
  static const maroon = Color(0xFF8B0018);
  static const darkMaroon = Color(0xFF5C0010);
  static const gold = Color(0xFFFFC400);
  static const lightGold = Color(0xFFFFE8A3);
  static const cream = Color(0xFFFFF8E8);
  static const blue = Color(0xFF124B8C);
  static const green = Color(0xFF237A3B);
}

// =======================
// ADMIN LOGIN SCREEN
// =======================

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  void _login() {
    if (usernameController.text.trim() == 'admin' &&
        passwordController.text.trim() == 'admin123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Admin Credentials!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.darkMaroon,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 45),

              // Admin Icon
              Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AdminColors.gold,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(
                  Icons.admin_panel_settings,
                  size: 55,
                  color: AdminColors.maroon,
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Admin Panel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AdminColors.gold,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Anjana Kalbi Samaj',
                style: TextStyle(color: Colors.white70, fontSize: 19),
              ),

              const SizedBox(height: 50),

              _input(
                controller: usernameController,
                hint: 'Admin Username',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              _passwordInput(),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AdminColors.gold,
                    foregroundColor: AdminColors.darkMaroon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Login as Admin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Hint: admin / admin123',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 17),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AdminColors.gold),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: .14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return TextField(
      controller: passwordController,
      obscureText: obscurePassword,
      style: const TextStyle(color: Colors.white, fontSize: 17),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline, color: AdminColors.gold),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AdminColors.gold,
          ),
        ),
        hintText: 'Admin Password',
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: .14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// =======================
// ADMIN DASHBOARD
// =======================

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.cream,
      appBar: AppBar(
        backgroundColor: AdminColors.maroon,
        foregroundColor: Colors.white,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminLoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AdminColors.darkMaroon,
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                _statCard('1,245', 'Total Members', Icons.people, AdminColors.blue),
                const SizedBox(width: 12),
                _statCard('34', 'Pending', Icons.pending_actions, Colors.orange),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _statCard('6', 'Announcements', Icons.campaign, AdminColors.green),
                const SizedBox(width: 12),
                _statCard('12', 'Events', Icons.event, AdminColors.maroon),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Manage',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AdminColors.darkMaroon,
              ),
            ),
            const SizedBox(height: 15),

            _menuTile(
              context,
              title: 'Manage Members',
              subtitle: 'View, approve or delete members',
              icon: Icons.manage_accounts,
              color: AdminColors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageMembersScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _menuTile(
              context,
              title: 'Manage Announcements',
              subtitle: 'Add or delete announcements',
              icon: Icons.campaign,
              color: AdminColors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageAnnouncementsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String number, String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(
              number,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AdminColors.darkMaroon,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AdminColors.darkMaroon,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

// =======================
// MANAGE MEMBERS
// =======================

class ManageMembersScreen extends StatelessWidget {
  const ManageMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'Ramesh Kumar', 'village': 'Pune', 'mobile': '9876543210', 'status': 'Approved'},
      {'name': 'Suresh Patil', 'village': 'Satara', 'mobile': '9876543211', 'status': 'Pending'},
      {'name': 'Mahesh Jadhav', 'village': 'Kolhapur', 'mobile': '9876543212', 'status': 'Approved'},
      {'name': 'Ganesh Shinde', 'village': 'Sangli', 'mobile': '9876543213', 'status': 'Pending'},
      {'name': 'Vijay More', 'village': 'Solapur', 'mobile': '9876543214', 'status': 'Approved'},
    ];

    return Scaffold(
      backgroundColor: AdminColors.cream,
      appBar: AppBar(
        backgroundColor: AdminColors.maroon,
        foregroundColor: Colors.white,
        title: const Text('Manage Members'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          final isPending = member['status'] == 'Pending';
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
                  backgroundColor: isPending ? Colors.orange.shade100 : AdminColors.blue.withValues(alpha: 0.15),
                  child: Icon(
                    isPending ? Icons.pending : Icons.person,
                    color: isPending ? Colors.orange : AdminColors.blue,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AdminColors.darkMaroon,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${member['village']} • ${member['mobile']}',
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                if (isPending) ...[
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: AdminColors.green),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${member['name']} approved!')),
                      );
                    },
                  ),
                ],
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${member['name']} deleted!')),
                    );
                  },
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
// MANAGE ANNOUNCEMENTS
// =======================

class ManageAnnouncementsScreen extends StatelessWidget {
  const ManageAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      {'title': 'Mass Marriage Conference', 'subtitle': 'Upcoming society event'},
      {'title': 'State Level Meeting', 'subtitle': 'Important meeting and decisions'},
      {'title': 'Educational Assistance', 'subtitle': 'For students'},
    ];

    return Scaffold(
      backgroundColor: AdminColors.cream,
      appBar: AppBar(
        backgroundColor: AdminColors.green,
        foregroundColor: Colors.white,
        title: const Text('Manage Announcements'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AdminColors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Announcement feature coming soon!')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add New'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final item = announcements[index];
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AdminColors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.campaign, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AdminColors.darkMaroon,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item['subtitle']!,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['title']} deleted!')),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
