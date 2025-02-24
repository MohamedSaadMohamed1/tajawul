import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E8),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SvgPicture.asset(
                'assets/tajawul_logo.svg',
                height: 50,
              ),
              SizedBox(height: 16),
              Text(
                'Unlock Access To Hundreds Of Trips',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Join a Community Of Like-Minded Travelers And Explore Unique Trips Tailored To Your Interests!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create a Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D2D24),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Already a Member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Log In ',
                          style: TextStyle(
                            color: Color(0xFF567189),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'using your Tajawul account',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
