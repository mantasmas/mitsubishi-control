import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mitsubishi_control/cubit/auth_cubit.dart';
import 'package:mitsubishi_control/models/auth.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  final _formKey = GlobalKey<FormState>();
  final _loginFormController = TextEditingController();
  AuthInfo _authInfo = new AuthInfo();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _loginFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _loginFormController,
      style: style,
      onChanged: (val) => _authInfo.email = val,
      decoration: InputDecoration(hintText: 'Email'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    final passwordField = TextFormField(
      style: style,
      onChanged: (val) => _authInfo.password = val,
      decoration: InputDecoration(hintText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    void login() {
      final authCubit = context.read<AuthCubit>();

      authCubit.login(_authInfo);
    }

    final submitButton = Container(
      margin: EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            login();
          }
        },
        child: Text('Login'),
      ),
    );

    Widget buildLoginForm({String error}) {
      return Column(
        children: [
          SvgPicture.asset('assets/icons/mitsubishi.svg',
              height: 72, semanticsLabel: 'Mitsubishi Logo'),
          Container(
            child: Text(
              'Login with mitsubishi credentials',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(top: 30, bottom: 20),
          ),
          emailField,
          passwordField,
          if (error != null) Text(error),
          submitButton
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }

    final spinner = SpinKitRotatingCircle(
      color: Colors.red,
    );

    return Scaffold(
        body: Form(
      key: _formKey,
      child: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) return buildLoginForm();
            if (state is LoginInitiated) return spinner;
            if (state is LoginError)
              return buildLoginForm(
                  error: "Failed to login, please try again.");
          },
        ),
      )),
    ));
  }
}
