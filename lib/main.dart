import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userPasswordTextController = TextEditingController();

  final String correctUsername = "admin";
  final String correctPassword = "password";

  void _login() {
    String username = _userNameTextController.text;
    String password = _userPasswordTextController.text;

    if (username == correctUsername && password == correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(username: username),
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Login Gagal'),
          content: const Text('Username atau Password salah!'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Halaman Login'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logomusic.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              controller: _userNameTextController,
              placeholder: 'Username',
              padding: const EdgeInsets.all(12.0),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: _userPasswordTextController,
              placeholder: 'Password',
              obscureText: true,
              padding: const EdgeInsets.all(12.0),
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[200]!, Colors.pink[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                '$username!',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(
                      icon: Icons.person,
                      title: 'Profil',
                      color: Colors.teal,
                      onTap: () {
                        // Aksi untuk Profil
                      },
                    ),
                    _buildDashboardCard(
                      icon: Icons.settings,
                      title: 'Pengaturan',
                      color: Colors.blue,
                      onTap: () {
                        // Aksi untuk Pengaturan
                      },
                    ),
                    _buildDashboardCard(
                      icon: Icons.notifications,
                      title: 'Notifikasi',
                      color: Colors.orange,
                      onTap: () {
                        // Aksi untuk Notifikasi
                      },
                    ),
                    _buildDashboardCard(
                      icon: Icons.help,
                      title: 'Bantuan',
                      color: Colors.red,
                      onTap: () {
                        // Aksi untuk Bantuan
                      },
                    ),
                    _buildDashboardCard(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: Colors.pink,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
