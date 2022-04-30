import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/cubit.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/models/usermodel.dart';
import 'package:twasl/share/componant/componant.dart';

import '../../share/style/color.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChatCubit,ChatStates>(
      builder: (context,state){
        return Scaffold(
          backgroundColor: color1,
          appBar: buildAppBar(
              context,
              title: 'Edit Profile',
              actions: [
                IconButton(onPressed: (){
                  ChatCubit.get(context).getUpdateData(name: nameController.text, phone: phoneController.text);
                }, icon: const Icon(Icons.save))
              ]
          ),
          body: buildContainer(context,
              child: BlocConsumer<ChatCubit, ChatStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var userModel = ChatCubit.get(context).userModel;
                  var imageProfile = ChatCubit.get(context).profileImage;
                  nameController.text =userModel!.name;
                  phoneController.text =userModel.phone;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                    child: Column(
                      children: [
                        buildProfile(
                            context, ChatCubit.get(context).userModel, imageProfile),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if (value.isEmpty) {
                                return 'Please Write Name';
                              }
                            },
                            label: 'name',
                            prefix: Icons.person),
                        const SizedBox(height: 20,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if (value.isEmpty) {
                                return 'Please Write phone';
                              }
                            },
                            label: 'phone',
                            prefix: Icons.phone),
                         SizedBox(height: MediaQuery.of(context).size.height *0.05),
                        if(ChatCubit.get(context).profileImage !=null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultButton(function: (){
                                ChatCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text);
                              }, text: 'Update Image',width: 250)
                            ],
                          )
                      ],
                    ),

                  );
                },
              )),
        );
      },
    );
  }

  Widget buildProfile(
      BuildContext context, ChatUserModel? model, File? profileImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: profileImage == null
                ? NetworkImage(model!.image)
                : FileImage(profileImage) as ImageProvider,
          ),
          CircleAvatar(
              backgroundColor: color4,
              child: IconButton(
                  onPressed: () {
                    ChatCubit.get(context).getProfileImage();
                  },
                  icon: const Icon(Icons.camera_alt)))
        ]),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),

      ],
    );
  }
}
