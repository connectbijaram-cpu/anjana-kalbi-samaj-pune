import 'package:flutter/material.dart';

class FPColors {
  static const maroon = Color(0xFF8B0018);
  static const darkMaroon = Color(0xFF5C0010);
  static const gold = Color(0xFFFFC400);
  static const green = Color(0xFF237A3B);
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final contactController = TextEditingController();
  final otpController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  int _step = 1; // 1 = Enter contact, 2 = Enter OTP, 3 = Reset password

  void _sendOtp() {
    if (contactController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile or email'), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => _step = 2);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dummy OTP sent: 1234'), backgroundColor: FPColors.green),
    );
  }

  void _verifyOtp() {
    if (otpController.text.trim() != '1234') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP! Use 1234'), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => _step = 3);
  }

  void _resetPassword() {
    if (newPassController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!'), backgroundColor: Colors.red),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset successfully!'), backgroundColor: FPColors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FPColors.darkMaroon,
      appBar: AppBar(
        backgroundColor: FPColors.maroon,
        foregroundColor: Colors.white,
        title: const Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.lock_reset, size: 80, color: FPColors.gold),
              const SizedBox(height: 20),
              Text(
                _step == 1 ? 'Enter your registered mobile or email'
                    : _step == 2 ? 'Enter the OTP sent to you'
                    : 'Set your new password',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 30),

              if (_step == 1) ...[
                _input(contactController, 'Mobile or Email', Icons.person_outline),
                const SizedBox(height: 20),
                _button('Send OTP', _sendOtp),
              ] else if (_step == 2) ...[
                _input(otpController, 'Enter OTP (1234)', Icons.lock_outline),
                const SizedBox(height: 20),
                _button('Verify OTP', _verifyOtp),
              ] else ...[
                _input(newPassController, 'New Password', Icons.lock, obscure: true),
                const SizedBox(height: 14),
                _input(confirmPassController, 'Confirm New Password', Icons.lock, obscure: true),
                const SizedBox(height: 20),
                _button('Reset Password', _resetPassword),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, IconData icon, {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white, fontSize: 17),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: FPColors.gold),
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

  Widget _button(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: FPColors.gold,
          foregroundColor: FPColors.darkMaroon,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
