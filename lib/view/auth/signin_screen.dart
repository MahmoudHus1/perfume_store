import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/component/custom_button.dart';
import 'package:perfume_store/view/auth/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../app_router/app_router.dart';
import '../../component/app_text_field.dart';
import '../../component/custom_text.dart';
import '../../core/constant/colors.dart';
import '../../providers/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, provider, w) {
        return Form(
          key: provider.signInKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 200,
                child: Center(
                  child: CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage('assets/images/logo2.webp'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: 'Hello',
                      color: AppColors.secondColor,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: 'Sign into your account.',
                      color: AppColors.secondColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                hintText: 'Email',
                icon: Icons.email,
                validation: provider.emailValidation,
                controller: provider.loginEmailController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hintText: 'Passowrd',
                icon: Icons.password_sharp,
                validation: provider.passwordValidation,
                controller: provider.passwordLoginController,
                isPassword: true,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  RichText(
                      text: const TextSpan(
                          text: 'Sign into your account',
                          style: TextStyle(
                              color: AppColors.secondColor, fontSize: 16))),
                ]),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButton(text: "Sign In", function: provider.signIn),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Don't have an account?",
                        style: const TextStyle(
                            color: AppColors.secondColor, fontSize: 16),
                        children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => AppRouter.appRouter
                              .goToWidgetAndReplace(SignUpScreen()),
                        text: " Create",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ])),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }),
    );
  }
}
