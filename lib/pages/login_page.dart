import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      if (kDebugMode) {
        print('Username: $_username, Password: $_password');
      }
      // For demonstration purposes, navigate to a new screen on submit
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void _signupUser() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      if (kDebugMode) {
        print('Username: $_username, \nPassword: $_password');
      }
      // For demonstration purposes, navigate to a new screen on submit
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void _guestLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Smart Grocery'),
          bottom: const TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.account_circle_rounded), text: 'Returning Users',),
            Tab(icon: Icon(Icons.account_box_rounded), text: 'New Users'),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            loginTab(context),
            signUpTab(context),
          ],
        ),
      ),
    );
  }

  Widget loginTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(
                  'Smart Grocery: \nYour Pantry\'s\n Best Friend',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[200],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image(image: AssetImage('assets/logo.png'), height: 150.0,),

              ),
              customTextFormField('Username', false),
              const SizedBox(height: 16),
              customTextFormField('Password', true),
              const SizedBox(height: 16),
              customButton(context, 'Login', _loginUser),
              const SizedBox(height: 16),
              customTextButton('Continue as guest', _guestLogin),

            ],
          ),
        ),
      ),
    );
  }

  Widget signUpTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextFormField('Name', false),
              const SizedBox(height: 16),
              customTextFormField('Email', false),
              const SizedBox(height: 16),
              customTextFormField('Username', false),
              const SizedBox(height: 16),
              customTextFormField('Password', true),
              const SizedBox(height: 16),
              customTextFormField('Dietary Restrictions and Allergies', false),
              const SizedBox(height: 16),
              customTextFormField('Food Preferences', false),
              const SizedBox(height: 16),
              customButton(context, 'Sign up', _loginUser),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextFormField(String label, bool obscureText) {
    return TextFormField(
      onChanged: (value) {
        // setState logic here
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
      ),
      obscureText: obscureText,
    );
  }

  Widget customButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget customTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}