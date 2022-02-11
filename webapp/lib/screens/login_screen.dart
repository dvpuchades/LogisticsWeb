import 'package:flutter/material.dart';
import 'package:webapp/models/user.dart';
import 'package:webapp/screens/brand_screen.dart';
import 'package:webapp/screens/dashboard.dart';
import 'package:webapp/screens/signup_screen.dart';
import 'package:webapp/screens/starter.dart';
import 'package:webapp/services/auth.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        Flexible(child: Text('Fattorino', style: LogoTextStyle())),
        Expanded(child: LoginCard(), flex: 3)
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            child: Card(
                child: Container(
              child: const LoginForm(),
              padding: const EdgeInsets.all(10),
            )),
            width: 400,
            height: 350));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LoginFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'email',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              )),
          Container(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'password',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              )),
          Container(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    loginUser(email.text, password.text).then((result) => {
                          if (result.isEmpty)
                            {
                              if (User.getInstance().brand.isEmpty)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BrandMenu()),
                                  )
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Starter()),
                                  )
                                }
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result)),
                              )
                            }
                        });
                  }
                },
                child: const Text('Submit'),
              )),
          Container(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                  child: const Text("I don't have an account"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  }))
        ],
      ),
    );
  }
}
