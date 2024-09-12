import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // MethodChannel için gerekli

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.flutter/native'); // Kanal tanımı

  Future<void> _navigateToNativePage() async {
    try {
      // Native koda geçiş yap
      await platform.invokeMethod('navigateToNative');
    } on PlatformException catch (e) {
      print("Failed to invoke native code: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            ElevatedButton(
              onPressed: _navigateToNativePage, // Buton ile native sayfaya geçiş
              child: const Text('Go to Native Swift Page'),
            ),
          ],
        ),
      ),
    );
  }
}