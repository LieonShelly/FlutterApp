import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter in iOS',
      routes: {'/home': (_) => FlutterHome()},
    );
  }
}

class NativeHome extends StatelessWidget {
  const NativeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '原生页面占位\n请通过按钮跳转到 /home',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}

class FlutterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter 页面')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('你已成功从 iOS 跳转到 Flutter！', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('返回 iOS'),
            ),
          ],
        ),
      ),
    );
  }
}
