import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat_app/widget/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,File? image,
      bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(XFile image) {
    _userImageFile = File(image.path);
  }

  void _trySubMit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text('Please pick an Image.')));
      return;
    }
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),_userImageFile,
        _isLogin, context);
    // auth requset
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      onSaved: (val) {
                        _userEmail = val!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'please enter a valid email address';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        onSaved: (val) {
                          _userName = val!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'please enter atleast 4 values';
                          }
                        },
                        decoration: InputDecoration(labelText: 'UserName'),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      onSaved: (val) {
                        _userPassword = val!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password must be atleast 7 characters long';
                        }
                      },
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                          onPressed: _trySubMit,
                          child: Text(_isLogin ? 'Login' : 'SignUp')),
                    if (!widget.isLoading)
                      TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor)),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'create New Acount'
                              : 'I already have an acount'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
