import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {

  final Function onPress ; 
  final String text ;
  final Color color ;
  const ReusableButton({
    Key key,
    this.color,
    @required this.onPress,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: this.onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.text,
            style: TextStyle(
              color : Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
