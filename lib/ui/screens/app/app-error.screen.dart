import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppErrorScreen extends HookWidget {
  final Object? error;

  const AppErrorScreen({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Failed to start'),
            Text('Error $error'),
          ],
        ),
      ),
    );
  }
}
