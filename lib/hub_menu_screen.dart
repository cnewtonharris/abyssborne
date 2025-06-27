import 'package:flutter/material.dart';
import 'area_selection_screen.dart';
import 'encounter_screen.dart'; // You already have this

class HubMenuScreen extends StatelessWidget {
  final List<_MenuOption> options = [
    _MenuOption('Explore', Icons.map, AreaSelectionScreen()),
    _MenuOption('Fight', Icons.gavel, EncounterScreen(areaName: '_generateRandomEvent',)),
    _MenuOption('Shop', Icons.store, null),
    _MenuOption('Upgrade', Icons.upgrade, null),
    _MenuOption('Inventory', Icons.inventory, null),
    _MenuOption('Settings', Icons.settings, null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Abyssborne: Hub')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: options.map((option) {
            return InkWell(
              onTap: option.screen != null
                  ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => option.screen!),
              )
                  : null,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.grey.shade900,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(option.icon, size: 40, color: Colors.white),
                      SizedBox(height: 10),
                      Text(option.title,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class _MenuOption {
  final String title;
  final IconData icon;
  final Widget? screen;

  _MenuOption(this.title, this.icon, this.screen);
}
