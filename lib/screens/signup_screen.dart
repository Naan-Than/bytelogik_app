import 'package:bytelogik_app/utils/Utility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {

    if (_formKey.currentState!.validate()) {
      final success = await ref.read(authProvider.notifier).signUp(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please sign in.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 132),
                 Text(
                  Utility.crtAccText,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                 Text(
                 Utility.fillDetailText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Utility.customTextField(
                  Utility.fullNameText,
                  Icons.person,
                  TextInputType.emailAddress,
                  Utility.fullNameText,
                  _usernameController,
                      (name) {
                        if (name == null || name.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (name.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                  },
                ),
                const SizedBox(height: 20),

                Utility.customTextField(
                  Utility.emailAddressText,
                  Icons.mail,
                  TextInputType.emailAddress,
                  Utility.emailAddressText,
                  _emailController,
                      (mail) {
                    if (mail == null || mail.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w\.-]+@([\w-]+\.)+[A-Za-z]{2,4}$',
                    ).hasMatch(mail)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Utility.customTextField(
                  Utility.passwordText,
                  Icons.lock,
                  TextInputType.text,
                  Utility.passwordText,
                  isPassword: _obscurePassword,
                  _passwordController,
                  suffixIcon: IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                      (pass) {
                    if (pass.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Utility.customTextField(
                  Utility.confirmPassText,
                  Icons.lock,
                  TextInputType.text,
                  Utility.passwordText,
                  isPassword: _obscureConfirmPassword,
                  _confirmPasswordController,
                  suffixIcon: IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                      (pass) {
                    if (pass.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (authState.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      authState.error!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                const SizedBox(height: 10),
                Utility.customButton(Utility.signUpText, () {
                  _handleSignUp();
                }, Theme.of(context).primaryColor),
                const SizedBox(height: 18),
                RichText(
                  text: TextSpan(
                    text: "or  ",
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:Utility.urAccText,
                        recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            ref.read(authProvider.notifier).clearError();
                            Navigator.of(context).pop();
                          },
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}