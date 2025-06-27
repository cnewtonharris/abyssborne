import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'combat_screen.dart';
import 'enemy_data.dart';

class EncounterScreen extends StatelessWidget {
  final String areaName;

  EncounterScreen({required this.areaName, super.key});

  final List<Map<String, String>> possibleEvents = [
    {
      'type': 'enemy',
      'title': 'Ambushed!',
      'description': 'A shadowy figure steps from the mist — prepare for battle!',
    },
    {
      'type': 'loot',
      'title': 'Hidden Cache',
      'description': 'You find a hidden stash of gold and supplies.',
    },
    {
      'type': 'story',
      'title': 'Echoes of the Past',
      'description': 'You feel a presence... a forgotten tale whispers on the wind.',
    },
    {
      'type': 'trap',
      'title': 'Booby Trap!',
      'description': 'A tripwire snaps — a dart flies toward you!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final event = _generateRandomEvent();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          areaName,
          style: GoogleFonts.cinzel(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['title']!,
              style: GoogleFonts.cinzel(
                color: Colors.deepPurpleAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event['description']!,
              style: GoogleFonts.cinzel(color: Colors.white70, fontSize: 16),
            ),
            const Spacer(),
            if (event['type'] == 'enemy')
              _buildActionButton(
                context,
                label: 'Fight!',
                  onTap: () async {
                    Navigator.pop(context); // Close the event dialog

                    // Delay just long enough for pop to finish
                    await Future.delayed(const Duration(milliseconds: 100));

                    final result = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CombatScreen(
                          playerName: 'TestHero',
                          playerHealth: 100,
                          playerMana: 50,
                          playerAttack: 0,
                          playerDefense: 0,
                          playerLevel: 0,
                          playerExp: 0,
                          playerGold: 0,
                          enemyData: randomEnemy,
                        ),
                      ),
                    );

                    // Delay again before showing SnackBar using outer context
                    await Future.delayed(const Duration(milliseconds: 100));

                    if (context.mounted) {
                      final messenger = ScaffoldMessenger.of(context);
                      if (result == 'victory') {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('You won the battle!')),
                        );
                      } else if (result == 'defeat') {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('You were defeated...')),
                        );
                      }
                    }
                  }


              )
            else if (event['type'] == 'loot')
              _buildActionButton(
                context,
                label: 'Take the loot',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Loot added to inventory!')),
                  );
                },
              )
            else if (event['type'] == 'trap')
                _buildActionButton(
                  context,
                  label: 'Try to dodge it',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You dodged... mostly.')),
                    );
                  },
                )
              else if (event['type'] == 'story')
                  _buildActionButton(
                    context,
                    label: 'Contemplate the vision',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('A memory resurfaces.')),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _generateRandomEvent() {
    final rng = Random();
    return possibleEvents[rng.nextInt(possibleEvents.length)];
  }

  Widget _buildActionButton(BuildContext context, {required String label, required VoidCallback onTap}) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          label,
          style: GoogleFonts.cinzel(color: Colors.white),
        ),
      ),
    );
  }
}
