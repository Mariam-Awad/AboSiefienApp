import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/login_provider.dart';
import '../../../../core/theming/app_styles_util.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool isConnected = false;

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
                    controller: usernameController,
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
                  ),
                  TextFormField(
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(labelText: 'كلمة السر'),
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'كلمة السر خطأ';
                      }
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await Provider.of<LoginProvider>(context, listen: false)
                            .login(usernameController.text,
                                passwordController.text, context);
                      }
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: AppStylesUtil.textRegularStyle(
                        16,
                        Colors.white,
                        FontWeight.w400,
                      ),
                    ),
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
