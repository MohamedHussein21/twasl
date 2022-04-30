
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/screens/login/cubit/statas.dart';

class ChatLoginCubit extends Cubit<ChatLoginStates> {

  ChatLoginCubit() : super(ChatLoginInitialState());

  static ChatLoginCubit get(context) => BlocProvider.of(context);


  void userLogin ({
    required String email,
    required String password,
  }){
    emit(ChatLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
    emit(ChatLoginSuccessState(value.user!.uid));
  }).catchError((error){
    print(error.toString());
    emit(ChatLoginErrorState(error.toString()));
  });
  }

  bool isShowPass =true ;

  IconData suffix =Icons.visibility_outlined ;

  void changePassVisibility (){
    isShowPass =!isShowPass;
    suffix = isShowPass? Icons.visibility_off_outlined:Icons.visibility_outlined ;
    emit(ChatChangePassIconState());
  }

}
