import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyColorProvider()),
      ],
      child: const MaterialApp(
        home: _MyHomePage(),
      ),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyColorProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Provider Demo',
          style: TextStyle(color: state.allColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              AnimatedContainer(
                width: 250,
                height: 250,
                color: state.allColor,
                duration: const Duration(seconds: 1),
              ),
              const SizedBox(height: 16),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                  state.changeColor();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyColorProvider extends ChangeNotifier {
  Color _color = Colors.blueGrey;
  Color get allColor => _color;

  void changeColor() {
    _color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }
}
