import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/screens/register/cubit/states.dart';

import '../../../models/usermodel.dart';
import '../../../share/componant/constant.dart';

class ChatRegisterCubit extends Cubit<ChatRigsterStates> {
  ChatRegisterCubit() : super(ChatRegisterInitialState());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
       createUser(name: name, email: email, phone: phone, uId: value.user!.uid,);
    }).catchError((error) {
      emit(ChatRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    ChatUserModel model = ChatUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: defaultImage,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(ChatCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatCreateUserErrorState(error.toString()));
    });
  }

  bool isShowPass = true;

  IconData suffix = Icons.visibility_outlined;

  void changePassVisibility() {
    isShowPass = !isShowPass;
    suffix =
        isShowPass ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChatRegisterChangePassIconState());
  }
}
