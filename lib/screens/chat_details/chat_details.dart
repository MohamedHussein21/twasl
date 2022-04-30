import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/cubit/cubit.dart';
import 'package:twasl/cubit/states.dart';
import 'package:twasl/models/message_model.dart';
import 'package:twasl/models/usermodel.dart';

import '../../share/style/color.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatUserModel userModel;

  ChatDetailsScreen(this.userModel, {Key? key}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getMessage(receiverId: userModel.uId);
      return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(userModel.image),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(userModel.name)
                ],
              ),
            ),
            body: BuildCondition(
              condition: true,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            var message = ChatCubit.get(context).messages[index];
                            if(ChatCubit.get(context).userModel!.uId== message.senderId){
                              return buildMyMessage(message);
                            }else {
                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context,index)=> const SizedBox(height: 5,),
                          itemCount: ChatCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 3),
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: 'Write here ....',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              ChatCubit.get(context).sendMessage(
                                  receiverId: userModel.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text);
                            },
                            child: Icon(
                              Icons.send,
                              color: color1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }

  Widget buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: color2.withOpacity(.7),
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Text( '${model.text}'),
      ),
    );
  }

  Widget buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: color1.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Text('${model.text}'),
      ),
    );
  }
}
