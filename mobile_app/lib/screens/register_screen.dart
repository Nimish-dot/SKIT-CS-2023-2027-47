import 'package:flutter/material.dart';

import '../widgets/app_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Athlete Registration',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                'Create your SportsAI athlete profile',
                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(height: 30),

              const AppTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'Email',
                hint: 'Enter your email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'Age',
                hint: 'Enter your age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'Location',
                hint: 'Enter your city',
                icon: Icons.location_on_outlined,
              ),

              const SizedBox(height: 18),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Sport',
                  prefixIcon: const Icon(Icons.sports),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Football', child: Text('Football')),
                  DropdownMenuItem(value: 'Cricket', child: Text('Cricket')),
                  DropdownMenuItem(
                    value: 'Basketball',
                    child: Text('Basketball'),
                  ),
                  DropdownMenuItem(
                    value: 'Athletics',
                    child: Text('Athletics'),
                  ),
                ],
                onChanged: (value) {},
              ),

              const SizedBox(height: 18),

              const AppTextField(
                label: 'Password',
                hint: 'Create a password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
