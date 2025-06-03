
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:trace_game/screens/play_and_build.dart';
import '../../utils/enums.dart';

class TraceGameScreen extends StatefulWidget {
  final List<String> characters;
  final Language language;

  const TraceGameScreen({
    Key? key,
    required this.characters,
    required this.language,
  }) : super(key: key);

  @override
  State<TraceGameScreen> createState() => _TraceGameScreenState();
}

class _TraceGameScreenState extends State<TraceGameScreen> {
  Script currentScript = Script.hiragana;
  int selectedIndex = 0;
  Offset penPosition = const Offset(0, 0);
  bool penInitialized = false;
  List<Offset?> tracePoints = [];


  final hiraganaChar = 'あ';
  final katakanaChar = 'ア';
  final englishChar = 'A';

  final hiraganaChoices = ['あ', 'い', 'う', 'え', 'お'];
  final katakanaChoices = ['ア', 'イ', 'ウ', 'エ', 'オ'];
  final englishChoices = ['A', 'I', 'U', 'E', 'O'];

  // Define words by language somewhere centrally
  Map<Language, List<String>> languageWords = {
    Language.hiragana: ['あ', 'い', 'う', 'え', 'お'],
    Language.katakana: ['ア', 'イ', 'ウ', 'エ', 'オ'],
    Language.english: ['A', 'I', 'U', 'E', 'O'],
  };


  void changeLanguage(Language newLang) {
    setState(() {
      selectedLanguage = newLang;
      wordCharacters = languageWords[newLang]!;
      choices = wordCharacters;
      selectedIndex = -1;
      tracePoints.clear();
      fillChar = false;
      penInitialized = false;
      mainChar = choices.isNotEmpty ? choices[0] : '';

      switch (newLang) {
        case Language.hiragana:
          currentScript = Script.hiragana;
          break;
        case Language.katakana:
          currentScript = Script.katakana;
          break;
        case Language.english:
          currentScript = Script.english;
          break;
      }

      romaji = choices.map((c) {
        switch (c) {
          case 'あ':
          case 'ア':
          case 'A':
            return 'a';
          case 'い':
          case 'イ':
          case 'I':
            return 'i';
          case 'う':
          case 'ウ':
          case 'U':
            return 'u';
          case 'え':
          case 'エ':
          case 'E':
            return 'e';
          case 'お':
          case 'オ':
          case 'O':
            return 'o';
          default:
            return '';
        }
      }).toList();
    });
  }



  bool fillChar = false;
  late String mainChar; // The character to draw initially
  late List<String> choices;
  Path getCharPath(Size size) {
    return Path(); // Use actual path if needed
  }

  Rect getStrokeGuideRect(Size size) {
    return Rect.fromLTWH(
      size.width * 0.23,
      size.height * 0.22,
      size.width * 0.54,
      18,
    );
  }

  bool isWithinStrokeGuide(Offset localPosition, Size size) {
    final guide = getStrokeGuideRect(size);
    return guide.contains(localPosition);
  }

  void resetPen(Size areaSize) {
    final guide = getStrokeGuideRect(areaSize);
    setState(() {
      penPosition = Offset(areaSize.width * 0.5, guide.top + guide.height / 2);
      penInitialized = true;
    });
  }

  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;


  late List<String> wordCharacters;
  late Language selectedLanguage;
  List<String> romaji = [];


