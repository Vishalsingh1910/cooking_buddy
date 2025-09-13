import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/status_bar_utils.dart';
import '../widgets/auth_card.dart';
import '../widgets/social_login_button.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import '../../../navigation/presentation/pages/main_navigation.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      }
    }
  }

  void _navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set light status bar for auth pages
    StatusBarUtils.setLightStatusBar();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Auth Card
              AuthCard(
                title: "Welcome Back",
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Forgot Password
                      TextButton(
                        onPressed: _navigateToForgotPassword,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.textLight.withValues(alpha: 0.3),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "or continue with",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.textLight.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Social Login Buttons
              SocialLoginButton(
                icon: Icons.g_mobiledata,
                text: "Continue with Google",
                backgroundColor: Colors.white,
                textColor: AppColors.textPrimary,
                onPressed: () {
                  // TODO: Implement Google login
                },
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                icon: Icons.facebook,
                text: "Continue with Facebook",
                backgroundColor: const Color(0xFF1877F2),
                textColor: Colors.white,
                onPressed: () {
                  // TODO: Implement Facebook login
                },
              ),
              const SizedBox(height: 32),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: _navigateToSignup,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
