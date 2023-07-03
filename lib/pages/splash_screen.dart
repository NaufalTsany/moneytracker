import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moneytracker/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Panggil fungsi navigateToHome saat initState
  }

  void navigateToHome() async {
    await Future.delayed(
        Duration(seconds: 2)); // Simulasikan waktu tampilan SplashScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomePage()), // Navigasi ke tampilan HomeScreen
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(
            0xFF126F69), // Ganti dengan warna latar belakang yang diinginkan
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/Keuangan1.png"),
                width: 200,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Money Tracker", // Ganti dengan teks yang diinginkan
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(
                      0xFFFFFFFF), // Ganti dengan warna teks yang diinginkan
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}