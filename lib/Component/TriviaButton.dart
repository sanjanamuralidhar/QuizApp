import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  final double width;
  final String text;
  final IconData icon;
  final Function onPressed;
  const TriviaButton({this.width, this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FlatButton(
          // minWidth: 100,
          color: Colors.yellow[700],
          onPressed: onPressed,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text.toUpperCase(),
                      style: TextStyle(color: Colors.blue[700])),
                ),
              ),
              SizedBox(width: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(icon),
                  ))
            ],
          )),
    );
  }
}
