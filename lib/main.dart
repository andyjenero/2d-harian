import 'package:flutter/material.dart';

void main() {
  runApp(const TwoDHarianApp());
}

class TwoDHarianApp extends StatelessWidget {
  const TwoDHarianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2D Harian',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _controller = TextEditingController();
  String _prediksi = '';

  void _hitungPrediksi() {
    String input = _controller.text.trim();
    if (input.isEmpty || !RegExp(r'^\d{2}$').hasMatch(input)) {
      setState(() {
        _prediksi = 'Masukkan angka 2D (00-99)';
      });
      return;
    }

    int angka = int.parse(input);
    List<int> hasil = _generatePrediksi(angka);

    setState(() {
      _prediksi = 'Prediksi: ${hasil.join(', ')}';
    });
  }

  List<int> _generatePrediksi(int seed) {
    List<int> prediksi = [];
    for (int i = 0; i < 10; i++) {
      int angka = (seed * (i + 3) + i * 7) % 100;
      if (!prediksi.contains(angka)) prediksi.add(angka);
    }
    return prediksi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2D Harian')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Angka 2D terakhir (contoh: 80)',
              ),
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hitungPrediksi,
              child: const Text('Prediksi Angka'),
            ),
            const SizedBox(height: 20),
            Text(_prediksi, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
