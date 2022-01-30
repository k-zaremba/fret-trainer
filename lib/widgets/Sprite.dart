import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fretapp/utility/Note.dart';

class SpriteController {
  late void Function(dynamic) resize;
  late void Function() reset;
  late void Function(Note) setNote;
}

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    //Color color = Color.fromRGBO(0, 117, 194, opacity);
    Color color = Color(0xFF01A02B).withOpacity(opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class SpriteAnimation extends StatefulWidget {
  final SpriteController spriteController;
  SpriteAnimation({required this.spriteController});


  @override
  SpriteAnimationState createState() => SpriteAnimationState(spriteController);
}

class SpriteAnimationState extends State<SpriteAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _width = 0;
  double _height = 0;
  Note currentNote = Note.NULL;
  int milis = 200;

  SpriteAnimationState(SpriteController _controller){
    _controller.resize = resize;
    _controller.reset = reset;
    _controller.setNote = setNote;
  }

  void resize(px){
    print('change');
    print('${_width} ${_height}');

    setState(() {
      _width = px;
      _height = px;
    });
  }

  void reset(){
    setState(() {
      _width = 0;
      _height = 0;
    });
  }

  void setNote(Note note){
    setState(() {
      currentNote = note;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [Center(
          child: CustomPaint(
            painter: SpritePainter(_controller),
            child: AnimatedContainer(
              duration: Duration(milliseconds: milis),
              width: _width,
              height: _height,
            ),
          ),
        ),
          Center(child: Text('$currentNote', style: TextStyle(fontSize: 40, color: Colors.white),)),
        ]
      );
  }
}

