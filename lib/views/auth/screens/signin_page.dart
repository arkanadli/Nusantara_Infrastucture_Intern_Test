import 'package:auth_restfull/controllers/login_controller.dart';
import 'package:auth_restfull/core/constants/constants.dart';
import 'package:auth_restfull/views/auth/screens/register_page.dart';
import 'package:auth_restfull/views/auth/widgets/my_password_field.dart';
import 'package:auth_restfull/views/auth/widgets/my_text_button.dart';
import 'package:auth_restfull/views/auth/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  LoginController loginController = Get.put(LoginController());
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back.",
                        style: tHeadline,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You've been missed!",
                        style: tBodyText2,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      MyTextField(
                        hintText: 'Email',
                        inputType: TextInputType.text,
                        conn: loginController.emailController,
                      ),
                      MyPasswordField(
                        isPasswordVisible: isPasswordVisible,
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        conn: loginController.passwordController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextButton(
                    buttonName: 'Sign In',
                    onTap: () {
                      loginController.loginWithEmail();
                      
                    },
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont't have an account? ",
                        style: tBodyText,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const RegisterPage());
                        },
                        child: Text(
                          "Register",
                          style: tBodyText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
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
