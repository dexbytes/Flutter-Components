import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage>
    with SingleTickerProviderStateMixin {
  String _name;
  String _password;
  String _email;

  List tags = new List();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        labelStyle: TextStyle(fontSize: 20),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is Required";
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 20),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is Required";
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 25),
        hintText: "enter your email",
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Email is Required";
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text("TextFormField"),
            backgroundColor: Colors.brown,
          ),
          body: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNameField(),
                _buildPassword(),
                _buildEmail(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          color: Colors.brown,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            if (!_formkey.currentState.validate()) {
                              return;
                            }

                            _formkey.currentState.save();

                            print(_name);
                            print(_password);
                            print(_email);
                          }),
                      RaisedButton(
                        color: Colors.brown,
                        child: Text(
                          'Cancle',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          SnackBar mysnackbar = SnackBar(
                            content: Text(
                              "Hello Mohit",
                              style:
                                  TextStyle(fontSize: 36, color: Colors.white),
                            ),
                            backgroundColor: Colors.brown,
                          );
                          Scaffold.of(context).showSnackBar(mysnackbar);
                        },
                      ),
                    ]),
              ],
            ),
          )),
    );
  }
}
