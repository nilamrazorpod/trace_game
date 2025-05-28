import 'package:flutter/material.dart';
import 'package:trace_game/screens/selected.dart';
import 'package:trace_game/screens/trace_game_screen.dart';

enum Language { hiragana, katakana, english }

Language selectedLanguage = Language.hiragana;
int? selectedRow;

class PlayAndBuildScreen extends StatefulWidget {
  @override
  _PlayAndBuildScreenState createState() => _PlayAndBuildScreenState();
}

class _PlayAndBuildScreenState extends State<PlayAndBuildScreen> {
  int? selectedTab;
  int? selectedRow;

  // Grid data
  final List<String> headers = ['a', 'i', 'u', 'e', 'o'];
  final List<String> rowLabels = [' ', 'k', 's', 't', 'n', 'h'];
  final List<List<String>> hiraganaRows = [
    ['あ', 'い', 'う', 'え', 'お'],
    ['か', 'き', 'く', 'け', 'こ'],
    ['さ', 'し', 'す', 'せ', 'そ'],
    ['た', 'ち', 'つ', 'て', 'と'],
    ['な', 'に', 'ぬ', 'ね', 'の'],
    ['は', 'ひ', 'ふ', 'へ', 'ほ'],
  ];

  final List<List<String>> hiraganaChar = [
    ['あ', 'い', 'う', 'え', 'お'],
    ['か', 'き', 'く', 'け', 'こ'],
    ['さ', 'し', 'す', 'せ', 'そ'],
    ['た', 'ち', 'つ', 'て', 'と'],
    ['な', 'に', 'ぬ', 'ね', 'の'],
    ['は', 'ひ', 'ふ', 'へ', 'ほ'],
  ];

  final List<List<String>> katakanaChar = [
    ['ア', 'イ', 'ウ', 'エ', 'オ'],
    ['カ', 'キ', 'ク', 'ケ', 'コ'],
    ['サ', 'シ', 'ス', 'セ', 'ソ'],
    ['タ', 'チ', 'ツ', 'テ', 'ト'],
    ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
    ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ'],
  ];

  final List<List<String>> englishChar = [
    ['a', 'i', 'u', 'e', 'o'],
    ['ka', 'ki', 'ku', 'ke', 'ko'],
    ['sa', 'shi', 'su', 'se', 'so'],
    ['ta', 'chi', 'tsu', 'te', 'to'],
    ['na', 'ni', 'nu', 'ne', 'no'],
    ['ha', 'hi', 'fu', 'he', 'ho'],
  ];

  List<List<String>> get currentCharSet {
    switch (selectedLanguage) {
      case Language.hiragana:
        return hiraganaChar;
      case Language.katakana:
        return katakanaChar;
      case Language.english:
        return englishChar;
    }
  }

  // void handleSubmit() {
  //   if (selectedTab == 0) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => TraceGameScreen(
  //         script: selectedLanguage, // pass the selected language/script
  //         characterRowIndex: selectedRow!, // pass selected row index
  //       )),
  //     );
  //   } else {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => BuildResultScreen()),
  //     );
  //   }
  // }

  void handleSubmit() {
    if (selectedTab == 0 && selectedRow != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TraceGameScreen(
            characters: currentCharSet[selectedRow!],
            language: selectedLanguage,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BuildResultScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF9C6EF6),
        title: Text('Play and Build', style: TextStyle(color: Colors.white)),
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        actions: [
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF9C6EF6),
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatIcon(
                  icon: Icons.local_fire_department,
                  value: '4',
                  color: Color(0xFFFF7A00), // orange/red for fire
                ),
                _StatIcon(
                  icon: Icons.star,
                  value: '230',
                  color: Color(0xFFFFD600), // yellow for star
                ),
                _StatIcon(
                  icon: Icons.diamond,
                  value: '25',
                  color: Color(0xFF00B6FF), // blue for diamond
                ),
                _StatIcon(
                  icon: Icons.energy_savings_leaf,
                  value: '1',
                  color: Color(0xFF00C48C), // green for leaf
                ),
              ],
            ),

          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 220),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Cycle through languages
                          if (selectedLanguage == Language.hiragana) {
                            selectedLanguage = Language.katakana;
                          } else if (selectedLanguage == Language.katakana) {
                            selectedLanguage = Language.english;
                          } else {
                            selectedLanguage = Language.hiragana;
                          }
                          selectedRow = null; // reset selection on language change
                        });
                      },
                      child: Center(
                        child: Text(
                          selectedLanguage == Language.hiragana
                              ? "Switch to Katakana"
                              : selectedLanguage == Language.katakana
                              ? "Switch to English"
                              : "Switch to Hiragana",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 8),
                // Trace Tab
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                      selectedRow = null; // Optionally reset row selection when switching tabs

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? Color(0xFFD6C6F6)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFD6C6F6),
                        width: selectedTab == 0 ? 0 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '🖊️ Trace the Characters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedTab == 0
                              ? Color(0xFF6C3EC1)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Build Tab
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                      selectedRow = null; // Optionally reset row selection when switching tabs

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: selectedTab == 1
                          ? Color(0xFFD6C6F6)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFD6C6F6),
                        width: selectedTab == 1 ? 0 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '🧩 Build the Characters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedTab == 1
                              ? Color(0xFF6C3EC1)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (selectedTab != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Select the row you want', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: currentCharSet.length,
                    itemBuilder: (context, rowIdx) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRow = rowIdx;
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Center(
                                child: Text(
                                  rowLabels[rowIdx],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ...List.generate(currentCharSet[rowIdx].length, (colIdx) {
                              bool isSelected = selectedRow == rowIdx;
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.green[200] : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Center(
                                    child: Text(
                                      currentCharSet[rowIdx][colIdx],
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Submit Button at the bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: (selectedRow != null) ? handleSubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9C6EF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class _StatIcon extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color; // <-- Add this

  const _StatIcon({
    required this.icon,
    required this.value,
    required this.color, // <-- Add this
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20), // <-- Use the color here
        SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Dummy Trace Result Screen
class TraceResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trace Result")),
      body: Center(
        child: Text("You navigated to the Trace Result screen!", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// Dummy Build Result Screen
class BuildResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Build Result")),
      body: Center(
        child: Text("You navigated to the Build Result screen!", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
