import '../models/usermodel.dart';

abstract class ChatStates {}

class InitialChatStates extends ChatStates {}

class LoadingChatStates extends ChatStates {}

class GetUserSuccessChatStates extends ChatStates {
 final ChatUserModel userModel;
  GetUserSuccessChatStates(this.userModel);
}

class GetUserErrorChatStates extends ChatStates {

  final String error;

  GetUserErrorChatStates(this.error);
}

class SocialChangeBottomNav extends ChatStates{}

class LoadingGetAllUserChatStates extends ChatStates {}

class GetAllUserSuccessChatStates extends ChatStates {}

class GetAllUserErrorChatStates extends ChatStates {

  final String error;

  GetAllUserErrorChatStates(this.error);
}

class ChangeToSettingsChatStates extends ChatStates {
  final ChatUserModel userModel;
  ChangeToSettingsChatStates(this.userModel);
}

class ChangeToProfileChatStates extends ChatStates {
  final ChatUserModel userModel;
  ChangeToProfileChatStates(this.userModel);
}

class PickProfileImageSuccessChatStates extends ChatStates {}

class PickProfileImageErrorChatStates extends ChatStates {}

class SuccessSendMessageStates extends ChatStates {}

class ErrorSendMessageStates extends ChatStates {}

class GetSuccessMessageStates extends ChatStates {}

class GetErrorMessageStates extends ChatStates {}

class OpenChatMessageStates extends ChatStates {}