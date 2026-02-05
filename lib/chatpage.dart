import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  String? name;
  Chatpage({super.key, this.name});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  void sendmessage() {
    FirebaseFirestore.instance.collection("messages").add({
      "message": msgCtr.text,
      "sender": widget.name,
    });
  }

  var msgCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10,
          children: [
            CircleAvatar(),
            Text(widget.name!, style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("messages")
                .snapshots(),
            builder: (context, asyncSnapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: asyncSnapshot.data!.docs.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment:
                        asyncSnapshot.data!.docs[index]["sender"] == widget.name
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              asyncSnapshot.data!.docs[index]["sender"] ==
                                  widget.name
                              ? const Color.fromARGB(255, 224, 232, 215)
                              : const Color.fromARGB(255, 177, 193, 236),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                asyncSnapshot.data!.docs[index]["sender"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(asyncSnapshot.data!.docs[index]["message"]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendmessage();
                  },
                  icon: Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
