import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturalrescue/constants.dart';
import 'package:naturalrescue/src/controllers/loginController.dart';
import 'package:naturalrescue/src/ui/login/login_request.dart';
import 'package:naturalrescue/src/ui/menu/menu.dart';
import 'package:naturalrescue/src/ui/register/register.dart';
import 'login_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  LoginRequestData _loginData = LoginRequestData();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                key: _key,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return Column(
      children: <Widget>[
        Image.asset('assets/icons/rescue_logo.png', height: 100, width: 100),
        const SizedBox(height: 50.0),
        TextFormField(
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
            _loginData.email = value;
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
            onSaved: (String value) {
              _loginData.password = value;
            }),
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _sendToServer,
            padding: EdgeInsets.all(12),
            color: kColorGreen,
            child: controller.loginProcess.isFalse
                ? Text('Iniciar Sesión', style: TextStyle(color: Colors.white))
                : LoadingAnimationWidget.discreteCircle(
                    color: Colors.white,
                    size: 15,
                    secondRingColor: Colors.black,
                    thirdRingColor: Colors.purple),
          ),
        ),
        ElevatedButton(
          onPressed: _sendToRegisterPage,
          child:
              Text('Registrate ahora', style: TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }

  _sendToRegisterPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      // String error = await controller.login(
      //  _loginData.email,
      //  _loginData.password,
      // );
      // if (error.isNotEmpty) {
      //  Get.defaultDialog(title: 'Error', middleText: error);
      // } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MenuScreen()));
      // }
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Future<Null> _showForgotPasswordDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Please enter your eEmail'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "Email"),
              onChanged: (String value) {
                _loginData.email = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  _loginData.email = "";
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
