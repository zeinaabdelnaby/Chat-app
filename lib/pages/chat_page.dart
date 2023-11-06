// ignore_for_file: prefer_const_constructors

import 'package:chat/constants/constants.dart';
import 'package:chat/models/message.dart';
import 'package:chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  CollectionReference message =
      FirebaseFirestore.instance.collection(KMessagesColections);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    Text('Chat')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    // حطيت الليست فيو جوا اكسباندد علشان أعرف أرابها بالكولم
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email ? ChatBubble(
                            message: messagesList[index],
                          ): ChatBubbleForFreind(message: messagesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add({
                          KMessagesColections: data,
                          KCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            // _controller.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: kPrimaryColor))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('Loading....');
          }
        });
  }
}
