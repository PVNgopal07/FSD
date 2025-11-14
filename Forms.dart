import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyForm(),
  debugShowCheckedModeBanner: false,
));

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  Widget field(
    String label,
    IconData icon,
    TextEditingController c, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
    String? Function(String?)? validate,
  }) {
    return TextFormField(
      controller: c,
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: validate,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Form'),
      backgroundColor: Colors.deepPurple,
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            field(
              'Name',
              Icons.person,
              _name,
              validate: (v) => v!.isEmpty ? 'Enter name' : null,
            ),
            SizedBox(height: 16),
            field(
              'Email',
              Icons.email,
              _email,
              type: TextInputType.emailAddress,
              validate: (v) => v!.isEmpty
                  ? 'Enter email'
                  : !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(v)
                      ? 'Invalid email'
                      : null,
            ),
            SizedBox(height: 16),
            field(
              'Password',
              Icons.lock,
              _pass,
              obscure: true,
              validate: (v) => v!.length < 6 ? 'Min 6 characters' : null,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Name: ${_name.text}, Email: ${_email.text}, Password: ${_pass.text}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Form submitted!')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}
