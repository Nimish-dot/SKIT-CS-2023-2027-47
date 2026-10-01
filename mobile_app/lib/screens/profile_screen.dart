import 'package:flutter/material.dart';

import '../models/athlete.dart';

class ProfileScreen extends StatelessWidget {
  final Athlete athlete;

  const ProfileScreen({
    super.key,
    required this.athlete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Athlete Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFE3F2FD),
              child: Icon(
                Icons.person,
                size: 55,
                color: Color(0xFF1565C0),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              athlete.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              athlete.sport,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            _InfoCard(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: athlete.location,
            ),
            _InfoCard(
              icon: Icons.sports,
              title: 'Primary Sport',
              value: athlete.sport,
            ),
            _InfoCard(
              icon: Icons.analytics_outlined,
              title: 'Performance Score',
              value: athlete.performanceScore.toStringAsFixed(1),
            ),
            _InfoCard(
              icon: Icons.video_library_outlined,
              title: 'Assessments Completed',
              value: athlete.assessmentsCompleted.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF1565C0),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}