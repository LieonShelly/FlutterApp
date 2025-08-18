import 'package:flutter/material.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class LoginPage extends StatelessWidget {
  const LoginPage({required this.onLogIn, super.key});

  final ValueChanged<Credentials> onLogIn;

  @override
  Widget build(BuildContext context) {
    final desktopView = Row(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/login_background.webp",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: LoginForm(onLogin: onLogIn),
          ),
        ),
      ],
    );
    final mobileView = Column(
      children: [Expanded(child: LoginForm(onLogin: onLogIn))],
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 700) {
            return desktopView;
          } else {
            return mobileView;
          }
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({required this.onLogin, super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueChanged<Credentials> onLogin;

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset("assets/yummy_logo.png");
    final username = TextField(
      controller: _userNameController,
      decoration: InputDecoration(
        hintText: 'Uername',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    final password = TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    final submitBtn = ElevatedButton(
      child: const Text('Login'),
      onPressed: () async {
        onLogin(
          Credentials(
            _userNameController.value.text,
            _passwordController.value.text,
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          const SizedBox(height: 20),
          username,
          const SizedBox(height: 12),
          password,
          const SizedBox(height: 24),
          submitBtn,
        ],
      ),
    );
  }
}
