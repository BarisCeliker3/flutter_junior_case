import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF18181B),
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        backgroundColor: const Color(0xFF18181B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/login.json',
                    width: 280,
                    repeat: true,
                  ),
                  const SizedBox(height: 24),
                  _CustomInputField(
                    label: 'E-Posta',
                    hint: 'E-Posta',
                    icon: Icons.mail_outline,
                    onChanged: (val) => email = val,
                    validator: (val) => val!.isEmpty ? 'Email giriniz' : null,
                  ),
                  const SizedBox(height: 16),
                  _CustomInputField(
                    label: 'Şifre',
                    hint: 'Şifre',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    onChanged: (val) => password = val,
                    validator: (val) => val!.isEmpty ? 'Şifre giriniz' : null,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white38,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  if (authProvider.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(authProvider.error!, style: const TextStyle(color: Colors.red)),
                    ),
                  _RedButton(
                    text: 'Giriş Yap',
                    loading: authProvider.isLoading,
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await authProvider.login(email, password);
                              if (success && mounted) {
                                Navigator.of(context).pushReplacementNamed('/main');
                              }
                            }
                          },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/register');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    child: const Text('Hesabınız yok mu? Kayıt Ol'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final IconData? icon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffix;

  const _CustomInputField({
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.white54, size: 22)
            : null,
        suffixIcon: suffix,
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 16, fontWeight: FontWeight.w400),
        labelStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w500, fontSize: 16),
        filled: true,
        fillColor: const Color(0xFF232326),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _RedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const _RedButton({required this.text, this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFE50914),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          elevation: 0,
        ),
        child: loading
            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text(text),
      ),
    );
  }
}