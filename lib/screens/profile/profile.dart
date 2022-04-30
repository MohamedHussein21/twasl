import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/cubit.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/models/usermodel.dart';
import 'package:twasl/screens/profile/editProfile.dart';
import 'package:twasl/share/componant/componant.dart';

import '../../share/style/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: buildAppBar(context, title: 'Profile',actions: [ Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextButton(onPressed: (){
          navigateTo(context, EditProfileScreen());
        },child:  const Text('Edit',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 16),),),
      )]),
      body: buildContainer(context,
          child: BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var imageProfile = ChatCubit.get(context).profileImage;
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: buildProfile(context, ChatCubit.get(context).userModel, imageProfile),
                );

            },
          )),
    );
  }

  Widget buildProfile (BuildContext context , ChatUserModel? model,File? profileImage ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: profileImage ==null ? NetworkImage(model!.image) : FileImage(profileImage) as ImageProvider,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        buildProfileInfo(
          context,
          text: ': الاسم',
          info: model!.name,
          iconLeading:  Icon(
            Icons.person,
            color: color2,
          ),),

        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        const Divider(
          color: Colors.black,
        ),
        buildProfileInfo(
          context,
          text: ': الايميل',
          info: model.email,
          iconLeading: IconButton(onPressed: (){}, icon: Icon(
            Icons.email,
            color: color2,
          ),)
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        const Divider(),
        buildProfileInfo(
          context,
          text: ': الرقم',
          info: model.phone,
          iconLeading: IconButton(onPressed: (){}, icon: Icon(
            Icons.phone,
            color: color2,
          ),)
        ),
      ],
    );
  }
}
