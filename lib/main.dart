import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomText = WordPair.random().asPascalCase; // Generar texto aleatorio
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            randomText,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomWordsScreen()),
              );
            },
            child: Text('Words'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomNounsScreen()),
              );
            },
            child: Text('Nouns'),
          ),
        ],
      ),
    );
  }
}

class RandomWordsScreen extends StatelessWidget {
  const RandomWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Words'),
      ),
      body: RandomWords(),
    );
  }
}

class RandomNounsScreen extends StatelessWidget {
  const RandomNounsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Nouns'),
      ),
      body: RandomNouns(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomNouns extends StatefulWidget {
  const RandomNouns({Key? key}) : super(key: key);

  @override
  RandomNounsState createState() => RandomNounsState();
}

class RandomNounsState extends State<RandomNouns> {
  final _nouns = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _generateNouns();
  }

  void _generateNouns() {
    for (int i = 0; i < 10; i++) {
      _nouns.add(nouns[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildNouns();
  }

  Widget _buildNouns() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _nouns.length,
      itemBuilder: (context, i) {
        return _buildRow(_nouns[i]);
      },
    );
  }

  Widget _buildRow(String noun) {
    return ListTile(
      title: Text(
        noun,
        style: _biggerFont,
      ),
    );
  }
}
