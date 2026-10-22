import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/app_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedSport;
  bool _isLoading = false;

  final List<String> _sports = [
    'Football',
    'Cricket',
    'Basketball',
    'Athletics',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerAthlete() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final ageText = _ageController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (_selectedSport == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a sport')));
      return;
    }

    if (ageText.isNotEmpty) {
      final age = int.tryParse(ageText);
      if (age == null || age < 1 || age > 120) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid age')),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.registerAthlete(
      name: name,
      email: email,
      sport: _selectedSport!,
      location: _locationController.text.trim(),
      age: ageText.isEmpty ? null : int.parse(ageText),
    );

final athlete = response['athlete'] as Map<String, dynamic>;
final athleteId = athlete['_id'] as String;

debugPrint('Registered athlete ID: $athleteId');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Athlete registered successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registration failed: ${error.toString().replaceFirst('Exception: ', '')}',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
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

                AppTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Age',
                  hint: 'Enter your age (optional)',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                ),
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Location',
                  hint: 'Enter your city',
                  icon: Icons.location_on_outlined,
                  controller: _locationController,
                ),
                const SizedBox(height: 18),

                DropdownButtonFormField<String>(
                  initialValue: _selectedSport,
                  decoration: InputDecoration(
                    labelText: 'Select Sport',
                    prefixIcon: const Icon(Icons.sports),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: _sports
                      .map(
                        (sport) =>
                            DropdownMenuItem(value: sport, child: Text(sport)),
                      )
                      .toList(),
                  onChanged: _isLoading
                      ? null
                      : (value) {
                          setState(() => _selectedSport = value);
                        },
                  validator: (value) =>
                      value == null ? 'Please select a sport' : null,
                ),
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Password',
                  hint: 'Create a password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 25),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerAthlete,
                    child: _isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 15),

                TextButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
