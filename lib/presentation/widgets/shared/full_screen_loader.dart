import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Recomendando películas para tí',
      'Comprando palomitas de maíz 🍿',
      'Cargando películas populares',
      'Llamando a mi pareja 😍',
      'Preparando todo...',
      'Esto está tardando más de lo esperado... 😭',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 2200),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Cargando películas', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 50),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              return FadeIn(
                key: ValueKey(snapshot.data),
                child: Text(snapshot.data ?? 'Cargando...'),
              );
            },
          ),
        ],
      ),
    );
  }
}
