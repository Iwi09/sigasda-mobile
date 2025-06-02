import 'package:flutter/material.dart';
import '../../components/custom_button.dart';
import '../features/dokumen_page.dart';
import '../features/evaluasi_page.dart';
import '../features/guru_page.dart';

class KepalaSekolahDashboard extends StatelessWidget {
  const KepalaSekolahDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SDN 1 TEGALURUG"), backgroundColor: Colors.red[900]),
      body: Container(
        color: Colors.red[900],
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama_Kepala_Sekolah", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  buildCustomButton("Dokumen", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DokumenPage()));
                  }),
                  buildCustomButton("Evaluasi", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EvaluasiPage()));
                  }),
                  buildCustomButton("Guru", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GuruPage()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}