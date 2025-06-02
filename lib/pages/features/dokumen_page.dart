import 'package:flutter/material.dart';

class DokumenPage extends StatefulWidget {
  const DokumenPage({super.key});

  @override
  State<DokumenPage> createState() => _DokumenPageState();
}

class _DokumenPageState extends State<DokumenPage> {
  final List<String> dokumenList = ['Dokumen 1', 'Dokumen 2', 'Dokumen 3'];
  final TextEditingController _controller = TextEditingController();

  void _tambahDokumen(String nama) {
    if (nama.isNotEmpty) {
      setState(() {
        dokumenList.add(nama);
      });
      _controller.clear();
    }
  }

  void _hapusDokumen(int index) {
    setState(() {
      dokumenList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Dokumen"), backgroundColor: Colors.red[900]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input tambah dokumen
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nama Dokumen',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _tambahDokumen(_controller.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                  ),
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Daftar dokumen
            Expanded(
              child: ListView.builder(
                itemCount: dokumenList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(dokumenList[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _hapusDokumen(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
