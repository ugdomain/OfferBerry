import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hundredminute_seller/view/screens/chat/widget/message_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/model/body/MessageBody.dart';
import '../../../data/model/response/chat_model.dart';
import '../../../provider/chat_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  final Customer? customer;
  final int? customerIndex;
  final List<MessageModel>? messages;
  ChatScreen({@required this.customer, @required this.customerIndex, @required this.messages});

  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ChatProvider>(builder: (context, chat, child) {
        return Column(children: [

          CustomAppBar(title: '${customer!.fName} ${customer!.lName}'),

          // Chats
          Expanded(child: chat.chatList != null ? messages!.isNotEmpty ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            itemCount: messages!.length,
            reverse: true,
            itemBuilder: (context, index) {
              List<MessageModel> chats = messages!.reversed.toList();
              return MessageBubble(chat: chats[index], customerImage: customer!.image);
            },
          ) : const SizedBox.shrink() : ChatShimmer()),

          // Bottom TextField
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 70,
                child: Card(
                  color: Theme.of(context).accentColor,
                  shadowColor: Colors.grey[200],
                  elevation: 2,
                  margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: titilliumRegular,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
                            border: InputBorder.none,
                          ),
                          onChanged: (String newText) {
                            if(newText.isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                            }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                            }
                          },
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive){
                            MessageBody messageBody = MessageBody(sellerId: customer!.id.toString(), message: _controller.text);
                            Provider.of<ChatProvider>(context, listen: false).sendMessage(messageBody, customerIndex!, context);
                            _controller.text = '';
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Provider.of<ChatProvider>(context).isSendButtonActive ? Theme.of(context).primaryColor : ColorResources.HINT_TEXT_COLOR,
                          size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),

            ],
          ),
        ]);
      }),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {

        bool isMe = index%2 == 0;
        return Shimmer.fromColors(
          baseColor: isMe ? Colors.grey[300]! : ColorResources.IMAGE_BG,
          highlightColor: isMe ? Colors.grey[100]! : ColorResources.IMAGE_BG.withOpacity(0.9),
          enabled: Provider.of<ChatProvider>(context).chatList == null,
          child: Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe ? const SizedBox.shrink() : const InkWell(child: CircleAvatar(child: Icon(Icons.person))),
              Expanded(
                child: Container(
                  margin: isMe ?  const EdgeInsets.fromLTRB(50, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 50, 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                        topRight: const Radius.circular(10),
                      ),
                      color: isMe ? ColorResources.IMAGE_BG : ColorResources.WHITE
                  ),
                  child: Container(height: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

