import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditSilabusPage extends StatefulWidget {
  final Map silabusData;
  const EditSilabusPage({super.key, required this.silabusData});

  @override
  State<EditSilabusPage> createState() => _EditSilabusPageState();
}

class _EditSilabusPageState extends State<EditSilabusPage> {
  late TextEditingController namaController;
  late TextEditingController kelasController;
  late TextEditingController semesterController;
  late TextEditingController tahunController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.silabusData['nama']);
    kelasController = TextEditingController(text: widget.silabusData['kelas']);
    semesterController = TextEditingController(text: widget.silabusData['semester']);
    tahunController = TextEditingController(text: widget.silabusData['tahun']);
  }

  Future<void> updateSilabus() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/sigasda1/api_silabus/update_file.php'),
      body: {
        'id': widget.silabusData['id'],
        'nama': namaController.text,
        'kelas': kelasController.text,
        'semester': semesterController.text,
        'tahun': tahunController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Update berhasil')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal update')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Silabus')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Silabus'),
            ),
            TextFormField(
              controller: kelasController,
              decoration: const InputDecoration(labelText: 'Kelas'),
            ),
            TextFormField(
              controller: semesterController,
              decoration: const InputDecoration(labelText: 'Semester'),
            ),
            TextFormField(
              controller: tahunController,
              decoration: const InputDecoration(labelText: 'Tahun Ajaran'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateSilabus,
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
