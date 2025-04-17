import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuquest/screens/home.dart';
import 'package:tuquest/screens/login.dart';
import 'reset_password.dart';
import 'package:tuquest/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuquest/material/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _userCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _confirmCtl = TextEditingController();
  bool _isLoading = false, _showPassword = false;
  String? _errorMessage;

  bool get _isFormValid =>
      _nameCtl.text.trim().isNotEmpty &&
      _userCtl.text.trim().isNotEmpty &&
      Validator.email(_emailCtl.text) == null &&
      Validator.password(_passCtl.text) == null &&
      _passCtl.text == _confirmCtl.text;

  Future<void> _createAccount() async {
    if (!_isFormValid) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailCtl.text.trim(),
            password: _passCtl.text.trim(),
          );
      await cred.user?.updateDisplayName(_nameCtl.text.trim());
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (_) {
      setState(() => _errorMessage = 'Unexpected error occurred.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildUnderlineField({
    required String hint,
    required TextEditingController ctl,
    required String? Function(String?) validator,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: ctl,
      validator: validator,
      obscureText: obscure && !_showPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFF8000)),
        ),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      style: const TextStyle(color: Colors.black),
      onChanged: (_) => setState(() {}),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background 
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFFFF0004)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children:  [
              // TUQuest gradient logo
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFA00000), Color(0xFFEA2520), Color(0xFFFF8000)],
                ).createShader(bounds),
                child: Text(
                  "TUQuest",
                  style: GoogleFonts.montserrat(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildUnderlineField(
                      hint: 'Full Name',
                      ctl: _nameCtl,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildUnderlineField(
                      hint: 'Username',
                      ctl: _userCtl,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildUnderlineField(
                      hint: 'Email',
                      ctl: _emailCtl,
                      validator: Validator.email,
                    ),
                    const SizedBox(height: 16),
                    _buildUnderlineField(
                      hint: 'Password',
                      ctl: _passCtl,
                      validator: Validator.password,
                      obscure: true,
                      suffix: IconButton(
                        icon: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildUnderlineField(
                      hint: 'Confirm Password',
                      ctl: _confirmCtl,
                      validator: (v) => v != _passCtl.text
                          ? 'Passwords do not match'
                          : null,
                      obscure: true,
                    ),
                  ],
                ),
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(_errorMessage!,
                    style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),

              // Create Account button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _isFormValid ? _createAccount : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 32),

              // OR divider
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('OR', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 32),

              // Google sign-up (same style as login)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          try {
                            await TQauth.signInWithGoogle();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Home()),
                            );
                          } catch (_) {}
                          if (mounted) setState(() => _isLoading = false);
                        },
                  icon: Image.asset('assets/google_logo.png', height: 24),
                  label: const Text(
                    'Sign up with Google',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Already have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}