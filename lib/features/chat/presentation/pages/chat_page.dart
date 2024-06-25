import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostadi_frontend/core/services/websocket/ws_service.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:ostadi_frontend/core/app_dependencies_injection.dart' as di;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> messages = [
  {'isMe': false, 'text': 'first messages goes here.'},
  {
    'isMe': true,
    'text': 'Sit quis elit commodo nilaborum qui consectetur nostrud. Non .'
  },
  {
    'isMe': true,
    'text':
        'Sit quis elit commodo nisi et voluptate eiusmod. Ut magna laborum qui consectetur nostrud. Non .'
  },
  {
    'isMe': false,
    'text':
        'Sit quis elit commodo nisi ett magna laborum qui consectetur nostrud. Non .'
  },
  {
    'isMe': false,
    'text':
        'Sit quis elit commodo nisi et voluptate eiusmod. Ut magna laborum qui consectetur nostrud. Non .'
  },
  {
    'isMe': false,
    'text':
        'Sit quis elit commodo nisi gna laborum qui consectetur nostrud. Non .'
  },
  {'isMe': true, 'text': 'last message goes here.'},
];

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  /*void initChatRoomConnection(String token) async
  {
    WebSocketService wsService = WebSocketService();
    WSRemoteDataSource wsRMDS = WSRemoteDataSource(wsService: wsService);
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    TokenRepository tokenRepo = TokenRepository(secureStorage: secureStorage);
    ChatRepository repo = ChatRepositoryImpl(tokenRepository: tokenRepo,wsDataSource: wsRMDS,tok:token);
    OpenChatroomUseCase useCase = OpenChatroomUseCase(chatRepository: repo);
    
    final result = await useCase.execute('test');
    
    result.fold((l) => isLoading=false, (r){isLoading=false;print('connection accepted');});
  }*/
  @override
  Widget build(BuildContext context) {
    WebSocketService wsService = WebSocketService();
    const String roomID = "test";
    return BlocProvider(
      create: (_) => ChatCubit(chatWSService: wsService, roomId: roomID, tokenRepo: di.sl<TokenRepository>())..initWebSocketConnection("test"),
      child: SafeArea(
          child: Scaffold(
        body: ChatPageBody(),
      )),
    );
  }


  
}

class ChatPageBody extends StatefulWidget {


  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  late ScrollController _scrollController;
  bool isLoading = true;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    //initChatRoomConnection();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void addNewMessage(String message, bool isMe) {
    BlocProvider.of<ChatCubit>(context).sendMessage(message);
    //always scrool list to bottom after build (after new message)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
     /* Timer(
          Duration(milliseconds: 300),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));*/
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(children: [
          Container(
            height: 120,
            child: Center(
                child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'hafid',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          Text('Ismaili',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary))
                        ],
                      )
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.videocam_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
              ],
            )),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.separated(
                            itemCount: 5,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemBuilder: (context, index) =>
                                ShimmerLoadingItem(),
                          ),
                        )
                      : BlocBuilder<ChatCubit, ChatState>(
                          builder: (context, state) {
                            if (state is ChatMessagesUpdate) {
                              final chatState = state as ChatMessagesUpdate;
                              return ListView.separated(
                                  controller: _scrollController,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount: chatState.messages.length,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      MessageWidget(
                                          message: chatState.messages[index] as String,
                                          isMe: true,
                                          avatarLink:
                                              // messages[index]['isMe'] as bool
                                              'https://picsum.photos/200'));
                            }
                            return Container();
                          },
                        ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewMessageWidget(onPressNewMessage: addNewMessage),
                ),
              ],
            ),
          )),
        ]),
      );
  }
}
class NewMessageWidget extends StatelessWidget {
  TextEditingController messageController = TextEditingController(text: '');
  final Function onPressNewMessage;

  NewMessageWidget({required this.onPressNewMessage});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: messageController,
              maxLines: 1,
              decoration: InputDecoration(border: InputBorder.none),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        )),
        SizedBox(
          width: 15,
        ),
        CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (!messageController.text.trim().isEmpty) {
                onPressNewMessage(messageController.text.trim(), true);
                messageController.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String message;
  final String avatarLink;
  final bool isMe;

  const MessageWidget(
      {required this.message, required this.avatarLink, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!avatarLink.isEmpty)
          CircleAvatar(
            backgroundImage: NetworkImage(avatarLink),
            backgroundColor: Colors.transparent,
          ),
        SizedBox(
          width: 10,
        ),
        Container(
          //to avoid horizontal over flow
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),

          decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).colorScheme.surfaceVariant
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        )
      ],
    );
  }
}

class ShimmerLoadingItem extends StatelessWidget {
  final _random = new Random();
  final lsIsme = [true, false];

  @override
  Widget build(BuildContext context) {
    bool isMe = lsIsme[_random.nextInt(lsIsme.length)];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade100,
          ),
        SizedBox(
          width: 10,
        ),
        Container(
          //30 is the min height
          height: 30 + Random().nextDouble() * 65,
          //to avoid horizontal over flow
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),

          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
        )
      ],
    );
  }
}
