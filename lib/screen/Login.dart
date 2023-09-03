import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_application_1/model/login_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/model/config.dart';

import 'home.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users user) async {
    var params = {"email": user.email, "password": user.password};

    var url = Uri.http(Configure.server, "users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("username or password invalid")));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 215, 234),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextHeader(),
              emailInputField(),
              passwordInputField(),
              SizedBox(height: 10.0),
              Row(
                children: [
                  submitButton(),
                  SizedBox(width: 10.0),
                  backButton(),
                  SizedBox(width: 10.0),
                  registerLink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 125, 183)),
        ),
        SizedBox(height: 10.0),
        Text(
          'Welcome back! Please login to your account.',
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "a@test.com",
      decoration: InputDecoration(labelText: "Email:", icon: Icon(Icons.email)),
      validator:
          ValidationBuilder().email().build(), // Use form_validator package
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "1q2w3e4r",
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password", icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 255, 157, 214)),
      ),
      child: Text("Login"),
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Use Navigator.pop to go back
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 255, 157, 214)),
      ),
      child: Text("Back"),
    );
  }

  Widget registerLink() {
    return InkWell(
      child: Text("Sign Up"),
      onTap: () {
        // Handle sign up link tap here
      },
    );
  }
}
