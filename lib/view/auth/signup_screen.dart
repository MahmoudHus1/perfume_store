
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/view/auth/signin_screen.dart';
import 'package:provider/provider.dart';

import '../../app_router/app_router.dart';
import '../../component/app_text_field.dart';
import '../../component/custom_button.dart';
import '../../core/constant/colors.dart';
import '../../providers/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  var signUpImages = ['assets/images/f.png', 'assets/images/g.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context,provider,w) {
          return Form(
            key: provider.signUpKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                 Container(
                  height: 200,
                  child: const Center(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/images/logo2.webp'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 AppTextField(hintText: 'Email', icon: Icons.email, validation: provider.emailValidation,controller: provider.registerEmailController, textInputType: TextInputType.emailAddress,),
                const SizedBox(
                  height: 20,
                ),
                 AppTextField(hintText: 'Passowrd', icon: Icons.password_sharp, validation: provider.passwordValidation,controller: provider.passwordRegisterController, isPassword: true),
                const SizedBox(
                  height: 20,
                ),
                 AppTextField(hintText: 'Name', icon: Icons.person, validation: provider.requiredValidation, controller: provider.userNameController,),
                const SizedBox(
                  height: 20,
                ),
                 AppTextField(hintText: 'Phone', icon: Icons.phone, validation: provider.phoneValidation, controller: provider.phoneController, textInputType: TextInputType.phone,),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(text: "Sign Up", function: provider.signUp),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => AppRouter.appRouter.goToWidgetAndReplace(SignInScreen()),
                          text: 'Have an account already?',
                          style: const TextStyle(
                              color: AppColors.secondColor, fontSize: 16))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: RichText(
                      text: const TextSpan(
                          text: 'Sign up using one of the following methods',
                          style: TextStyle(
                              color: AppColors.secondColor, fontSize: 16))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Wrap(
                      children: List.generate(
                          2,
                          (index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  backgroundImage: AssetImage(signUpImages[index]),
                                ),
                              ))),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
