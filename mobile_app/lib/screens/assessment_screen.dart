import 'package:flutter/material.dart';

import '../widgets/assessment_step.dart';

class AssessmentScreen extends StatelessWidget {
  final String sport;

  const AssessmentScreen({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Assessment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Start Your Assessment',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected sport: $sport',
              style: const TextStyle(
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE3F2FD), Color(0xFFF5FAFF)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF1565C0), size: 32),
                  SizedBox(height: 12),
                  Text(
                    'AI-Powered Assessment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your performance video will be analysed to generate objective performance metrics.',
                    style: TextStyle(color: Colors.grey, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Assessment Process',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            const AssessmentStep(
              number: '1',
              title: 'Athlete Profile',
              description: 'Provide your basic athlete information.',
            ),
            const AssessmentStep(
              number: '2',
              title: 'Upload Performance Video',
              description: 'Submit a sports performance video for analysis.',
            ),
            const AssessmentStep(
              number: '3',
              title: 'AI Analysis',
              description: 'The AI module analyses movement and performance characteristics.',
            ),
            const AssessmentStep(
              number: '4',
              title: 'Performance Score',
              description:
                  'View your generated performance metrics and assessment.',
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Video upload will be connected in a later sprint.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.video_library_outlined),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Continue', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
