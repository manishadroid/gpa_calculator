import 'package:flutter/material.dart';

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
  final _sub1 = TextEditingController();
  final _sub2 = TextEditingController();
  final _sub3 = TextEditingController();

  String _resultGPA = "0.00"; //GPA result

  void _calculateGPA() {
    setState(() {
      double mark1 =
          double.tryParse(_sub1.text) ?? 0; // if null, return 0 (abc or empty)
      double mark2 = double.tryParse(_sub2.text) ?? 0;
      double mark3 = double.tryParse(_sub3.text) ?? 0;

      double avg = (mark1 + mark2 + mark3) / 3;
      double gpaValue = (avg / 100) * 4.0;

      _resultGPA = gpaValue.toStringAsFixed(2);
    });
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
                const SizedBox(height: 20),
                _buildField("Enter your score for Subject 1", _sub1), //inputs
                _buildField("Enter your score for Subject 2", _sub2),
                _buildField("Enter your score for Subject 3", _sub3),

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("GPA: $_resultGPA")],
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
      ),
    );
  }
}
