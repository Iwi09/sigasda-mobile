import 'package:flutter/material.dart';

class GuruPage extends StatelessWidget {
  const GuruPage({super.key});

  final List<Map<String, String>> daftarGuru = const [
    {
      'nama': 'Ibu Siti Aminah',
      'nip': '19800101 200501 2 001',
      'mapel': 'Bahasa Indonesia',
    },
    {
      'nama': 'Pak Budi Santoso',
      'nip': '19751212 200003 1 002',
      'mapel': 'Matematika',
    },
    {
      'nama': 'Ibu Rina Marlina',
      'nip': '19850315 200604 2 003',
      'mapel': 'IPA',
    },
    {
      'nama': 'Pak Hendra Wijaya',
      'nip': '19870807 200802 1 004',
      'mapel': 'IPS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Guru"),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarGuru.length,
        itemBuilder: (context, index) {
          final guru = daftarGuru[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.red),
              title: Text(guru['nama'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NIP: ${guru['nip']}"),
                  Text("Mata Pelajaran: ${guru['mapel']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
