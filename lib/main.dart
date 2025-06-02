import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Administrasi Guru',
      home: RoleSelectionPage(),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoleButton(title: "Kepala_Sekolah", role: "kepala_sekolah"),
            RoleButton(title: "Guru", role: "guru"),
            RoleButton(title: "Admin", role: "admin"),
          ],
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final String title;
  final String role;

  const RoleButton({required this.title, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red[900],
          minimumSize: Size(200, 50),
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginPage(role: role)),
          );
        },
        child: Text(title),
      ),
    );
    
  }
}
