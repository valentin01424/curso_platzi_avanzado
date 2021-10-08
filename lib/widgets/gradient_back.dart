import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {


  String title = "Popular";
  double altura = 0.0;

  GradientBack({Key key,this.altura});// altura = null es full screen

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double screenAltura = MediaQuery.of(context).size.height;
    double screenAncho =  MediaQuery.of(context).size.width;
    if (altura == null ) {
      altura = screenAltura;
    }

    return Container(
      width: screenAncho,
      height: altura,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF4268D3),
              Color(0xFF584CD1)
            ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
        )
      ),


      child: FittedBox(
        fit: BoxFit.none,
        alignment: Alignment(-1.5,-0.8),
        child: Container(
          width: screenAltura,
          height: screenAltura,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.05), 
                  borderRadius: BorderRadius.circular(screenAltura / 2)
          ),
        ),
      ),
      
       /*Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold
        ),
      ),*/

      //alignment: Alignment(-0.9, -0.6),

    );
  }

}