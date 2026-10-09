import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _mailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  bool _termsAgreed = false;
  bool _hidePass = true;
  bool _hideConfirmPass = true;

  static const Color _primaryColor = Color(0xFF1A6556);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    if (!(_registrationFormKey.currentState?.validate() ?? false)) {
      return;
    }

    if (!_termsAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan setujui persyaratan dan privasi pengguna terlebih dahulu',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/verificationWithNoHP');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _registrationFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "BUAT AKUN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(child: _buildBrandedLogo()),
                  const SizedBox(height: 35),

                  // Username field
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: "Nama Pengguna",
                      prefixIcon: const Icon(Icons.person_outline),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama pengguna tidak boleh kosong';
                      }
                      if (val.trim().length < 3) {
                        return 'Nama pengguna minimal 3 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  TextFormField(
                    controller: _mailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.mail_outline),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailPattern.hasMatch(val.trim())) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone field
                  TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Nomor Hp",
                      prefixIcon: const Icon(Icons.phone_outlined),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nomor HP tidak boleh kosong';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(val.trim())) {
                        return 'Nomor HP hanya boleh berisi angka';
                      }
                      if (val.trim().length < 10) {
                        return 'Nomor HP minimal 10 digit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _hidePass,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePass ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _hidePass = !_hidePass;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kata sandi tidak boleh kosong';
                      }
                      if (val.length < 6) {
                        return 'Kata sandi minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm password field
                  TextFormField(
                    controller: _confirmPassCtrl,
                    obscureText: _hideConfirmPass,
                    decoration: InputDecoration(
                      labelText: "Konfirmasi Kata Sandi",
                      prefixIcon: const Icon(Icons.lock_reset_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hideConfirmPass ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _hideConfirmPass = !_hideConfirmPass;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Konfirmasi kata sandi tidak boleh kosong';
                      }
                      if (val != _passCtrl.text) {
                        return 'Konfirmasi kata sandi tidak cocok';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Terms checkbox
                  CheckboxListTile(
                    value: _termsAgreed,
                    onChanged: (checked) {
                      setState(() {
                        _termsAgreed = checked ?? false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: _primaryColor,
                    title: Text.rich(
                      TextSpan(
                        text: 'Saya telah menyetujui ',
                        style: const TextStyle(fontSize: 12.5, color: Colors.black87),
                        children: const [
                          TextSpan(
                            text: 'persyaratan dan privasi pengguna',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Submit button
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: _handleRegistration,
                      child: const Text(
                        'BUAT AKUN',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandedLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'ECOWA',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: _primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: SvgPicture.asset(
            'lib/assets/images/runner_green.svg',
            width: 42,
            height: 42,
          ),
        ),
        const Text(
          'K',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: _primaryColor,
          ),
        ),
      ],
    );
  }
}
