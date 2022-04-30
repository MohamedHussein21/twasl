import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/cubit.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/models/usermodel.dart';
import 'package:twasl/screens/login/login-screen.dart';
import 'package:twasl/screens/setting/settings.dart';
import 'package:twasl/share/componant/componant.dart';
import 'package:twasl/share/style/color.dart';

import '../chat_details/chat_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: color1,
          appBar: buildAppBar(
            context,
            title: 'Messages',
            leading: IconButton(
              onPressed: () {
                navigateTo(context, SettingsScreen());
              },
              icon: const Icon(Icons.list),
            ), actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    navigateTo(context, LoginScreen());
                  });
                },
                icon: const Icon(Icons.logout))
          ],
          ),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
          body: Column(
            children: [
              Expanded(
                child: buildContainer(context,
                    child: BlocConsumer<ChatCubit, ChatStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return BuildCondition(
                          condition: ChatCubit
                              .get(context)
                              .users
                              .isNotEmpty,
                          builder: (context) =>
                              ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildChatItems(
                                        context,
                                          ChatCubit
                                              .get(context)
                                              .users[index]),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  itemCount: ChatCubit
                                      .get(context)
                                      .users
                                      .length),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        );
                      },
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildChatItems(BuildContext context,ChatUserModel? model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model!));
          ChatCubit.get(context).openChat();
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                model!.image,
              ),
              radius: 24,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text('Hallo Mohamed'),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '3:55',
                ),
                const SizedBox(
                  height: 4,
                ),
                CircleAvatar(
                  radius: 10,
                  foregroundColor: color3,
                  child: const Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
