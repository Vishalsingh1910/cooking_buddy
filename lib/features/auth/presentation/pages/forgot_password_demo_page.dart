import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import 'forgot_password_page.dart';
import 'reset_password_success_page.dart';
import 'create_new_password_page.dart';
import 'password_reset_complete_page.dart';

class ForgotPasswordDemoPage extends ConsumerWidget {
  const ForgotPasswordDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Forgot Password Flow Demo'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Forgot Password Flow Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Test all screens in the password reset flow',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildDemoButton(
                context,
                'Step 1: Forgot Password',
                'Enter email to request reset',
                Icons.email_outlined,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Step 2: Check Email',
                'Confirmation that email was sent',
                Icons.mark_email_read_outlined,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordSuccessPage(
                      email: 'demo@example.com',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Step 3: Create New Password',
                'Set a new secure password',
                Icons.lock_outline,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewPasswordPage(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Step 4: Reset Complete',
                'Success confirmation screen',
                Icons.check_circle,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordResetCompletePage(),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.secondary,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This demo shows the complete forgot password flow. In production, these screens would be connected through email links and backend validation.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textLight,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
