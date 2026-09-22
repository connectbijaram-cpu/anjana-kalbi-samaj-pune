import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppColors2 {
  static const maroon = Color(0xFF8B0018);
  static const darkMaroon = Color(0xFF5C0010);
  static const gold = Color(0xFFFFC400);
  static const cream = Color(0xFFFFF8E8);
  static const blue = Color(0xFF124B8C);
  static const green = Color(0xFF237A3B);
}

// =======================
// BUSINESS MODEL
// =======================

class Business {
  String name;
  String address;
  String city;
  String state;
  String pin;

  Business({
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pin = '',
  });
}

// =======================
// PROFILE SCREEN
// =======================

class ProfileScreen extends StatefulWidget {
  final bool isOwner;
  const ProfileScreen({super.key, this.isOwner = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  bool _isEditing = false;

  // Personal Info
  final nameController = TextEditingController(text: 'Ramesh Kumar');
  final fatherNameController = TextEditingController(text: 'Suresh Kumar');
  final gotraController = TextEditingController(text: 'Kalbi');

  // Contact Info
  final mobileController = TextEditingController(text: '9876543210');
  final whatsappController = TextEditingController(text: '9876543210');
  final emailController = TextEditingController(text: 'ramesh@example.com');

  // Permanent Address
  final permVillageController = TextEditingController(text: 'Pune');
  final permPanchayatController = TextEditingController();
  final permPanchayatSamitiController = TextEditingController();
  final permDistrictController = TextEditingController(text: 'Pune');
  final permStateController = TextEditingController(text: 'Maharashtra');
  final permPinController = TextEditingController();

  // Current Address
  final currAddressController = TextEditingController();
  final currCityController = TextEditingController();
  final currStateController = TextEditingController();
  final currPinController = TextEditingController();

  // Business List
  final List<Business> businesses = [
    Business(name: 'Patil Electronics', address: 'Main Road', city: 'Pune', state: 'Maharashtra', pin: '411001'),
  ];

  // Login Credentials
  final usernameController = TextEditingController(text: '9876543210');
  final passwordController = TextEditingController(text: '••••••••');

  // =======================
  // IMAGE PICKER
  // =======================

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() => _imageFile = File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors2.maroon),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors2.maroon),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewFullImage() {
    if (_imageFile == null) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder: (_, _, _) => FullImageViewer(imageFile: _imageFile!),
      ),
    );
  }

  // =======================
  // CHANGE PASSWORD DIALOG
  // =======================

  void _showChangePasswordDialog() {
    final currentPass = TextEditingController();
    final newPass = TextEditingController();
    final confirmPass = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPass,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors2.maroon),
            onPressed: () {
              if (newPass.text != confirmPass.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match!'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password changed successfully!'),
                  backgroundColor: AppColors2.green,
                ),
              );
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // =======================
  // BECOME OWNER DIALOG
  // =======================

  void _showBecomeOwnerDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Become an Owner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Business / Firm Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Business Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors2.maroon),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request sent! Admin will verify your business.'),
                  backgroundColor: AppColors2.green,
                ),
              );
            },
            child: const Text('Submit Request', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // =======================
  // BUILD METHOD
  // =======================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors2.cream,
      appBar: AppBar(
        backgroundColor: AppColors2.maroon,
        foregroundColor: Colors.white,
        title: Text(_isEditing ? 'Edit Profile' : 'My Profile',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🌈 Cover Photo + Avatar + Name + Stats
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors2.darkMaroon, AppColors2.maroon],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors2.maroon.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -55,
                  child: GestureDetector(
                    onTap: _viewFullImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColors2.gold,
                        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? const Icon(Icons.person, size: 60, color: AppColors2.maroon)
                            : null,
                      ),
                    ),
                  ),
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _showImageOptions,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.camera_alt, color: AppColors2.maroon, size: 18),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 70),

            // Name + Verified
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nameController.text.isEmpty ? 'Your Name' : nameController.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors2.darkMaroon,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: AppColors2.blue, size: 20),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              mobileController.text,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 18),

            // Stats Row
            Row(
              children: [
                _profileStat('12', 'Members', AppColors2.maroon),
                const SizedBox(width: 8),
                _profileStat('3', 'Business', AppColors2.blue),
                const SizedBox(width: 8),
                _profileStat('8', 'Posts', AppColors2.green),
              ],
            ),

            const SizedBox(height: 25),

            // Personal Information Card
            _profileSectionCard('Personal Information', Icons.person, AppColors2.maroon, [
              _field('Full Name', nameController, Icons.person),
              const SizedBox(height: 14),
              _field('Father\'s Name', fatherNameController, Icons.person_outline),
              const SizedBox(height: 14),
              _field('Gotra', gotraController, Icons.family_restroom),
            ]),

            // Contact Information Card
            _profileSectionCard('Contact Information', Icons.phone, AppColors2.blue, [
              _field('Mobile Number', mobileController, Icons.phone, keyboard: TextInputType.phone),
              const SizedBox(height: 14),
              _field('WhatsApp Number', whatsappController, Icons.chat, keyboard: TextInputType.phone),
              const SizedBox(height: 14),
              _field('Email Address', emailController, Icons.email, keyboard: TextInputType.emailAddress),
            ]),

            // Permanent Address Card
            _profileSectionCard('Permanent Address', Icons.home, AppColors2.green, [
              _field('Village', permVillageController, Icons.home),
              const SizedBox(height: 14),
              _field('Panchayat', permPanchayatController, Icons.account_balance),
              const SizedBox(height: 14),
              _field('Panchayat Samiti', permPanchayatSamitiController, Icons.business),
              const SizedBox(height: 14),
              _field('District', permDistrictController, Icons.map),
              const SizedBox(height: 14),
              _field('State', permStateController, Icons.public),
              const SizedBox(height: 14),
              _field('PIN Code', permPinController, Icons.pin, keyboard: TextInputType.number),
            ]),

            // Current Address Card
            _profileSectionCard('Current Address', Icons.location_on, Colors.orange, [
              _field('Address', currAddressController, Icons.location_on),
              const SizedBox(height: 14),
              _field('City', currCityController, Icons.location_city),
              const SizedBox(height: 14),
              _field('State', currStateController, Icons.public),
              const SizedBox(height: 14),
              _field('PIN Code', currPinController, Icons.pin, keyboard: TextInputType.number),
            ]),

            // Business Details Card (Owner के लिए)
            if (widget.isOwner)
              _profileSectionCard(
                'Business Details',
                Icons.business_center,
                AppColors2.gold,
                [
                  ...businesses.asMap().entries.map((entry) {
                    int idx = entry.key;
                    Business b = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors2.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors2.gold.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors2.gold.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.store, color: AppColors2.maroon, size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Business ${idx + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors2.darkMaroon,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              if (_isEditing)
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                  onPressed: () => setState(() => businesses.removeAt(idx)),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _fieldInline('Business Name', b.name, (v) => b.name = v),
                          const SizedBox(height: 10),
                          _fieldInline('Address', b.address, (v) => b.address = v),
                          const SizedBox(height: 10),
                          _fieldInline('City', b.city, (v) => b.city = v),
                          const SizedBox(height: 10),
                          _fieldInline('State', b.state, (v) => b.state = v),
                          const SizedBox(height: 10),
                          _fieldInline('PIN Code', b.pin, (v) => b.pin = v),
                        ],
                      ),
                    );
                  }),
                  if (_isEditing)
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors2.maroon,
                        side: const BorderSide(color: AppColors2.maroon),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () => setState(() => businesses.add(Business())),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Business', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                ],
              )
            else
              // Public User: "Become Owner" Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors2.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors2.gold, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors2.gold.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.business_center, color: AppColors2.maroon, size: 45),
                    const SizedBox(height: 10),
                    const Text(
                      'Want to become a Business Owner?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors2.darkMaroon),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Register your business and get listed in Owner Members list.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors2.maroon,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () => _showBecomeOwnerDialog(),
                        icon: const Icon(Icons.upgrade),
                        label: const Text('Become an Owner', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),

            // Login Credentials Card
            _profileSectionCard('Login Credentials 🔒', Icons.lock, AppColors2.maroon, [
              _readOnlyField('Username (Mobile)', usernameController, Icons.lock_outline),
              const SizedBox(height: 14),
              _readOnlyField('Password', passwordController, Icons.password),
            ]),

            const SizedBox(height: 10),

            // Change Password Button
            if (!_isEditing)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors2.gold,
                    foregroundColor: AppColors2.darkMaroon,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 6,
                    shadowColor: AppColors2.gold.withValues(alpha: 0.5),
                  ),
                  onPressed: _showChangePasswordDialog,
                  icon: const Icon(Icons.lock_reset, size: 20),
                  label: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            const SizedBox(height: 15),

            // Save Changes Button
            if (_isEditing)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors2.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 8,
                    shadowColor: AppColors2.green.withValues(alpha: 0.5),
                  ),
                  onPressed: () {
                    setState(() => _isEditing = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                        backgroundColor: AppColors2.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =======================
  // HELPER METHODS
  // =======================

  Widget _profileStat(String number, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileSectionCard(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, IconData icon, {TextInputType? keyboard}) {
    return TextField(
      controller: controller,
      readOnly: !_isEditing,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors2.maroon),
        filled: true,
        fillColor: _isEditing ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _fieldInline(String label, String value, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      readOnly: !_isEditing,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: _isEditing ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _readOnlyField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: const Icon(Icons.lock, color: Colors.grey, size: 20),
      ),
    );
  }
}

// =======================
// FULL IMAGE VIEWER
// =======================

class FullImageViewer extends StatelessWidget {
  final File imageFile;
  const FullImageViewer({super.key, required this.imageFile});

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
              child: Image.file(imageFile, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}

// =======================
// NOTIFICATIONS SCREEN
// =======================

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'New Announcement', 'subtitle': 'Mass Marriage Conference on 25 Dec', 'icon': Icons.campaign, 'color': AppColors2.maroon},
      {'title': 'Event Reminder', 'subtitle': 'Annual General Meeting tomorrow', 'icon': Icons.event, 'color': AppColors2.green},
      {'title': 'New Member Registered', 'subtitle': 'Suresh Patil joined the society', 'icon': Icons.person_add, 'color': AppColors2.blue},
      {'title': 'Blood Donor Request', 'subtitle': 'O+ blood needed urgently', 'icon': Icons.bloodtype, 'color': Colors.red},
      {'title': 'Payment Reminder', 'subtitle': 'Membership fee due next week', 'icon': Icons.payment, 'color': Colors.orange},
    ];

    return Scaffold(
      backgroundColor: AppColors2.cream,
      appBar: AppBar(
        backgroundColor: AppColors2.maroon,
        foregroundColor: Colors.white,
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: (n['color'] as Color).withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: (n['color'] as Color).withValues(alpha: 0.15),
                  child: Icon(n['icon'] as IconData, color: n['color'] as Color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors2.darkMaroon)),
                      const SizedBox(height: 3),
                      Text(n['subtitle'] as String, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
