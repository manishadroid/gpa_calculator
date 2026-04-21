import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 87, 154, 185),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final player = AudioPlayer();

  final _mark1 = TextEditingController();
  final _mark2 = TextEditingController();
  final _mark3 = TextEditingController();

  final _ch1 = TextEditingController();
  final _ch2 = TextEditingController();
  final _ch3 = TextEditingController();

  double _getGradePoint(double mark) {
    if (mark >= 80) return 4.00;
    if (mark >= 75) return 3.67;
    if (mark >= 70) return 3.33;
    if (mark >= 65) return 3.00;
    if (mark >= 60) return 2.67;
    if (mark >= 55) return 2.33;
    if (mark >= 50) return 2.00;
    if (mark >= 45) return 1.67;
    if (mark >= 40) return 1.33;
    if (mark >= 35) return 1.00;
    return 0.00;
  }

  String _resultGPA = "0.00"; //GPA result
  String _statusText = "Enter your marks"; //comment

  void _calculateGPA() {
    setState(() {
      double mark1 =
          double.tryParse(_mark1.text) ?? 0; // if null, return 0 (abc or empty)
      double mark2 = double.tryParse(_mark2.text) ?? 0;
      double mark3 = double.tryParse(_mark3.text) ?? 0;

      double ch1 = double.tryParse(_ch1.text) ?? 0;
      double ch2 = double.tryParse(_ch2.text) ?? 0;
      double ch3 = double.tryParse(_ch3.text) ?? 0;

      double totalCredits = ch1 + ch2 + ch3;

      if (totalCredits > 0) {
        double totalPoints =
            (_getGradePoint(mark1) * ch1) +
            (_getGradePoint(mark2) * ch2) +
            (_getGradePoint(mark3) * ch3);

        double gpaValue = totalPoints / totalCredits;
        _resultGPA = gpaValue.toStringAsFixed(2);

        if (gpaValue >= 3.75) {
          _statusText = "Excellent!";
        } else if (gpaValue >= 3.00) {
          _statusText = "Good!";
        } else if (gpaValue >= 2.33) {
          _statusText = "Satisfactory!";
        } else if (gpaValue >= 2.00) {
          _statusText = "Pass";
        } else {
          _statusText = "Fail";
        }
      }
    });

    player.play(AssetSource('audio/done.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GPA Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10), //space above logo
                Image.asset('assets/images/uum_logo.png', scale: 1.5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250, //mark box
                      child: _buildField("Enter Mark for Subject 1", _mark1),
                    ),
                    const SizedBox(width: 10), //padding btwn boxes
                    SizedBox(
                      width: 150, //ch box
                      child: _buildField("Credit Hours", _ch1),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: _buildField("Enter Mark for Subject 2", _mark2),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: _buildField("Credit Hours", _ch2),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: _buildField("Enter Mark for Subject 3", _mark3),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: _buildField("Credit Hours", _ch3),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _calculateGPA,
                  child: const Text(
                    "Calculate GPA",
                    style: TextStyle(fontSize: 16, color: Colors.purple),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 15), //space btwn star
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GPA: $_resultGPA",
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(_statusText, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0), //textfield
      child: TextField(
        controller: controller, //save input in controller
        decoration: InputDecoration(
          //decor for box
          labelText:
              label, //before click label inside box, after click top of box
          border: const OutlineInputBorder(), //box
        ),
      ),
    );
  }
}
