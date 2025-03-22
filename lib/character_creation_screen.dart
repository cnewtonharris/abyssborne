import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_menu.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() => _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  String selectedClass = 'Knight';

  final List<Map<String, String>> classes = [
    {
      'name': 'Knight',
      'description': 'A strong warrior with high defense.',
    },
    {
      'name': 'Mage',
      'description': 'A master of arcane spells and ranged attacks.',
    },
    {
      'name': 'Rogue',
      'description': 'A stealthy assassin with swift strikes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Choose Your Class', style: GoogleFonts.cinzel(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...classes.map((cls) {
              bool isSelected = selectedClass == cls['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedClass = cls['name']!;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepPurple.shade900 : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.deepPurpleAccent : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cls['name']!,
                        style: GoogleFonts.cinzel(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cls['description']!,
                        style: GoogleFonts.cinzel(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Later: Pass this to game screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameScreen(playerClass: selectedClass),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: Text(
                'Continue as $selectedClass',
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
