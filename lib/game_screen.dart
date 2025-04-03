import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'area_selection_screen.dart';

class GameScreen extends StatefulWidget {
  final String playerClass;
  final String playerName;

  const GameScreen({
    required this.playerClass,
    required this.playerName,
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentHealth = 0;
  int currentMana = 0;

  int maxHealth = 0;
  int maxMana = 0;

  Map<String, Map<String, int>> classStats = {
    'Knight': {'health': 120, 'mana': 30},
    'Mage': {'health': 70, 'mana': 120},
    'Rogue': {'health': 80, 'mana': 40},
  };

  @override
  void initState() {
    super.initState();

    final stats = classStats[widget.playerClass]!;
    maxHealth = stats['health']!;
    maxMana = stats['mana']!;
    currentHealth = maxHealth;
    currentMana = maxMana;
  }

  void takeDamage(int amount) {
    setState(() {
      currentHealth = (currentHealth - amount).clamp(0, maxHealth);
    });
  }

  void heal(int amount) {
    setState(() {
      currentHealth = (currentHealth + amount).clamp(0, maxHealth);
    });
  }

  void useMana(int amount) {
    setState(() {
      currentMana = (currentMana - amount).clamp(0, maxMana);
    });
  }

  void restoreMana(int amount) {
    setState(() {
      currentMana = (currentMana + amount).clamp(0, maxMana);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      widget.playerName,
                      style: GoogleFonts.cinzel(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.playerClass,
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
            _buildStatBar(label: 'Health', value: currentHealth, max: maxHealth, color: Colors.redAccent),
            const SizedBox(height: 10),
            _buildStatBar(label: 'Mana', value: currentMana, max: maxMana, color: Colors.blueAccent),

            const Spacer(),

            // Action Buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(onPressed: () => takeDamage(10), child: const Text('Take Damage')),
                ElevatedButton(onPressed: () => heal(10), child: const Text('Heal')),
                ElevatedButton(onPressed: () => useMana(10), child: const Text('Use Mana')),
                ElevatedButton(onPressed: () => restoreMana(10), child: const Text('Restore Mana')),
              ],
            ),
            const SizedBox(height: 20),

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
