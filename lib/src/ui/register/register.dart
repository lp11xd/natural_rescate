import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/controllers/registerController.dart';
import 'package:naturalrescue/src/ui/login/login.dart';
import 'package:naturalrescue/src/ui/login/login_validator.dart';
import 'package:naturalrescue/src/ui/menu/menu.dart';
import 'package:naturalrescue/src/ui/register/register_request.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final RegisterController controller = Get.put(RegisterController());
  bool _validate = false;
  RegisterRequestData _registerData = RegisterRequestData();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                key: _key,
                autovalidate: _validate,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        new SizedBox(height: 20.0),
        Image.asset('assets/icons/rescue_logo.png', height: 100, width: 100),
        new SizedBox(height: 10.0),
        new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateEmail,
          onSaved: (String value) {
            _registerData.email = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Nombre de usuario',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateField,
          onSaved: (String value) {
            _registerData.username = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Nombres y apellidos',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateField,
          onSaved: (String value) {
            _registerData.fullname = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Ciudad',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateField,
          onSaved: (String value) {
            _registerData.city = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
            autofocus: false,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'show password' : 'hide password',
                ),
              ),
            ),
            validator: FormValidator().validatePassword,
            onChanged: (value) {
              setState(() {
                _registerData.password = value;
              });
            },
            onSaved: (String value) {
              _registerData.password = value;
            }),
        new SizedBox(height: 20.0),
        new TextFormField(
          autofocus: false,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Confirme contraseña',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: _obscureText ? 'show password' : 'hide password',
              ),
            ),
          ),
          validator: (value) {
            if (value == _registerData.password) {
              return null;
            } else {
              return 'La contraseña no coincide';
            }
          },
        ),
        new SizedBox(height: 10.0),
        new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _sendToServer,
            padding: EdgeInsets.all(12),
            color: kColorGreen,
            child: Text('Registrar', style: TextStyle(color: Colors.white)),
          ),
        ),
        new FlatButton(
          onPressed: _sendToRegisterPage,
          child:
              Text('Iniciar sesión', style: TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }

  _sendToRegisterPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      /// No any error in validation
      _key.currentState.save();
      String error = await controller.register(
          _registerData.username,
          _registerData.password,
          _registerData.fullname,
          _registerData.email,
          _registerData.city);
      if (error.isNotEmpty) {
        Get.defaultDialog(title: 'Error', middleText: error);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MenuScreen()));
      }
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
