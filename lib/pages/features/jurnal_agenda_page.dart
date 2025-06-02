import 'package:flutter/material.dart';

class JurnalAgendaPage extends StatefulWidget {
  const JurnalAgendaPage({super.key});

  @override
  State<JurnalAgendaPage> createState() => _JurnalAgendaPageState();
}

class _JurnalAgendaPageState extends State<JurnalAgendaPage> {
  final List<Map<String, String>> daftarJurnal = [
    {
      'tanggal': '2025-05-10',
      'judul': 'Pembelajaran Matematika',
      'ringkasan': 'Membahas operasi bilangan bulat dan latihan soal.',
    },
    {
      'tanggal': '2025-05-11',
      'judul': 'Eksperimen IPA',
      'ringkasan': 'Praktikum tentang perubahan wujud zat.',
    },
    {
      'tanggal': '2025-05-12',
      'judul': 'Sosialisasi Peraturan Sekolah',
      'ringkasan': 'Mengadakan sosialisasi tata tertib baru.',
    },
  ];

  void tambahAtauEditJurnal({Map<String, String>? data, int? index}) {
    final TextEditingController judulController =
        TextEditingController(text: data?['judul']);
    final TextEditingController tanggalController =
        TextEditingController(text: data?['tanggal']);
    final TextEditingController ringkasanController =
        TextEditingController(text: data?['ringkasan']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Tambah Jurnal" : "Edit Jurnal"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tanggalController,
                decoration: InputDecoration(labelText: 'Tanggal (YYYY-MM-DD)'),
              ),
              TextField(
                controller: judulController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: ringkasanController,
                decoration: InputDecoration(labelText: 'Ringkasan'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Batal")),
          ElevatedButton(
            onPressed: () {
              final newEntry = {
                'tanggal': tanggalController.text,
                'judul': judulController.text,
                'ringkasan': ringkasanController.text,
              };

              setState(() {
                if (index == null) {
                  daftarJurnal.add(newEntry);
                } else {
                  daftarJurnal[index] = newEntry;
                }
              });

              Navigator.pop(context);
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void hapusJurnal(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Yakin ingin menghapus jurnal ini?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Batal")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  daftarJurnal.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text("Hapus")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jurnal Agenda"),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarJurnal.length,
        itemBuilder: (context, index) {
          final jurnal = daftarJurnal[index];
          return Dismissible(
            key: Key(jurnal['judul'] ?? '$index'),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (_) async {
              hapusJurnal(index);
              return false;
            },
            child: GestureDetector(
              onTap: () => tambahAtauEditJurnal(data: jurnal, index: index),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.event_note, color: Colors.red, size: 30),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jurnal['judul'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Tanggal: ${jurnal['tanggal']}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              jurnal['ringkasan'] ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        onPressed: () => tambahAtauEditJurnal(),
        child: Icon(Icons.add),
      ),
    );
  }
}
