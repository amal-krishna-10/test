import 'package:flutter/material.dart';

class Imagelawout extends StatefulWidget {
  const Imagelawout({super.key});

  @override
  State<Imagelawout> createState() => _ImagelawoutState();
}

class _ImagelawoutState extends State<Imagelawout> {
  int count = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text("add container"),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              padding: EdgeInsets.all(50),
              itemCount: count + 1,
              itemBuilder: (context, index) => index == count
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      child: Text("add container"),
                    )
                  : Container(width: 60, height: 40, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
