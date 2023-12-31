import 'package:auth_restfull/controllers/registeration_controller.dart';
import 'package:auth_restfull/core/constants/constants.dart';
import 'package:auth_restfull/views/auth/screens/signin_page.dart';
import 'package:auth_restfull/views/auth/widgets/my_password_field.dart';
import 'package:auth_restfull/views/auth/widgets/my_text_button.dart';
import 'package:auth_restfull/views/auth/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
  bool passwordVisibility = true;
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Register",
                        style: tHeadline,
                      ),
                      const Text(
                        "Create new account to get started.",
                        style: tBodyText2,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MyTextField(
                        hintText: 'Name',
                        inputType: TextInputType.name,
                        conn: registrationController.nameController,
                      ),
                      MyTextField(
                        hintText: 'Email',
                        inputType: TextInputType.emailAddress,
                        conn: registrationController.emailController,
                      ),
                      MyPasswordField(
                        isPasswordVisible: passwordVisibility,
                        onTap: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                        conn: registrationController.passwordController,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextButton(
                    buttonName: 'Register',
                    onTap: () {},
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
                        "Already have an account? ",
                        style: tBodyText,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const SignInPage());
                        },
                        child: Text(
                          "Sign In",
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
