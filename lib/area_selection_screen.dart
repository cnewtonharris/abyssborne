import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AreaSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> areas = [
    {
      'name': 'Haunted Forest',
      'description': 'A twisted woodland teeming with restless spirits.'
    },
    {
      'name': 'Ruined Keep',
      'description': 'Collapsed stone halls echo with lost memories.'
    },
    {
      'name': 'Sewer Depths',
      'description': 'Dark, fetid tunnels where things lurk unseen.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Choose Your Destination',
          style: GoogleFonts.cinzel(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.grey.shade900,
                  title: Text(
                    area['name']!,
                    style: GoogleFonts.cinzel(color: Colors.white),
                  ),
                  content: Text(
                    area['description']!,
                    style: GoogleFonts.cinzel(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Later: Navigate to event/exploration screen
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Entering ${area['name']}...'),
                        ));
                      },
                      child: const Text('Enter', style: TextStyle(color: Colors.deepPurpleAccent)),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurpleAccent, width: 1.5),
              ),
              child: Text(
                area['name']!,
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
