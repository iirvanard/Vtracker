import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/features/auth/presentation/bloc/login_bloc.dart';
import 'package:vtracker/router/app_route.dart';
import 'package:vtracker/core/utils/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    bool isChecked = false;

    return Scaffold(
      backgroundColor: bgPrimaryDark,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            print("success");
            context.go('/sectionA');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 144.w,
                    height: 115.h,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: usernameController,
                          hintText: "Enter Username",
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "********",
                          obscureText: true,
                        ),
                        state is LoginError
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 5.w),
                                  child: Text(
                                    state.message,
                                    style: TextStyle(color: textColor),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 15.h,
                              ),
                        SizedBox(
                          height: 56.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonPressed(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      remember: isChecked));
                            },
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      side: BorderSide(color: bgButtonDark)),
                                ),
                                backgroundColor:
                                    WidgetStateProperty.all(bgButtonDark)),
                            child: state is LoginLoading
                                ? CircularProgressIndicator(
                                    color: textColor,
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: textColor, fontSize: 20.sp),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Custom_Checkbox(
                                  isChecked: isChecked,
                                  onChange: (bool value) async {
                                    isChecked = value;
                                  },
                                  backgroundColor: const Color(0xff1B2635),
                                  borderColor: const Color(0xff1B2635),
                                  icon: Icons.check,
                                  size: 30.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Remember Me ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                context.goNamed(Routes.MULTI_LOGIN);
                              },
                              child: Text(
                                'Choose Account',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller});
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.start,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: textColor, // Ubah warna teks di sini
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: bgTextfieldDark,
          hintText: hintText,
          hintStyle: TextStyle(
            decoration: TextDecoration.none,
            color: textColor,
            fontSize: 16.sp,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: bgTextfieldDark),
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: bgTextfieldDark),
            borderRadius: BorderRadius.circular(15.r),
          )),
    );
  }
}

class Custom_Checkbox extends StatefulWidget {
  final double? size, iconSize;
  final Function onChange;
  final Color? backgroundColor, borderColor, iconColor;
  final IconData? icon;
  final bool isChecked;

  const Custom_Checkbox({
    Key? key,
    this.size,
    this.iconSize,
    required this.onChange,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<Custom_Checkbox> createState() => _Custom_CheckboxState();
}

class _Custom_CheckboxState extends State<Custom_Checkbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChange(isChecked);
        });
      },
      child: AnimatedContainer(
          height: widget.size ?? 28,
          width: widget.size ?? 28,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xff1B2635),
              border: Border.all(
                  color: widget.borderColor ?? const Color(0xff1B2635))),
          child: isChecked
              ? Icon(
                  widget.icon ?? Icons.check,
                  color: widget.iconColor ?? Colors.white,
                  size: widget.iconSize ?? 25,
                )
              : null),
    );
  }
}
