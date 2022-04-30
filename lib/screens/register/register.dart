import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/share/componant/componant.dart';
import 'package:twasl/share/style/color.dart';

import '../home/home.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRigsterStates>(
        listener: (context, state) {
          if(state is ChatRegisterErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is ChatCreateUserSuccessState){
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: color4,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Register To Connect With Your Friend',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: color2),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.account_circle,
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
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            isPassword: ChatRegisterCubit
                                .get(context)
                                .isShowPass,
                            suffix: ChatRegisterCubit
                                .get(context)
                                .suffix,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ChatRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixPressed: () {
                              ChatRegisterCubit.get(context)
                                  .changePassVisibility();
                            }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),

                        const SizedBox(height: 20,),
                        BuildCondition(
                            condition: state is! ChatRegisterLoadingState,
                            builder: (context) {
                              return defaultButton(function: () {
                                ChatRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }, text: 'Register', background: color2);
                            },
                            fallback: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                        ),

                        const SizedBox(height: 20,),

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
