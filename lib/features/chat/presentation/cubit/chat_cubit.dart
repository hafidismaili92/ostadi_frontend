import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ostadi_frontend/core/constants/websocket.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/core/services/websocket/ws_service.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';


part 'chat_state.dart';

const WS_URL = '$WS_BASE_URL/ws/chatroom';
class ChatCubit extends Cubit<ChatState> {
  final WebSocketService chatWSService;
  final String roomId;
  final TokenRepository tokenRepo;
  ChatCubit({required this.chatWSService,required this.roomId,required this.tokenRepo}) : super(ChatInitial()) ;
  

  void initWebSocketConnection(String chatroomID) async{
   
    try {
  //final token =  await tokenRepo.readToken();
  //2e7724befca611717cb4caa4ad22b84ad6c0adf7
  const token = 'b2910daa07550a052f2e651670ef97fae0ca04fe';
  if(token != null)
  {
    String wsUrl = '$WS_URL/$roomId?t=$token';
    await chatWSService.connect(wsUrl);
    //start listning to new messages
    chatWSService.messages.listen((message) {
       print(message);
      if(state is ChatMessagesUpdate)
      {
        final currentState = state as ChatMessagesUpdate;
        List<String> updatedMessages = [...currentState.messages,message];
        emit(ChatMessagesUpdate(messages: updatedMessages));


      }
      else{
        emit(ChatMessagesUpdate(messages: [message]));
      }
    });
  }
  else
  {
    emit(ChatMessagesUpdate(messages: ["error"]));
  }
  
  
} on Exception catch (e) {
 
 emit(ChatMessagesUpdate(messages: ["exception"]));
}
  }

void sendMessage(message)
{
  chatWSService.sendMessage(message);
}
}


