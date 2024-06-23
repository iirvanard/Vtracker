import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/core/utils/images_helper.dart';
import 'package:vtracker/core/utils/theme.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';
import 'package:vtracker/features/auth/presentation/bloc/login_bloc.dart';
import 'package:vtracker/router/app_route.dart';

class MultiLoginPage extends StatefulWidget {
  const MultiLoginPage({super.key});

  @override
  State<MultiLoginPage> createState() => _MultiLoginPageState();
}

class _MultiLoginPageState extends State<MultiLoginPage> {
  @override
  void initState() {
    super.initState();
    context.read<MultiLoginBloc>().add(AccountListEvent());
  }

  @override
  Widget build(BuildContext context) {
    showLoaderDialog(BuildContext contextBlocListener) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(
                margin: EdgeInsets.only(left: 7.w),
                child: const Text("Loading...")),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: contextBlocListener,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: alert,
          );
        },
      );
    }

    showLoaderDialogconfirm(BuildContext contextBlocListener) {
      contextBlocListener.pop();
      Widget continueButton = TextButton(
        child: const Text("Close"),
        onPressed: () => contextBlocListener.pop(),
      );

      AlertDialog alert = AlertDialog(
        title: const Text("Error While Login"),
        content: const Text(
            "There was an issue with authentication. Please verify your credentials."),
        actions: [
          continueButton,
        ],
      );
      showDialog(
        barrierDismissible: false,
        context: contextBlocListener,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: alert,
          );
        },
      );
    }
    // set up the buttons

    return Scaffold(
      backgroundColor: bgPrimaryDark,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (contextBlocListener, state) {
          if (state is LoginLoading) {
            showLoaderDialog(context);
          }
          if (state is LoginSuccess) {
            context.goNamed(Routes.HOME);
          }
          if (state is LoginError) {
            showLoaderDialogconfirm(context);
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Text(
                  'Choose your account ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20.sp,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Your can easly change different account',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: bgTextfieldDark,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
                      child: BlocBuilder<MultiLoginBloc, MultiLoginState>(
                          builder: (BuildContext contextBlocBuilder,
                              MultiLoginState state) {
                        if (state is GetAccountListState) {
                          return state.account.isEmpty
                              ? const Text("Empty")
                              : ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext contextBlocBuilder,
                                          int index) {
                                    return Divider(
                                      thickness: 1.h,
                                      color: blackColor,
                                    );
                                  },
                                  itemCount: state.account.length,
                                  itemBuilder: (contextBlocBuilder, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(LoginButtonPressed(
                                            username:
                                                state.account[index].username,
                                            password:
                                                state.account[index].password,
                                          ));
                                        },
                                        child: ItemLogin(
                                            item: state.account[index]));
                                  },
                                );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Container(
                      height: 74.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.0.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0
                                  .r) //                 <--- border radius here
                              ),
                          border: Border.all(
                            color: bgTextfieldDark,
                            width: 3.w,
                          )),
                      child: Center(
                        child: Text(
                          'Add A New Account',
                          style: TextStyle(color: textColor, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemLogin extends StatelessWidget {
  const ItemLogin({super.key, required this.item});
  final AccountLogin item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ImageWidget(),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${item.username}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontFamily: 'Exo',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    'AverageBudi #0x45',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
