
abstract class ChatRigsterStates {}

class ChatRegisterInitialState extends ChatRigsterStates {}

class ChatRegisterLoadingState extends ChatRigsterStates {}

class ChatRegisterSuccessState extends ChatRigsterStates {}

class ChatRegisterErrorState extends ChatRigsterStates {
  final String error;

  ChatRegisterErrorState(this.error);

}
class ChatCreateUserSuccessState extends ChatRigsterStates {}

class ChatCreateUserErrorState extends ChatRigsterStates {
  final String error;

  ChatCreateUserErrorState(this.error);
}


class ChatRegisterChangePassIconState extends ChatRigsterStates {}
