import 'package:flutter/material.dart';

void main() {
  runApp(const MovieMagic());
}

class MovieMagic extends StatelessWidget {
  const MovieMagic({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Magic',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IndexScreen(),
    );
  }
}

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
