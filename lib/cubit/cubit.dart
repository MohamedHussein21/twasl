import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/models/message_model.dart';
import 'package:twasl/models/usermodel.dart';

import '../share/componant/constant.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatStates());

  static ChatCubit get(context) => BlocProvider.of(context);

  ChatUserModel? userModel;

  void getUserData() {
    emit(InitialChatStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = ChatUserModel.fromjson(value.data());

      print(userModel?.name);
      emit(GetUserSuccessChatStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorChatStates(error.toString()));
    });
  }

  List<ChatUserModel> users = [];

  void getAllUser() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel?.uId) {
          users.add(ChatUserModel.fromjson(element.data()));
        }
        emit(GetAllUserSuccessChatStates());
        // print(element.data());
      }
    }).catchError((error) {
      emit(GetAllUserErrorChatStates(error.toString()));
      print(error.toString());
    });
  }

  bool isSwitched = false;

  void changeSwitch(value) {
    isSwitched = value;
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessChatStates());
      print(profileImage);
    } else {
      print('Image Faild');
      emit(PickProfileImageErrorChatStates());
    }
  }

  String profileUrl = '';

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        getUpdateData(name: name, phone: phone, image: value);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  void getUpdateData({
    required String name,
    required String phone,
    String? image,
  }) {
    ChatUserModel model = ChatUserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {});
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    //sender Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageStates());
    }).catchError((error) {
      emit(ErrorSendMessageStates());
    });
//receiver Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageStates());
    }).catchError((error) {
      emit(ErrorSendMessageStates());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromjson(element.data()));
      });
      emit(GetSuccessMessageStates());
    });
  }

  void openChat(){
    emit(OpenChatMessageStates());
  }
}
