import 'package:flutter/material.dart';

class ButtonGreen extends StatefulWidget {
  final String text;
  double width;
  double height;
  final VoidCallback onPressed;

  ButtonGreen( {Key key, @required this.text, @required this.onPressed, this.width, this.height} );


  @override
  _ButtonGreenState createState() => _ButtonGreenState();
}

class _ButtonGreenState extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20
        ),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Color(0xFFa7ff84),// la punta de arriba a la derecha
              Color(0xFF1cbb78)// la punta de abajo contraria
            ],
            begin: FractionalOffset(0.2,0.0),
            end: FractionalOffset(1.0,0.6),
            stops: [0.0 , 0.6],
            tileMode: TileMode.clamp
          )
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Lato",
              color: Colors.white
            ),
          ),
        ),
        ),
    );
  }
}