import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadSilabusPage extends StatefulWidget {
  const UploadSilabusPage({super.key});

  @override
  State<UploadSilabusPage> createState() => _UploadSilabusPageState();
}

class _UploadSilabusPageState extends State<UploadSilabusPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();

  File? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'xlsx'],
    );
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih file terlebih dahulu')),
      );
      return;
    }

    final uri = Uri.parse('http://10.0.2.2/api_silabus/upload_file.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['nama'] = namaController.text
      ..fields['kelas'] = kelasController.text
      ..fields['tahun'] = tahunController.text
      ..fields['semester'] = semesterController.text
      ..files
          .add(await http.MultipartFile.fromPath('file', selectedFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload berhasil')),
      );
      Navigator.pop(context, true); // kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal upload')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Silabus')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Silabus'),
            ),
            TextField(
              controller: kelasController,
              decoration: const InputDecoration(labelText: 'Kelas'),
            ),
            TextField(
              controller: tahunController,
              decoration: const InputDecoration(labelText: 'Tahun Ajaran'),
            ),
            TextField(
              controller: semesterController,
              decoration: const InputDecoration(labelText: 'Semester'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.attach_file),
              label: const Text('Pilih File'),
            ),
            if (selectedFile != null)
              Text('Dipilih: ${selectedFile!.path.split('/').last}'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: uploadFile,
              icon: const Icon(Icons.upload),
              label: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
