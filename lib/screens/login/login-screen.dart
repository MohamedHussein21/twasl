import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/screens/login/cubit/statas.dart';
import 'package:twasl/screens/register/register.dart';
import 'package:twasl/share/componant/componant.dart';
import 'package:twasl/share/network/local/cachhelper.dart';
import 'package:twasl/share/style/color.dart';

import '../home/home.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context)=>ChatLoginCubit(),
      child: BlocConsumer<ChatLoginCubit,ChatLoginStates>(
        listener: (context, state) {
          if(state is ChatLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is ChatLoginSuccessState) {
            CachHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: color4,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/logo.png'),
                        Text(
                          'Login To Connect With Your Friend',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: color2),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          label: 'Username',
                          prefix: Icons.account_circle,
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: ( value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: ChatLoginCubit.get(context).suffix,
                            isPassword:
                            ChatLoginCubit.get(context).isShowPass,
                            suffixPressed: () {
                              ChatLoginCubit.get(context)
                                  .changePassVisibility();
                            }),
                        const SizedBox(height: 20,),
                        BuildCondition(
                            condition: state is! ChatLoginLoadingState,
                            builder: (context) {
                              return defaultButton(function: (){
                                if(formKey.currentState!.validate()){
                                  ChatLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }
                              }, text: 'Login',background: color2) ;
                            },
                            fallback: (context) {
                              return  const Center(child:  CircularProgressIndicator());
                            }
                        ),

                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an account?",
                              style: TextStyle(color: color2),
                            ),
                            defaultTextButton(function: (){
                              navigateTo(context, RegisterScreen());
                            }, text: "Register")

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
    },

        ),


    );
  }
}
