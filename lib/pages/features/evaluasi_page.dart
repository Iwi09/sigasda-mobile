import 'package:flutter/material.dart';

class EvaluasiPage extends StatelessWidget {
  const EvaluasiPage({super.key});

  final List<Map<String, String>> evaluasiList = const [
    {
      'nama': 'Ibu Siti',
      'mapel': 'Bahasa Indonesia',
      'skor': '85',
      'komentar': 'Sangat baik dan komunikatif',
    },
    {
      'nama': 'Pak Budi',
      'mapel': 'Matematika',
      'skor': '78',
      'komentar': 'Perlu peningkatan dalam penjelasan konsep',
    },
    {
      'nama': 'Ibu Rina',
      'mapel': 'IPA',
      'skor': '90',
      'komentar': 'Interaktif dan disiplin tinggi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evaluasi Guru"),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: evaluasiList.length,
        itemBuilder: (context, index) {
          final data = evaluasiList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['nama'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text("Mata Pelajaran: ${data['mapel']}"),
                  Text("Skor Evaluasi: ${data['skor']}"),
                  const SizedBox(height: 8),
                  Text("Komentar: ${data['komentar']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
