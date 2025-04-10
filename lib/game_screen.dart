import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'area_selection_screen.dart';

class GameScreen extends StatelessWidget {
  final String playerClass;
  final String playerName;

  const GameScreen({
    required this.playerClass,
    required this.playerName,
    super.key,
  });

  final Map<String, Map<String, int>> classStats = const {
    'Knight': {'health': 120, 'mana': 30},
    'Mage': {'health': 70, 'mana': 120},
    'Rogue': {'health': 80, 'mana': 40},
  };

  @override
  Widget build(BuildContext context) {
    final stats = classStats[playerClass]!;
    final int maxHealth = stats['health']!;
    final int maxMana = stats['mana']!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Player Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerName,
                      style: GoogleFonts.cinzel(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      playerClass,
                      style: GoogleFonts.cinzel(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Health and Mana Bars
            _buildStatBar(label: 'Health', value: maxHealth, max: maxHealth, color: Colors.redAccent),
            const SizedBox(height: 10),
            _buildStatBar(label: 'Mana', value: maxMana, max: maxMana, color: Colors.blueAccent),

            const Spacer(),

            // Explore Areas
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AreaSelectionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Explore Areas',
                style: GoogleFonts.cinzel(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar({
    required String label,
    required int value,
    required int max,
    required Color color,
  }) {
    final double percent = value / max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value / $max',
          style: GoogleFonts.cinzel(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: percent),
          duration: const Duration(milliseconds: 300),
          builder: (context, animatedValue, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: animatedValue,
                minHeight: 14,
                backgroundColor: Colors.grey.shade800,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            );
          },
        ),
      ],
    );
  }
}
