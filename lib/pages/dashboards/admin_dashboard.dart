import 'package:flutter/material.dart';
import '../../components/custom_button.dart';
import '../features/silabus_page.dart';
import '../features/modul_page.dart';
import '../features/jurnal_agenda_page.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SDN 1 TEGALURUNG"), backgroundColor: Colors.red[900]),
      body: Container(
        color: Colors.red[900],
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selamat Datang", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            const Text("Nama_Admin", style: TextStyle(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  buildCustomButton("Silabus", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SilabusPage()));
                  }),
                  buildCustomButton("Modul", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ModulPage()));
                  }),
                  buildCustomButton("Jurnal Agenda", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const JurnalAgendaPage()));
                  }),
                  buildCustomButton("Backup Data", () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Backup Data belum tersedia")));
                  }),
                  buildCustomButton("Web", () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fitur Web belum tersedia")));
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