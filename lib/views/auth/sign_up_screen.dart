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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController _emailTextFieldController =
      TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();
  final TextEditingController _userNameTextFieldController =
      TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondaryLight,
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.05.sh),
          child: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      textFormFieldController: _userNameTextFieldController,
                      labelName: 'Name',
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.emailAddress,
                      emptyMessage: 'Please enter your name',
                      validationMessage: 'Please enter a valid name',
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    CommonTextFormField(
                        textFormFieldController: _emailTextFieldController,
                        labelName: 'Email',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        emptyMessage: 'Please enter your email',
                        validationMessage: 'Please enter a valid email',
                        textFieldValidateExpression: r'^[^@]+@[^@]+\.[^@]+'),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    CommonTextFormField(
                      textFormFieldController: _passwordTextFieldController,
                      labelName: 'Password',
                      prefixIcon: Icons.key,
                      keyboardType: TextInputType.emailAddress,
                      emptyMessage: 'Please enter your email',
                      validationMessage: 'Please enter a valid Password',
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CommonAppButton(
                      buttonAction: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          await signUpViewModel.register(
                              email: _emailTextFieldController.text.trim(),
                              password:
                                  _passwordTextFieldController.text.trim(),
                              userName:
                                  _userNameTextFieldController.text.trim());
                          if (signUpViewModel.user.data != null) {
                            await NewsViewModel().fetchRemoteConfig();
                            await NewsViewModel().storeUserDetails(
                              email: _emailTextFieldController.text.trim(),
                              username:
                                  _userNameTextFieldController.text.trim(),
                            );
                            await NewsViewModel().fetchUserDetails(
                              email: _emailTextFieldController.text.trim(),
                            );
                            context.goNamed(AppRouteNames.homeScreen);
                          }
                        }
                      },
                      buttonName: 'Signup',
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed(AppRouteNames.loginInScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Already had an Account ? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              )),
                          Text("Sign In",
                              style: TextStyle(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              )),
                        ],
                      ),
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
