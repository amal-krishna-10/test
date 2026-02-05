import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Newchatpage extends StatelessWidget {
  String? name;

  Newchatpage({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    void sendmsg(String msg) async {
      await FirebaseFirestore.instance.collection("msg").add({
        "messages": msg,
        "sender": name,
      });
    }

    var msgctr = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          spacing: 10,
          children: [
            CircleAvatar(),
            Text(name!, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("msg").snapshots(),
        builder: (context, asyncSnapshot) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: asyncSnapshot.data!.docs.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment:
                        asyncSnapshot.data!.docs[index]["sender"] == name
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              asyncSnapshot.data!.docs[index]["sender"] == name
                              ? const Color.fromARGB(255, 232, 9, 139)
                              : const Color.fromARGB(255, 242, 243, 246),
                        ),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(10),

                        child: Text(
                          asyncSnapshot.data!.docs[index]["messages"],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgctr,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.pink,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.pink,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendmsg(msgctr.text);
                    },
                    icon: Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 45,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
