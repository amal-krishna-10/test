import 'package:chatapp/newchatpage.dart';
import 'package:flutter/material.dart';

class Newloginpage extends StatefulWidget {
  const Newloginpage({super.key});

  @override
  State<Newloginpage> createState() => _NewloginpageState();
}

class _NewloginpageState extends State<Newloginpage> {
  var newnamectr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "LOGIN PAGE",
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: newnamectr,
                style: TextStyle(color: Colors.pink),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Newchatpage(name: newnamectr.text),
                ),
              );
            },
            child: Text("LOGIN"),
          ),
        ],
      ),
    );
  }
}
