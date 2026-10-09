import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _primaryThemeColor = Color(0xFF1A6556);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 35),
            Expanded(child: _buildMenuList(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background top band
          Container(
            width: double.infinity,
            height: 96,
            color: _primaryThemeColor,
          ),

          // User Avatar
          Positioned(
            top: 36,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/images/profile.jpg'),
                ),
              ),
            ),
          ),

          // Display Name
          const Positioned(
            top: 162,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'KAYI NYAP NYAP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Email Pill
          Positioned(
            top: 196,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _primaryThemeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'kayimail@gmail.com',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final menuItems = [
      _ProfileItemData(
        icon: Icons.settings_outlined,
        title: 'Pengaturan',
        onTap: () {},
      ),
      _ProfileItemData(
        icon: Icons.edit_outlined,
        title: 'Edit Profil',
        onTap: () {},
      ),
      _ProfileItemData(
        icon: Icons.lock_outline,
        title: 'Kebijakan Privasi',
        onTap: () {},
      ),
      _ProfileItemData(
        icon: Icons.info_outline,
        title: 'Tentang Kami',
        onTap: () {},
      ),
      _ProfileItemData(
        icon: Icons.description_outlined,
        title: 'Ketentuan Layanan',
        onTap: () {},
      ),
      _ProfileItemData(
        icon: Icons.logout,
        title: 'Keluar',
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        },
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) =>
          Divider(height: 1, thickness: 0.8, color: Colors.grey.shade200),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          leading: Icon(item.icon, size: 26, color: Colors.black87),
          title: Text(
            item.title,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 24,
            color: Colors.black54,
          ),
          onTap: item.onTap,
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Base bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              color: _primaryThemeColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.home_outlined, color: Colors.white, size: 24),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 55), // Offset for floating account action
                ],
              ),
            ),
          ),

          // Floating Account Indicator
          Positioned(
            right: 22,
            bottom: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: _primaryThemeColor, width: 8),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: _primaryThemeColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'AKUN',
                  style: TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
