import 'package:flutter/material.dart';
// import 'package:chips_input_autocomplete/chips_input_autocomplete.dart';

void main() {
  runApp(const FlutterDemo());
}

class FlutterDemo extends StatelessWidget {
  const FlutterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chips Input Autocomplete Demo'),
      ),
      body: const Center(
        child: ChipsInputExample(),
      ),
    );
  }
}

class ChipsInputExample extends StatefulWidget {
  const ChipsInputExample({Key? key}) : super(key: key);

  @override
  _ChipsInputExampleState createState() => _ChipsInputExampleState();
}

class _ChipsInputExampleState extends State<ChipsInputExample> {
  final List<String> _options = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

  @override
  Widget build(BuildContext context) {
    // return ChipsInputAutocomplete(
    //   options: _options,
    // );
    return Container();
  }
}