import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF18181B),
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
        backgroundColor: const Color(0xFF18181B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInputField(
                    label: 'Kullanıcı Adı',
                    hint: 'Kullanıcı Adı',
                    onChanged: (val) => username = val,
                    validator: (val) => val!.isEmpty ? 'Kullanıcı adı giriniz' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'E-Posta',
                    hint: 'E-Posta',
                    onChanged: (val) => email = val,
                    validator: (val) => val!.isEmpty ? 'Email giriniz' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    label: 'Şifre',
                    hint: 'Şifre',
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
                  RedButton(
                    text: 'Kayıt Ol',
                    loading: authProvider.isLoading,
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await authProvider.register(email, password, username);
                              if (success && mounted) {
                                Navigator.of(context).pushReplacementNamed('/login');
                              }
                            }
                          },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    child: const Text('Hesabınız var mı? Giriş Yap'),
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

// Figma'ya uygun input: geniş, 16px radius, kırmızı border ve koyu arka plan
class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffix;

  const CustomInputField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.suffix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
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
        suffixIcon: suffix,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

// Figma kırmızı button, 16px radius
class RedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const RedButton({required this.text, this.onPressed, this.loading = false, Key? key}) : super(key: key);

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