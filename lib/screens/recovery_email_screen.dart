import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForpassEmailScreen extends StatefulWidget {
  const ForpassEmailScreen({super.key});

  @override
  State<ForpassEmailScreen> createState() => _ForpassEmailScreenState();
}

class _ForpassEmailScreenState extends State<ForpassEmailScreen> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final TextEditingController _emailInputController = TextEditingController();

  static const Color _brandColor = Color(0xFF1A6556);
  static const Color _headerBgColor = Color(0xFFDCE9E8);

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }

  void _submitEmailRecovery() {
    if (_emailFormKey.currentState?.validate() ?? false) {
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
              _buildTopHeaderSection(),
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
                            'Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi',
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

                    // Email input field
                    Form(
                      key: _emailFormKey,
                      child: TextFormField(
                        controller: _emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Alamat Email',
                          hintText: 'nama@domain.com',
                          prefixIcon: const Icon(Icons.mail_outline),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Switch to Phone recovery
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/forpassNoHp');
                        },
                        child: const Text(
                          'Gunakan No Hp',
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
                          backgroundColor: _brandColor,
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: _submitEmailRecovery,
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

  Widget _buildTopHeaderSection() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          ClipPath(
            clipper: _EmailForgotClipper(),
            child: Container(
              height: 220,
              color: _headerBgColor,
            ),
          ),
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  _buildBrandLogo(),
                  const SizedBox(height: 8),
                  const Text(
                    'LUPA KATA SANDI',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      color: _brandColor,
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

  Widget _buildBrandLogo() {
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
            color: _brandColor,
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
            color: _brandColor,
          ),
        ),
      ],
    );
  }
}

class _EmailForgotClipper extends CustomClipper<Path> {
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
