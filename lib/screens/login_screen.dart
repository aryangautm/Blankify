import 'package:classify/screens/signup_screen.dart';
import 'package:classify/utils/colors.dart';
import 'package:classify/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/Firebase_auth.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
  }

  void LoginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().LoginAuth(
        email: _emailController.text, password: _passController.text);
    if ((res == 'success')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          SvgPicture.asset(
            'assets/classify.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Email Address",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            textEditingController: _passController,
            hintText: "Password",
            textInputType: TextInputType.emailAddress,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
              onTap: () {
                LoginUser();
              },
              child: Container(
                  width: 400,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : const Text('Login In'),
                  // width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor,
                  ))),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Don't have an account!  "),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Container(
                    child: const Text(
                      "Sign up!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ))
            ],
          )
        ]),
      ),
    ));
  }
}
