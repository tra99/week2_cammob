// login_screen.dart
import 'package:flutter/material.dart';
import 'package:test_week2/pages/home_screen.dart';
import 'package:test_week2/pages/register_screen.dart';
import '../components/text_field_component.dart';
import '../services/login.dart';
import '../validations/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  Future<void> _login() async {
    final phone = _phoneNumberController.text;
    final password = _passwordController.text;

    bool isSuccess = await login(phone, password);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successfully')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/png/logo_cm.png"),
                const Text(
                  "ចូលប្រើកម្មវីធី",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 50,),
                Form(
                  key: formKeyLogin,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _phoneNumberController,
                        labelText: "លេខទូរស័ព្ទផ្ទាល់ខ្លួន",
                        keyboardType: TextInputType.phone,
                        validator: validatePhoneNumber,
                      ),
                      const SizedBox(height: 20,),
                      CustomTextField(
                        labelText: 'លេខសំងាត់',
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'សូមបញ្ជូលលេខសម្ងាត់';
                          }
                          return null;
                        },
                        isPasswordField: true,
                      ),
                      const SizedBox(height: 50,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKeyLogin.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: const Text(
                            "បន្ទាប់",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      const Text("ភ្លេចលេខសំងាត់", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 18),),
                      const SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("មិនទាន់មានគណនី?", style: TextStyle(fontSize: 18),),
                          const SizedBox(width: 6,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                            },
                            child: const Text("ចុះឈ្មោះ", style: TextStyle(color: Colors.green, fontSize: 18),),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
