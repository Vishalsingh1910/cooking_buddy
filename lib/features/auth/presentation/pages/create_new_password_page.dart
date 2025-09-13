import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/status_bar_utils.dart';
import '../widgets/auth_card.dart';
import 'password_reset_complete_page.dart';

class CreateNewPasswordPage extends ConsumerStatefulWidget {
  final String? resetToken;

  const CreateNewPasswordPage({
    super.key,
    this.resetToken,
  });

  @override
  ConsumerState<CreateNewPasswordPage> createState() =>
      _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends ConsumerState<CreateNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate password reset
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PasswordResetCompletePage(),
          ),
        );
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Set light status bar for auth pages
    StatusBarUtils.setLightStatusBar();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create New Password',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  size: 40,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 40),
              // Auth Card
              AuthCard(
                title: "Create New Password",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your new password must be different from your previous password and meet our security requirements.",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // New Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: "New Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 16),
                          // Confirm Password Field
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              hintText: "Confirm New Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _toggleConfirmPasswordVisibility,
                              ),
                            ),
                            validator: _validateConfirmPassword,
                          ),
                          const SizedBox(height: 16),
                          // Password Requirements
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Password must contain:",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildRequirement("At least 8 characters"),
                                _buildRequirement("One uppercase letter"),
                                _buildRequirement("One lowercase letter"),
                                _buildRequirement("One number"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Reset Password Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _resetPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      "Reset Password",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
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

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.textLight,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
