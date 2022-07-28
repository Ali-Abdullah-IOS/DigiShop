import 'package:digirental_shop_app/Infrastructure/Models/user_model.dart';
import 'package:digirental_shop_app/presentation/Screens/ChatSection/user.dart';
import 'package:digirental_shop_app/presentation/Screens/ChatSection/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'app_bar.dart';
import 'chat.dart';
import 'chat_tile.dart';
import 'farmer.dart';
import 'message.dart';
import 'message_details.dart';
import 'messages.dart';

class RecentChatList extends StatefulWidget {
  const RecentChatList(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  _RecentChatListState createState() => _RecentChatListState();
}

class _RecentChatListState extends State<RecentChatList> {
  ChatServices _chatServices = ChatServices();
  bool initialized = false;
  UserModel userModel = UserModel();
  ExpertServices _userServices = ExpertServices();
  FarmerServices _farmerServices = FarmerServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    print(user.getUserDetails());
    return Scaffold(
      body: _buildUI(context, user.getUserDetails()!),
    );
  }

  Widget _buildUI(BuildContext context, UserModel _userModel) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: customAppBar(text: 'Recent Chats', showSearch: false),
      body: _getUI(context, _userModel),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _chatServices.addNewMessage(
      //         receiverID: user.getUserDetails()!.docId.toString(),
      //         myID: '6pRq2nB7DtQyXSlR6jnRIofq7jn2',
      //         detailsModel: ChatDetailsModel(
      //           recentMessage: 'Hi',
      //           date: DateFormat('MM/dd/yyyy').format(Timestamp.now().toDate()),
      //           time: DateFormat('hh:mm a').format(Timestamp.now().toDate()),
      //         ),
      //         messageModel: MessagesModel(
      //             isRead: false,
      //             time: DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now()),
      //             messageBody: 'Hi'));
      //   },
      // ),
    );
  }

  Widget _getUI(BuildContext context, UserModel _model) {
    var user = Provider.of<UserProvider>(context);

    return Column(
      children: [
        Divider(),
        Expanded(
          child: StreamProvider.value(
            value: _chatServices.streamChatList(myID: _model.docId.toString()),
            initialData: [ChatDetailsModel()],
            builder: (context, child) {
              List<ChatDetailsModel> chatDetailsList =
                  context.watch<List<ChatDetailsModel>>();
              print("User ID" + user.getUserDetails()!.userID.toString());
              return chatDetailsList.isEmpty
                  ? Text("No Data Found")
                  : chatDetailsList[0].myID == null
                      ? Container(
                          height: MediaQuery.of(context).size.height - 150,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [CircularProgressIndicator()],
                          ),
                        )
                      : chatDetailsList.length != 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: chatDetailsList.length,
                              itemBuilder: (context, i) {
                                return StreamProvider.value(
                                  value: _chatServices.getUnreadMessageCounter(
                                      myID: user
                                          .getUserDetails()!
                                          .docId
                                          .toString(),
                                      receiverID: chatDetailsList[i]
                                          .otherID
                                          .toString()),
                                  initialData: [MessagesModel()],
                                  builder: (unReadContext, child) {
                                    List<MessagesModel> unReadMessagesList =
                                        unReadContext
                                            .watch<List<MessagesModel>>();
                                    return StreamProvider.value(
                                      value: _farmerServices.getUserDetails(
                                          chatDetailsList[i]
                                              .otherID
                                              .toString()),
                                      initialData: UserModel(),
                                      builder: (userContext, child) {
                                        UserModel chatUserModel =
                                            userContext.watch<UserModel>();
                                        return chatUserModel.userID == null
                                            ? CircularProgressIndicator()
                                            : InkWell(
                                                onTap: () {
                                                  ChatDetailsModel _model =
                                                      chatDetailsList[i];
                                                  setState(() {});
                                                  // return;
                                                  pushNewScreen(context,
                                                      screen: MessagesView(
                                                        receiverID: _model
                                                            .otherID
                                                            .toString(),
                                                        name: chatUserModel
                                                            .fullName
                                                            .toString(),
                                                        myID: user
                                                            .getUserDetails()!
                                                            .docId
                                                            .toString(),
                                                      ),
                                                      withNavBar: false);
                                                },
                                                child: ChatTile(
                                                  image: chatUserModel.userImage
                                                      .toString(),
                                                  title: chatUserModel.fullName
                                                      .toString(),
                                                  description:
                                                      chatDetailsList[i]
                                                              .recentMessage ??
                                                          "",
                                                  time: chatDetailsList[i]
                                                      .time
                                                      .toString(),
                                                  counter: unReadMessagesList
                                                              .length ==
                                                          1
                                                      ? unReadMessagesList[0]
                                                                  .docID ==
                                                              null
                                                          ? 0
                                                          : unReadMessagesList
                                                              .length
                                                      : unReadMessagesList
                                                          .length,
                                                ),
                                              );
                                      },
                                    );
                                  },
                                );
                              })
                          : Text("No Data Found");
            },
          ),
        )
      ],
    );
  }
}
