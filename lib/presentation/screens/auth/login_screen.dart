import 'package:abosiefienapp/presentation/screens/auth/login_provider.dart';
import 'package:abosiefienapp/utils/app_assets_util.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 260,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Image.asset(
                    AppAssetsUtil.logoImage,
                    fit: BoxFit.fitWidth,
                    width: deviceSize.width * 0.75,
                    height: 260.0,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ارْعَوْا رَعِيَّةَ اللهِ الَّتِي بَيْنَكُمْ',
                      textAlign: TextAlign.center,
                      style: AppStylesUtil.textBoldStyle(
                          18.0, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '1 بط 5: 2',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: AppStylesUtil.textBoldStyle(
                          18.0, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const AuthCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isConnected = false;

  Map<String, String> authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    await Provider.of<LoginProvider>(context, listen: false)
        .login(authData['email']!, authData['password']!, context)
        .then((value) => {
              if (value == true)
                {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.homeRouteName)
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: 240,
        color: Colors.white,
        constraints: const BoxConstraints(minHeight: 240),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textDirection: TextDirection.rtl,
                    decoration:
                        const InputDecoration(labelText: 'إسم المستخدم'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'إسم المستخدم خطأ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(labelText: 'كلمة السر'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'كلمة السر خطأ';
                      }
                    },
                    onSaved: (value) {
                      authData['password'] = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange.shade900,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Text('تسجيل الدخول',
                        style: AppStylesUtil.textRegularStyle(
                            16, Colors.white, FontWeight.w400)),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
