import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/screens/profile/profile.dart';

import '../../cubit/cubit.dart';
import '../../models/usermodel.dart';
import '../../share/componant/componant.dart';
import '../../share/style/color.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: buildAppBar(context, title: 'Setting'),
      body: Column(
        children: [
          Expanded(
            child: buildContainer(
              context,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    InkWell(onTap: () {
                      navigateTo(context, const ProfileScreen());
                    }, child: BlocBuilder<ChatCubit, ChatStates>(
                        builder: (context, state) {
                      return buildRowInfo(context,ChatCubit.get(context).userModel) ;
                    })),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRowInfo (BuildContext context, ChatUserModel? model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.edit)),
        SizedBox(
          width: MediaQuery.of(context).size.width/30,
        ),
        Text(
          model!.name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/15,
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            model.image,
          ),
        ),
      ],
    ) ;
  }
}
