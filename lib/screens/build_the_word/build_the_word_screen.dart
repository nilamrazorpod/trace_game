import 'dart:async';

import 'package:flutter/material.dart';

class BuildTheWordScreen extends StatefulWidget {
  const BuildTheWordScreen({super.key});

  @override
  BuildTheWordScreenState createState() => BuildTheWordScreenState();
}

class BuildTheWordScreenState extends State<BuildTheWordScreen> {
  final ScrollController _scrollController = ScrollController();

  Timer? _timer;
  int _remainingSeconds = 120; // 2 minutes countdown
  int selectedIndex = 0;
  String currentScript = 'Hiragana';
  List<String> characters = ['あ', 'い', 'う', 'え', 'お'];
  List<String> romaji = ['a', 'i', 'u', 'e', 'o'];
  List<String> parts = ['し', 'つ', 'しょ', 'か', 'え', 'ー', 'の', 'い', 'ー', 'つ', 'し', 'ー'];
  List<String> droppedParts = [];

  final int itemsPerRow = 6;



  void switchScript() {
    setState(() {
      if (currentScript == 'Hiragana') {
        currentScript = 'Katakana';
        characters = ['ア', 'イ', 'ウ', 'エ', 'オ'];
      } else if (currentScript == 'Katakana') {
        currentScript = 'English';
        characters = ['a', 'i', 'u', 'e', 'o'];
      } else {
        currentScript = 'Hiragana';
        characters = ['あ', 'い', 'う', 'え', 'お'];
      }
      selectedIndex = 0;
      droppedParts.clear();
    });
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _remainingSeconds = 120; // reset to 2 minutes
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        // Timer finished - do something if needed
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  String get timerText {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(1, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Build the word'),
        leading: const Icon(Icons.arrow_back),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("HiraKana"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: OutlinedButton(
                    onPressed: switchScript,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple.shade300, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      'Switch to ${currentScript == 'Hiragana' ? 'Katakana' : currentScript == 'Katakana' ? 'English' : 'Hiragana'}',
                      style: TextStyle(
                        color: Colors.purple.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          // Character Row with Romaji
          Container(
            color: Color(0xFFF3ECF9), // Light purple background
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                // Left arrow icon (disabled style)
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.purple.shade100),
                  onPressed: () {
                    final double offset = _scrollController.offset - 100; // scroll left by 100 pixels
                    _scrollController.animateTo(
                      offset < 0 ? 0 : offset,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(characters.length, (index) {
                        bool isSelected = index == selectedIndex;
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.purple.shade100 : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  characters[index],
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: isSelected ? Colors.purple.shade300 : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  romaji[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.purple.shade300 : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                // Right arrow icon (disabled style)
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.purple.shade100),
                  onPressed: () {
                    final maxScroll = _scrollController.position.maxScrollExtent;
                    final double offset = _scrollController.offset + 100; // scroll right by 100 pixels
                    _scrollController.animateTo(
                      offset > maxScroll ? maxScroll : offset,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),                ],
            ),
          ),
          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Icon(Icons.timer, size: 18, color: Colors.grey.shade700),
                      SizedBox(width: 6),
                      Text(
                        timerText,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drag Target Area (Assembly area)
          Expanded(
            child: DragTarget<String>(
              onAccept: (part) {
                setState(() {
                  droppedParts.add(part);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                   // border: Border.all(color: Colors.grey.shade300, width: 2),
                   // borderRadius: BorderRadius.circular(16),
                   // color: Colors.grey.shade50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    droppedParts.isEmpty ? '' : droppedParts.join(''),
                    style: TextStyle(
                      fontSize: 200,
                      color: Colors.purple.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 24),

          // Parts Grid (Draggable)
      // Assuming parts is a List<String> with 12 items

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: SizedBox(
              height: 140, // Enough height for 2 rows of 56 + spacing
              child: GridView.count(
                crossAxisCount: 6, // 6 items per row
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                physics: NeverScrollableScrollPhysics(), // Disable scrolling inside grid
                children: parts.map((part) {
                  String displayText = part.length > 1 ? part[0] : part;

                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          content: Center(
                            heightFactor: 1,
                            widthFactor: 1,
                            child: Text(
                              part,
                              style: TextStyle(
                                fontSize: 48,
                                color: Colors.purple.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Draggable<String>(
                      data: part,
                      feedback: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                          ),
                          child: Text(
                            part,
                            style: TextStyle(fontSize: 36, color: Colors.purple.shade700),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          displayText,
                          style: TextStyle(fontSize: 36, color: Colors.grey.shade400),
                        ),
                      ),
                      child: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          displayText,
                          style: TextStyle(fontSize: 36, color: Colors.black87),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          SizedBox(height: 24),

          // Check Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8)),
                ),
              ),
              onPressed: () {
                bool correct = droppedParts.join('') == characters[selectedIndex];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(correct ? 'Correct!' : 'Try again!'),
                    backgroundColor: correct ? Colors.green : Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
                if (correct) {
                  setState(() {
                    droppedParts.clear();
                  });
                }
              },
              child: Text(
                'Check',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
