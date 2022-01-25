import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fretapp/utility/Note.dart';

class CircleController {
  late void Function(dynamic, dynamic) resize;
  late void Function() reset;
  late void Function(Note) setNote;
}

class AnimCircle extends StatefulWidget {
  final CircleController circleController;
  static const milis = 375;

  AnimCircle({required this.circleController});

  @override
  _AnimCircleState createState() => _AnimCircleState(circleController);
}


class _AnimCircleState extends State<AnimCircle> {

  _AnimCircleState(CircleController _controller){
    _controller.resize = resize;
    _controller.reset = reset;
    _controller.setNote = setNote;
  }

  bool active = false;
  double _width = 10;
  double _height = 10;
  Note currentNote = Note.NULL;

  Color _color = Colors.red.withOpacity(0);

  void resize(px, color){
    print('change');
    print('${_width} ${_height}');

    setState(() {
      if(!active){
        setState(() {
          active = true;
        });
      }

      setState(() {
        _width = px;
        _height = px;
        _color = color;
      });

    });
  }

  void reset(){
    setState(() {
      _width = 10;
      _height = 10;
    });

    if(active) {
      setState(() {
        _color = Colors.red.withOpacity(0);
        active = false;
      });
    }
  }

  void setNote(Note note){
    setState(() {
      currentNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Center(
        child: AnimatedContainer(
          curve: Curves.easeOutQuart,
          duration: const Duration(milliseconds:AnimCircle.milis),
          width: _width,
          height: _height,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _color),
        ),
      ),
        Center(child: Text('$currentNote', style: TextStyle(fontSize: 40, color: Colors.white),)),
      ]
    );
  }
}
