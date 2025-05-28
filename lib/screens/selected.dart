import 'package:flutter/material.dart';
import 'package:trace_game/screens/play_and_build.dart';

class SelectedRowScreen extends StatelessWidget {
  final List<String> characters;
  final Language language;

  const SelectedRowScreen({
    Key? key,
    required this.characters,
    required this.language,
  }) : super(key: key);

  String get languageName {
    switch (language) {
      case Language.hiragana:
        return "Hiragana";
      case Language.katakana:
        return "Katakana";
      case Language.english:
        return "English";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trace the word"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languageName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle switch logic if needed
                      },
                      child: Text("Switch to Katakana ア"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle grid logic if needed
                      },
                      child: Row(
                        children: [
                          Text("See the Grids"),
                          Icon(Icons.grid_on),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Character tiles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: characters
                  .asMap()
                  .entries
                  .map(
                    (entry) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: entry.key == 0
                          ? Colors.deepPurple
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Text(
                        entry.value,
                        style: TextStyle(fontSize: 26),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ['a', 'i', 'u', 'e', 'o'][entry.key],
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Check button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: const Text(
                "Check",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