  @override
  void initState() {
    super.initState();
    flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
      IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
      IosTextToSpeechAudioCategoryOptions.mixWithOthers,
    ], IosTextToSpeechAudioMode.defaultMode);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    romaji = widget.characters.map((c) {
      // Simple mock: you should replace this with actual romaji data
      switch (c) {
        case 'あ': return 'a';
        case 'い': return 'i';
        case 'う': return 'u';
        case 'え': return 'e';
        case 'お': return 'o';
      // Add others as needed
        default: return '';
      }
    }).toList();

    wordCharacters = widget.characters;
    selectedLanguage = widget.language;
    choices = widget.characters;
    mainChar = choices[0]; // First character as default


  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tracingAreaHeight = size.height * 0.38;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trace the word'),
        leading: const Icon(Icons.arrow_back),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedLanguage == Language.hiragana
                      ? "Switch to Katakana"
                      : selectedLanguage == Language.katakana
                      ? "Switch to English"
                      : "Switch to Hiragana",
                  style: TextStyle(color: Colors.black),
                ),

                // const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedLanguage == Language.hiragana) {
                              changeLanguage(Language.katakana);
                            } else if (selectedLanguage == Language.katakana) {
                              changeLanguage(Language.english);
                            } else {
                              changeLanguage(Language.hiragana);
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                    ),

                    // PopupMenuButton<Script>(
                    //   onSelected: (script) {
                    //     setState(() {
                    //       currentScript = script;
                    //       penInitialized = false;
                    //       tracePoints = [];
                    //       selectedIndex = -1;
                    //       fillChar = false;
                    //     });
                    //   },
                    //   itemBuilder: (context) => [
                    //     const PopupMenuItem(
                    //       value: Script.hiragana,
                    //       child: Text('Hiragana あ'),
                    //     ),
                    //     const PopupMenuItem(
                    //       value: Script.katakana,
                    //       child: Text('Katakana ア'),
                    //     ),
                    //     const PopupMenuItem(
                    //       value: Script.english,
                    //       child: Text('English A'),
                    //     ),
                    //   ],
                    //   child: OutlinedButton(
                    //     onPressed: null,
                    //     style: OutlinedButton.styleFrom(
                    //       foregroundColor: Colors.black,
                    //       side: const BorderSide(color: Colors.grey),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       currentScript == Script.hiragana
                    //           ? 'Switch to Katakana ア'
                    //           : currentScript == Script.katakana
                    //           ? 'Switch to English A'
                    //           : 'Switch to Hiragana あ',
                    //       style: const TextStyle(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        label: const Text('See the Grids'),
                        icon: const Icon(Icons.grid_on, size: 18),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Audio button
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.volume_up),
                  onPressed: (){},
                  color: Colors.black87,
                  iconSize: 32,
                  tooltip: 'Play audio',
                ),
              ),
              // Selected word display
              if (selectedIndex != -1)
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'Selected: ${choices[selectedIndex]} (${romaji[selectedIndex]})',
                    style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10,),
          // Tracing area
          SizedBox(
            height: tracingAreaHeight,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final areaSize =
                Size(constraints.maxWidth, constraints.maxHeight);
                if (!penInitialized) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    resetPen(areaSize);
                  });
                }
                return
                  Stack(
                  children: [
                    CustomPaint(
                      size: areaSize,
                      painter: CharacterPainter(
                        getCharPath(areaSize),
                        getStrokeGuideRect(areaSize),
                        tracePoints,
                        selectedIndex != -1 ? choices[selectedIndex] : mainChar,
                        currentScript,
                        fillChar,
                      ),
                    ),

                    GestureDetector(
                      onPanUpdate: (details) {
                        RenderBox box =
                        context.findRenderObject() as RenderBox;
                        final local =
                        box.globalToLocal(details.globalPosition);
                        setState(() {
                          tracePoints = List.from(tracePoints)..add(local);
                        });
                      },
                      onPanEnd: (_) {
                        setState(() {
                          tracePoints = List.from(tracePoints)..add(null);
                        });
                      },
                      child: Container(
                        width: areaSize.width,
                        height: areaSize.height,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.characters
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = entry.key;
                      tracePoints.clear();
                      fillChar = false;
                      penInitialized = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedIndex == entry.key
                            ? Colors.deepPurple
                            : Colors.grey[300]!,
                        width: selectedIndex == entry.key ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 26,
                            color: selectedIndex == entry.key
                                ? Colors.deepPurple
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          romaji[entry.key],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
          const Spacer(),
          // Check button
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade300,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: selectedIndex == -1
                    ? null
                    : () {
                  bool correct = selectedIndex == 0;
                  if (correct) {
                    setState(() {
                      fillChar = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text('Correct!', style: TextStyle(fontSize: 18)),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text('Try again!', style: TextStyle(fontSize: 18)),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Check', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterPainter extends CustomPainter {
  final Path charPath;
  final Rect strokeGuide;
  final List<Offset?> tracePoints;
  final String mainChar;
  final Script script;
  final bool fillChar;

  CharacterPainter(
      this.charPath,
      this.strokeGuide,
      this.tracePoints,
      this.mainChar,
      this.script,
      this.fillChar,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: mainChar,
        style: TextStyle(
          fontSize: size.height * 1.1,
          color: Colors.grey.withOpacity(0.3),
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
    );

    Paint pathPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.09
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(charPath, pathPaint);

    if (tracePoints.isNotEmpty) {
      Paint tracePaint = Paint()
        ..color = Colors.green
        ..strokeWidth = size.height * 0.09
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < tracePoints.length - 1; i++) {
        if (tracePoints[i] != null && tracePoints[i + 1] != null) {
          canvas.drawLine(tracePoints[i]!, tracePoints[i + 1]!, tracePaint);
        }
      }

      final last = tracePoints.lastWhere((e) => e != null, orElse: () => null);
      if (last != null) {
        canvas.drawCircle(last, size.height * 0.045, Paint()..color = Colors.black.withOpacity(0.3));
        canvas.drawCircle(last, size.height * 0.028, Paint()..color = Colors.white);
        canvas.drawCircle(last, size.height * 0.017, Paint()..color = Colors.black87);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CharacterPainter oldDelegate) =>
      oldDelegate.tracePoints != tracePoints ||
          oldDelegate.mainChar != mainChar ||
          oldDelegate.script != script ||
          oldDelegate.fillChar != fillChar;
}

class DashedArrowPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  DashedArrowPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 5.0;
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final steps = (distance / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < steps; i++) {
      final x1 = start.dx + (dx * i / steps);
      final y1 = start.dy + (dy * i / steps);
      final x2 = start.dx + (dx * (i + 0.5) / steps);
      final y2 = start.dy + (dy * (i + 0.5) / steps);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }

    const arrowSize = 10.0;
    final angle = atan2(dy, dx);
    final arrowP1 = Offset(
      end.dx - arrowSize * cos(angle - 0.4),
      end.dy - arrowSize * sin(angle - 0.4),
    );
    final arrowP2 = Offset(
      end.dx - arrowSize * cos(angle + 0.4),
      end.dy - arrowSize * sin(angle + 0.4),
    );
    canvas.drawLine(end, arrowP1, paint);
    canvas.drawLine(end, arrowP2, paint);
  }

  @override
  bool shouldRepaint(covariant DashedArrowPainter oldDelegate) => false;
}


//auto fill words logic
class AutoFill extends StatelessWidget {
  const AutoFill({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
