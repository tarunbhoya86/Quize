// lib/screens/leaderboard_screen.dart

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/user_model.dart';
import '../services/leaderboard_service.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    Future.delayed(1200.ms, () {
      if (mounted) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showFullLeaderboard(BuildContext context, List<LeaderboardEntry> entries, MockUser? currentUser) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: AppStyles.surfaceColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: AppStyles.primaryColor.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 6,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final isCurrentUser = entry.name == currentUser?.displayName;
                      return ListTile(
                        leading: Text(
                          '#${index + 1}',
                          style: AppStyles.heading.copyWith(fontSize: 16, color: isCurrentUser ? AppStyles.secondaryColor : AppStyles.primaryColor),
                        ),
                        title: Text(entry.name, style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        trailing: Text('${entry.score} pts', style: AppStyles.body.copyWith(color: Colors.white)),
                        tileColor: isCurrentUser ? AppStyles.secondaryColor.withOpacity(0.1) : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<MockAuthService>().currentUser;
    final leaderboardService = context.watch<LeaderboardService>();
    final entries = leaderboardService.entries;

    if (entries.isEmpty) {
      return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          title: Text('Leaderboard', style: AppStyles.title.copyWith(fontSize: 22)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(child: Text('Play a quiz to get ranked!', style: AppStyles.body)),
      );
    }

    final topThree = entries.take(3).toList();

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Leaderboard', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: AppStyles.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, 0.5),
                      radius: 1.0,
                      colors: [AppStyles.primaryColor.withOpacity(0.3), AppStyles.backgroundColor],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    numberOfParticles: 20,
                    colors: const [AppStyles.primaryColor, Colors.amber, Colors.white],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (topThree.length > 1)
                      _PodiumPlace(entry: topThree[1], rank: 2)
                          .animate().slideY(begin: 3, duration: 800.ms, delay: 200.ms, curve: Curves.easeOutCubic).fadeIn(),
                    if (topThree.isNotEmpty)
                      _PodiumPlace(entry: topThree[0], rank: 1)
                          .animate().slideY(begin: 3, duration: 1000.ms, curve: Curves.easeOutCubic).fadeIn(),
                    if (topThree.length > 2)
                      _PodiumPlace(entry: topThree[2], rank: 3)
                          .animate().slideY(begin: 3, duration: 800.ms, delay: 400.ms, curve: Curves.easeOutCubic).fadeIn(),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showFullLeaderboard(context, entries, currentUser),
                icon: const Icon(Icons.list_alt_rounded),
                label: const Text('View Full Leaderboard'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppStyles.surfaceColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumPlace extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  const _PodiumPlace({required this.entry, required this.rank});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.amber.shade600, Colors.grey.shade400, const Color(0xFFCD7F32)];
    final heights = [200.0, 150.0, 120.0];
    final icon = Icons.emoji_events;
    final color = colors[rank - 1];
    final height = heights[rank - 1];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (rank == 1)
          Icon(icon, color: color, size: 40, shadows: [AppStyles.neonGlow(color)]),
        const SizedBox(height: 8),
        // **THE CHANGE: Replaced user initial with a generic icon**
        CircleAvatar(
          radius: 40,
          backgroundColor: color,
          child: CircleAvatar(
            radius: 37,
            backgroundColor: AppStyles.surfaceColor,
            child: Icon(Icons.person, size: 40, color: color), // Simplified display
          ),
        ),
        const SizedBox(height: 8),
        Text(entry.name, style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        Text('${entry.score} pts', style: AppStyles.body.copyWith(color: color)),
        const SizedBox(height: 12),
        Container(
          width: 110,
          height: height,
          decoration: BoxDecoration(
            color: AppStyles.surfaceColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: color, width: 2),
            boxShadow: [AppStyles.neonGlow(color)],
          ),
          child: Center(
            child: Text(
              '$rank',
              style: AppStyles.score.copyWith(fontSize: 80, color: color.withOpacity(0.8)),
            ),
          ),
        ),
      ],
    );
  }
}