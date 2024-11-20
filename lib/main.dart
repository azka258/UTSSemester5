import 'package:flutter/material.dart';
import 'dart:async'; // Import for the timer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.black87, // Warna latar belakang global
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87, // Warna AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginPage(); // Navigate after splash screen
  }

  // Function to navigate to LoginPage after 3 seconds
  void _navigateToLoginPage() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logomusic.jpg', // Add your logo image in the assets
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Band Schedule App', // App title
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
          builder: (context) => HomePage(username: username),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Gagal'),
          content: const Text('Username atau Password salah!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Login'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black87, // Latar belakang hitam cerah
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logomusic.jpg',
                height: 100,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _userNameTextController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _userPasswordTextController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SchedulePage(),
    const MembersPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Schedule App'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  final List<Map<String, String>> schedules = const [
    {"date": "20 Nov 2024", "location": "Jakarta", "event": "Music Fest"},
    {"date": "25 Nov 2024", "location": "Bandung", "event": "Indie Night"},
    {"date": "1 Dec 2024", "location": "Yogyakarta", "event": "Rock in Town"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // Latar belakang hitam cerah
      child: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.event, color: Colors.pink),
              title: Text(
                schedule['event']!,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "${schedule['date']} - ${schedule['location']}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  final List<Map<String, String>> members = const [
    {"name": "Rayhan", "role": "Vocalist", "image": "assets/rayhan.jpg"},
    {"name": "Azka", "role": "Guitarist", "image": "assets/azka.jpg"},
    {"name": "Dimas", "role": "Guitarist", "image": "assets/dimas.jpg"},
    {"name": "Azril", "role": "Drummer", "image": "assets/azril.jpg"},
    {"name": "Surya", "role": "Bassist", "image": "assets/surya.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // Latar belakang hitam cerah
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    member['image']!,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  member['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  member['role']!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // Latar belakang hitam cerah
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.pink),
            title: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigasi ke halaman Edit Profil
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.pink),
            title: const Text('Ubah Password', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigasi ke halaman Ubah Password
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.pink),
            title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Tampilkan informasi media sosial dalam dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[850],
                  title: const Text(
                    'Tentang Aplikasi',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Aplikasi ini digunakan untuk memantau aktivitas band.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook, color: Colors.blue),
                            onPressed: () {
                              // Tautan ke media sosial
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.email, color: Colors.red),
                            onPressed: () {
                              // Email kontak
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.pink),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
            

              
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}