import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lingoganda_news/constants/app_colors.dart';
import 'package:lingoganda_news/providers/auth_view_model.dart';
import 'package:lingoganda_news/providers/news_provider.dart';
import 'package:lingoganda_news/utils/routes/app_route_names.dart';
import 'package:lingoganda_news/widgets/common_app_button.dart';
import 'package:lingoganda_news/widgets/common_text_from_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailTextFieldController =
      TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();
  final _loginInFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondaryLight,
      body: SingleChildScrollView(
        child: Form(
          key: _loginInFormKey,
          child: Container(
            height: 1.sh,
            width: 1.sw,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.sp,
                      ),
                      Text(
                        'My News',
                        style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CommonTextFormField(
                        textFormFieldController: _emailTextFieldController,
                        labelName: 'Email',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        emptyMessage: 'Please enter your email',
                        validationMessage: 'Please enter a valid email',
                        textFieldValidateExpression: r'^[^@]+@[^@]+\.[^@]+'),
                    SizedBox(
                      height: 30.sp,
                    ),
                    CommonTextFormField(
                      textFormFieldController: _passwordTextFieldController,
                      labelName: 'Password',
                      prefixIcon: Icons.key,
                      keyboardType: TextInputType.name,
                      emptyMessage: 'Please enter your email',
                      validationMessage: 'Please enter a valid email',
                    ),
                  ],
                ),
                Column(
                  children: [
                    CommonAppButton(
                      buttonAction: () async {
                        if (_loginInFormKey.currentState!.validate()) {
                          await loginViewModel.login(
                            email: _emailTextFieldController.text.trim(),
                            password: _passwordTextFieldController.text.trim(),
                          );
                          if (loginViewModel.user.data != null) {
                            await NewsViewModel().fetchRemoteConfig();
                            await NewsViewModel().fetchUserDetails(
                              email: _emailTextFieldController.text.trim(),
                            );
                            context.goNamed(AppRouteNames.homeScreen);
                          }
                        }
                      },
                      buttonName: 'Login',
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.replaceNamed(AppRouteNames.signUpScreen),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("New here? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                )),
                            Text("SignUp",
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                )),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
