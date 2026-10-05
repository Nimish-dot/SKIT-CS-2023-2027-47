import 'package:flutter/material.dart';

import '../models/athlete.dart';
import '../widgets/feature_card.dart';
import '../widgets/sport_card.dart';
import 'profile_screen.dart';
import 'video_upload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final Athlete _demoAthlete = const Athlete(
    name: 'Arjun Sharma',
    sport: 'Cricket',
    location: 'Jaipur, Rajasthan',
    performanceScore: 0,
    assessmentsCompleted: 0,
  );

  void _openAssessment(String sport) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VideoUploadScreen(sport: sport)),
    );
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(athlete: _demoAthlete)),
      );

      setState(() {
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_soccer, color: Color(0xFF1565C0), size: 30),
            SizedBox(width: 8),
            Text(
              'SportsAI',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Your\nSports Potential',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'AI-powered sports talent assessment designed to help athletes track and improve their performance.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Choose Your Sport',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Select a sport to begin your assessment.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
                children: [
                  SportCard(
                    title: 'Cricket',
                    icon: Icons.sports_cricket,
                    onTap: () => _openAssessment('Cricket'),
                  ),
                  SportCard(
                    title: 'Football',
                    icon: Icons.sports_soccer,
                    onTap: () => _openAssessment('Football'),
                  ),
                  SportCard(
                    title: 'Basketball',
                    icon: Icons.sports_basketball,
                    onTap: () => _openAssessment('Basketball'),
                  ),
                  SportCard(
                    title: 'Badminton',
                    icon: Icons.sports_tennis,
                    onTap: () => _openAssessment('Badminton'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          color: Color(0xFF1565C0),
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'AI Performance Assessment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Assess sports performance using AI-based video analysis and performance metrics.',
                      style: TextStyle(color: Colors.grey, height: 1.4),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _openAssessment('Cricket'),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Assessment'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'SportsAI Features',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              const FeatureCard(
                icon: Icons.video_camera_back_outlined,
                title: 'Video-Based Assessment',
                description:
                    'Submit sports performance videos for AI-based analysis.',
              ),
              const FeatureCard(
                icon: Icons.auto_graph_outlined,
                title: 'Performance Tracking',
                description:
                    'Track performance metrics and assessment progress.',
              ),
              const FeatureCard(
                icon: Icons.leaderboard_outlined,
                title: 'Athlete Comparison',
                description:
                    'View performance information and compare athlete results.',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _changeTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            selectedIcon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
