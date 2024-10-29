import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Application'),
        ),
        body: const Center(
          child: Movies(),
        ),
      ),
    );
  }
}

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text('Movie $index'),
              leading: Image.network(
                'https://picsum.photos/50/50?random=$index',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (starIndex) {
                  return Icon(
                    starIndex < 3 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
            );
          },
        )),
      ],
    );
  }
}
