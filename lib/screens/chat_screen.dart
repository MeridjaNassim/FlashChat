import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utils/dateutil.dart';
class ChatScreen extends StatefulWidget {
  static final String ROUTE_ID = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  bool _loading = true ;
  FirebaseUser loggedInUser ;
  String _messageText  ;
  @override
  void initState() {
    super.initState();
    init();
  }
  void init() async{
    try {
      final user =  await _auth.currentUser();
      if(user!= null) {
      loggedInUser = user ;
      setState(() {
        _loading = false ; 
      });
      }

    }catch(e) {
      print(e);
    }
  }
  
  // void getMessages()async {
  //   final messages = await _firestore.collection('messages').getDocuments();
  //   for (var item in messages.documents) {
  //     var data = item.data;
  //     print('sender is ${data['sender']}');
  //     print('text is ${data['text']}');
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _loading,
        child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async  {
                  
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
          title: Text('⚡️Chat'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context,snapshot){

                  if(!snapshot.hasData){
                    return Center(
                      child : CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      )
                    );
                   }
                    var messages = snapshot.data.documents;
                    messages.sort((doc1,doc2){
                     return doc1.data['createdAt'].compareTo(doc2.data['createdAt']);
                    });
                    messages = messages.reversed.toList();
                    List<MessageBubble> messageBubbles =[];
                    for (var message in messages){
                        var email = message.data['sender'];
                        messageBubbles.add(
                          MessageBubble(
                            
                              message: message.data['text'],
                              sender: email,
                              isUser: loggedInUser.email == email,
                              time: message.data['createdAt'],
                            )
                        );
                           
                    }
                    return Expanded(
                        child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(vertical : 20 , horizontal : 10),
                        children : messageBubbles
                      ),
                    );
                 
                }
                ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          _messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text' : _messageText,
                          'sender' : loggedInUser.email,
                          'createdAt': DateTime.now()
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  const MessageBubble({Key key , this.message,this.sender,@required this.isUser,this.time}) : super(key: key);
  final String sender ; 
  final String message ;
  final bool isUser ;
  final Timestamp time ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom : 20),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 8),
            child: Text(isUser ? 'me' : sender,style: TextStyle(
              fontSize : 10,
              color : Colors.grey
            ),),
          ),
          Padding(
        padding: EdgeInsets.fromLTRB( isUser ? 16 : 0,4, isUser ? 0 : 16,8),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.only(
            topLeft : isUser ? Radius.circular(30) : Radius.circular(5),
            topRight : isUser ? Radius.circular(0) : Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)
          ),
          shadowColor: isUser ? Colors.black.withAlpha(100):Colors.lightBlueAccent.withAlpha(100) ,
          color: isUser ? Colors.white : Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(message,softWrap: true,
            style: TextStyle(
              color :isUser ? Colors.grey : Colors.white,
              fontSize: 15
            )
            ,),
          ),
        ),
        ),
         Padding(
            padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 8),
            child: Text(getTimeFormated(time),style: TextStyle(
              fontSize : 10,
              color : Colors.grey
            ),),
          ),
        ],
      ),
    );
  }
  
}