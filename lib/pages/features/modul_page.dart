import 'package:flutter/material.dart';

class ModulPage extends StatefulWidget {
  const ModulPage({super.key});

  @override
  State<ModulPage> createState() => _ModulPageState();
}

class _ModulPageState extends State<ModulPage> {
  List<String> modulList = [
    'Modul Matematika Kelas 1',
    'Modul Bahasa Indonesia Kelas 2',
    'Modul IPA Kelas 3',
  ];

  final TextEditingController _modulController = TextEditingController();

  void _tambahModul() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Modul'),
        content: TextField(
          controller: _modulController,
          decoration: const InputDecoration(hintText: 'Judul Modul'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _modulController.clear();
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_modulController.text.isNotEmpty) {
                setState(() {
                  modulList.add(_modulController.text);
                });
              }
              Navigator.pop(context);
              _modulController.clear();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _editModul(int index) {
    _modulController.text = modulList[index];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Modul'),
        content: TextField(
          controller: _modulController,
          decoration: const InputDecoration(hintText: 'Judul Modul'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _modulController.clear();
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                modulList[index] = _modulController.text;
              });
              Navigator.pop(context);
              _modulController.clear();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _hapusModul(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Modul'),
        content: const Text('Apakah kamu yakin ingin menghapus modul ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                modulList.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modul"),
        backgroundColor: Colors.red[900],
      ),
      body: ListView.builder(
        itemCount: modulList.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(modulList[index]),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _editModul(index);
                } else if (value == 'delete') {
                  _hapusModul(index);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Hapus')),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahModul,
        backgroundColor: Colors.red[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}
