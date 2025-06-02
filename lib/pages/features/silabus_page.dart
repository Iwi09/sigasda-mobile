import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SilabusPage extends StatelessWidget {
  const SilabusPage({super.key});

  final List<_FileItem> files = const [
    _FileItem(name: 'Silabus PDF', assetPath: 'assets/files/silabus.pdf'),
    _FileItem(name: 'Silabus1 DOCX', assetPath: 'assets/files/silabus1.docx'),
    _FileItem(name: 'Silabus DOCX', assetPath: 'assets/files/silabus.docx'),
    _FileItem(name: 'Silabus XLSX', assetPath: 'assets/files/silabus.xlsx'),
  ];

  Future<void> _downloadFile(BuildContext context, _FileItem fileItem) async {
    try {
      final ByteData bytes = await rootBundle.load(fileItem.assetPath);
      final Uint8List list = bytes.buffer.asUint8List();
      final dir =
          await getExternalStorageDirectory(); // gunakan Downloads jika perlu

      final downloadPath = "${dir!.path}/${fileItem.assetPath.split('/').last}";
      final File file = File(downloadPath);
      await file.writeAsBytes(list);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil didownload ke:\n$downloadPath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silabus'),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          final item = files[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(item.assetPath),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () => _downloadFile(context, item),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FileItem {
  final String name;
  final String assetPath;
  const _FileItem({required this.name, required this.assetPath});
}
