import 'package:flutter/material.dart';
import 'package:webapp/services/auth.dart';
import 'package:webapp/widgets/logo.dart';

import 'brand_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        Flexible(child: Logo()),
        Expanded(child: SignupCard(), flex: 3)
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }
}

class SignupCard extends StatelessWidget {
  const SignupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            child: Card(
                child: Container(
              child: const SignupForm(),
              padding: const EdgeInsets.all(10),
            )),
            width: 400,
            height: 400));
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<SignupFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
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
                controller: name,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'name',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              )),
          Container(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
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
                    signupUser(name.text, email.text, password.text)
                        .then((result) => {
                              if (result.isEmpty)
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
                  child: const Text("I already have an account"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  }))
        ],
      ),
    );
  }
}
