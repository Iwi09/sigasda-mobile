import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sigasda/pages/dashboards/admin_dashboard.dart';
import 'package:sigasda/pages/dashboards/kepala_sekolah_dashboard.dart';
import 'package:sigasda/pages/dashboards/guru_dashboard.dart';

class LoginPage extends StatefulWidget {
  final String role;
  const LoginPage({required this.role});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1/sigasda_api/login.php'),
      body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
        'role': widget.role.toLowerCase(), // ubah ke lowercase
      },
    );

    if (response.statusCode == 200 && response.body.trim() == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Berhasil")),
      );

      // Navigasi ke dashboard sesuai role
      Widget dashboard;
      switch (widget.role.toLowerCase()) {
        case "kepala_sekolah":
          dashboard = KepalaSekolahDashboard();
          break;
        case "guru":
          dashboard = GuruDashboard();
          break;
        case "admin":
          dashboard = AdminDashboard();
          break;
        default:
          dashboard =
              Scaffold(body: Center(child: Text("Role tidak dikenali")));
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => dashboard),
      );
    } else {
      // Tampilkan response dari backend
      print("LOGIN FAILED: ${response.body}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Gagal: ${response.body}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SISTEM ADMINISTRASI GURU",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("UPTD SDN 1 TEGALURUNG", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Image.asset("assets/images/sekolah.png", height: 60),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: StadiumBorder(),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            Text("UPTD SDN 1 TEGALURUNG", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
