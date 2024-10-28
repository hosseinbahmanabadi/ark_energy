import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/card_widget.dart';
import '../providers/auth_provider.dart';
import '../models/auth_status.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.login(username, password);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE9F5), // Background color from the design
      body: Center(
        child: SizedBox(
          width: 460,
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {

              if (authProvider.status == AuthStatus.authenticated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/home');
                  authProvider.clearLoginAttempt(); // Reset login attempt on successful login
                });
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Image.asset('assets/logo.png', height: 260), // Logo image
                    const SizedBox(height: 24),
                    CardWidget(
                      child: const Text(
                        'Ark Energy',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Username Field
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => _login(context),
                        child: (authProvider.status == AuthStatus.authenticating)
                            ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1,))
                            : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (authProvider.status == AuthStatus.unauthenticated && authProvider.loginAttempted) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Login failed. Please try again.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
