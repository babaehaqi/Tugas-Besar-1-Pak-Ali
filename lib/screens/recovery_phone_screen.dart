import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForpassPhoneScreen extends StatefulWidget {
  const ForpassPhoneScreen({super.key});

  @override
  State<ForpassPhoneScreen> createState() => _ForpassPhoneScreenState();
}

class _ForpassPhoneScreenState extends State<ForpassPhoneScreen> {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  static const Color _primaryColor = Color(0xFF1A6556);
  static const Color _headerBackground = Color(0xFFDCE9E8);

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _submitPhoneNumber() {
    if (_phoneFormKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/changePass');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopHeader(),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Notification hint
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.notifications_active_outlined, size: 28, color: Colors.black87),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Periksa dan masukan nomor telepon untuk mendapatkan kode verifikasi',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Phone input field
                    Form(
                      key: _phoneFormKey,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Nomor Hp',
                          hintText: 'Contoh: 081234567890',
                          prefixIcon: const Icon(Icons.phone_outlined),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nomor HP tidak boleh kosong';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                            return 'Nomor HP hanya boleh berisi angka';
                          }
                          if (value.trim().length < 10) {
                            return 'Nomor HP minimal 10 digit';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Switch to Email recovery
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/forpassEmail');
                        },
                        child: const Text(
                          'Gunakan Email',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.cyan,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: _submitPhoneNumber,
                        child: const Text(
                          'KIRIM',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          ClipPath(
            clipper: _PhoneForgotClipper(),
            child: Container(
              height: 220,
              color: _headerBackground,
            ),
          ),
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  _buildBrandedLogo(),
                  const SizedBox(height: 8),
                  const Text(
                    'LUPA KATA SANDI',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: _primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

class _PhoneForgotClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
