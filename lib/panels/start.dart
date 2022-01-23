import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 550,
              ),
              SizedBox(
                width: 150,
                height: 100,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed((context), '/app');
                    },
                    child: Text('START',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 40 )
                    )
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
