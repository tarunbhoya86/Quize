// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/leaderboard_service.dart'; // Import LeaderboardService
import '../models/user_model.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';

// Assuming you have a separate screen for this, otherwise the dialog implementation can be used.
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  String? _selectedPhotoUrl;
  bool _isLoading = false;

  final List<String> _avatarOptions = [
    'https://api.dicebear.com/8.x/adventurer/png?seed=Felix',
    'https://api.dicebear.com/8.x/adventurer/png?seed=Sheba',
    'https://api.dicebear.com/8.x/adventurer/png?seed=Rascal',
    'https://api.dicebear.com/8.x/adventurer/png?seed=Pepper',
    'https://api.dicebear.com/8.x/adventurer/png?seed=Milo',
    'https://api.dicebear.com/8.x/adventurer/png?seed=Luna',
  ];

  @override
  void initState() {
    super.initState();
    final currentUser = Provider.of<MockAuthService>(context, listen: false).currentUser;
    _nameController = TextEditingController(text: currentUser?.displayName ?? '');
    _selectedPhotoUrl = currentUser?.photoUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // NEW: A confirmation dialog for resetting the leaderboard
  Future<void> _showResetConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppStyles.surfaceColor,
        title: Text('Are you sure?', style: AppStyles.heading.copyWith(color: Colors.white)),
        content: const Text(
          'This will permanently delete all scores from the leaderboard. This action cannot be undone.',
          style: AppStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Call the reset function from the service
              Provider.of<LeaderboardService>(context, listen: false).resetLeaderboard();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Leaderboard has been reset.')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppStyles.incorrectColor),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAvatarSelectionDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppStyles.surfaceColor,
        title: Text('Choose Your Avatar', style: AppStyles.heading.copyWith(color: Colors.white)),
        content: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _avatarOptions.map((url) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPhotoUrl = url;
                });
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(url),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    final authService = Provider.of<MockAuthService>(context, listen: false);

    await authService.updateUserProfile(
      newDisplayName: _nameController.text.trim(),
      newPhotoUrl: _selectedPhotoUrl,
    );

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.of(context).pop();
    }
  }

  void _navigateToChangePassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<MockAuthService>().currentUser;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Edit Profile', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showAvatarSelectionDialog,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppStyles.primaryColor,
                    child: CircleAvatar(
                      radius: 57,
                      backgroundImage: _selectedPhotoUrl != null ? NetworkImage(_selectedPhotoUrl!) : null,
                      child: _selectedPhotoUrl == null
                          ? Icon(Icons.person, size: 60, color: AppStyles.backgroundColor)
                          : null,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: AppStyles.primaryColor, shape: BoxShape.circle),
                    child: const Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: const Icon(Icons.person_outline, color: AppStyles.primaryColor),
                filled: true,
                fillColor: AppStyles.surfaceColor.withOpacity(0.8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: currentUser?.email ?? ''),
              style: const TextStyle(color: Colors.white54),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: const Icon(Icons.email_outlined, color: AppStyles.primaryColor),
                filled: true,
                fillColor: AppStyles.surfaceColor.withOpacity(0.5),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            _NeonActionButton(
              text: 'CHANGE PASSWORD',
              color: AppStyles.primaryColor,
              onTap: _navigateToChangePassword,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 40),
            _isLoading
                ? const CircularProgressIndicator(color: AppStyles.primaryColor)
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppStyles.primaryColor,
                  foregroundColor: AppStyles.backgroundColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const Divider(color: Colors.white24, height: 60),
            // NEW: Button to reset the leaderboard
            TextButton.icon(
              onPressed: _showResetConfirmationDialog,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Reset Leaderboard'),
              style: TextButton.styleFrom(foregroundColor: AppStyles.incorrectColor.withOpacity(0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeonActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  const _NeonActionButton({
    required this.text,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: AppStyles.neonBorder(color),
          color: AppStyles.surfaceColor.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(text, style: AppStyles.body.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}