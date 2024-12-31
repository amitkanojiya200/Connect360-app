import 'package:amit_ka_project_hai_naya_wala_1/sections/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUP_page.dart';
import '../main.dart'; // Replace with your main screen import

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = 'crcrcrc';
  String _email = 'crcrcr@crdotcom';
  String _password = 'crccrcrrr';
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() {
    UserInfoPage(username: _username, email: _email, password: _password);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainScreen(), // Navigate to your Main Page
    ));
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });

    //   _formKey.currentState!.save();

    //   // Check if the credentials match with the stored credentials
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? savedEmail = prefs.getString('email');
    //   String? savedPassword = prefs.getString('password');

    //   // Simulating a network request or login process
    //   await Future.delayed(Duration(seconds: 2));

    //   if (_email == savedEmail && _password == savedPassword) {
    //     await prefs.setBool('isLoggedIn', true); // Set login state
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => MainApp()), // Replace with your main screen
    //     );
    //   } else {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     _showErrorDialog('Invalid credentials. Please try again.');
    //   }
    // }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.purple
          ], // Adjust the gradient colors as needed
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      // Center the entire form on the screen
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Minimize the height to fit the content
            children: [
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _email = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              _buildPasswordField(
                label: 'Password',
                obscureText: _obscurePassword,
                toggleObscureText: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
              SizedBox(height: 16.0),
              Text(
                'OR',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              _buildSocialButton('Log in with Google', 'assets/google.png',
                  Colors.white, Colors.black),
              SizedBox(height: 10.0),
              _buildSocialButton('Log in with Facebook', 'assets/facebook.png',
                  Color(0xFF1877F2), Colors.white),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  ); // Navigate to sign-up page
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String?) onSaved,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      ),
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool obscureText,
    required Function() toggleObscureText,
    required Function(String?) onSaved,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleObscureText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      ),
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildSocialButton(
      String label, String assetPath, Color backgroundColor, Color textColor) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle social login here
      },
      icon: Image.asset(assetPath, height: 20.0),
      label: Text(label, style: TextStyle(fontSize: 16.0, color: textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
