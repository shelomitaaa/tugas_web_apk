import 'package:flutter/material.dart';

// =======================================================
// PACKAGE / MODULE: MODELS
// (Sebagai blueprint object dan implementasi PBO)
// =======================================================

class AppProduct {
  // 1. Variabel Private (Encapsulation)
  final String _name;
  int _price;
  final String _logoUrl;

  // 2. Constructor (Membangun object)
  AppProduct(this._name, this._price, this._logoUrl);

  // 3. Getter (Mengambil data secara aman)
  String get name => _name;
  int get price => _price;
  String get logoUrl => _logoUrl;

  // 4. Setter (Mengubah data dengan aturan/validasi)
  set price(int newPrice) {
    if (newPrice > 0) {
      _price = newPrice;
    }
  }

  // 5. Function / Method (Perilaku spesifik dari object)
  String getFormattedPrice() {
    // Logika mengubah angka 15000 menjadi string "Rp 15.000"
    String priceStr = _price.toString();
    if (priceStr.length > 3) {
      priceStr =
          '${priceStr.substring(0, priceStr.length - 3)}.${priceStr.substring(priceStr.length - 3)}';
    }
    return 'Rp $priceStr';
  }

  String getCheckoutMessage() {
    return 'Yay! $_name berhasil masuk keranjang! 🛒✨';
  }
}

// =======================================================
// PACKAGE / MODULE: MAIN APP & UI (VIEWS)
// =======================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Aplikasi Premium',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFFff85a2),
        scaffoldBackgroundColor: const Color(0xFFffe6f2),
      ),
      home: const LoginScreen(),
    );
  }
}

// 1. HALAMAN LOGIN
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_nameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Nama dan password harus diisi ya! 🥺',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFff85a2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(username: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFffe6f2), Color(0xFFe6f7ff)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(
                  0xF2FFFFFF,
                ), // Menggunakan Hex ARGB untuk opacity 95%
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome! ✨',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFff85a2),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Masuk dulu yuk ke toko aplikasi premium paling gemas!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Kamu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFffe6f2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFff85a2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password (bebas)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFffe6f2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFFff85a2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFff85a2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Login Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. HALAMAN WELCOME
class WelcomeScreen extends StatelessWidget {
  final String username;
  const WelcomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFffe6f2), Color(0xFFe6f7ff)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(
                  0xF2FFFFFF,
                ), // Menggunakan Hex ARGB untuk opacity 95%
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 30),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://media.giphy.com/media/l4pTfx2qLszoacZRS/giphy.gif',
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hai, $username! 💖',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFff85a2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Selamat datang di ruang tunggu! Siap buat hunting aplikasi premium yang bikin hidup makin seru?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFff85a2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Mulai Belanja 🛍️',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 3. HALAMAN TOKO
class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  // Instansiasi Object menggunakan Blueprint AppProduct (Implementasi OOP)
  final List<AppProduct> apps = [
    AppProduct('Canva Pro', 15000, 'https://logo.clearbit.com/canva.com'),
    AppProduct('CapCut Pro', 20000, 'https://logo.clearbit.com/capcut.com'),
    AppProduct('AM Pro', 18000, 'https://logo.clearbit.com/alightcreative.com'),
    AppProduct('Netflix UHD', 35000, 'https://logo.clearbit.com/netflix.com'),
    AppProduct('Spotify Prem', 12000, 'https://logo.clearbit.com/spotify.com'),
    AppProduct('iQIYI VIP', 15000, 'https://logo.clearbit.com/iq.com'),
    AppProduct('YT Premium', 10000, 'https://logo.clearbit.com/youtube.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '✨ Etalase Premium ✨',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFff85a2),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFff85a2)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFffe6f2), Color(0xFFe6f7ff)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final product = apps[index]; // Mengambil object AppProduct
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                shadowColor: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey[100],
                          child: Image.network(
                            product.logoUrl, // Menggunakan Getter
                            height: 60,
                            width: 60,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ), // Menggunakan Getter
                      const SizedBox(height: 5),
                      Text(
                        product.getFormattedPrice(),
                        style: const TextStyle(
                          color: Color(0xFFff85a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ), // Menggunakan Function
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF72c5ff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  product.getCheckoutMessage(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), // Menggunakan Function Object
                                backgroundColor: const Color(0xFF72c5ff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text(
                            'Beli',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
