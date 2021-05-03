import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hint;
  final Function validator;
  final Function saved;

  const Input({
    Key key,
    this.hint,
    this.validator, this.saved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[900]),
        ),
        validator: validator,
        onSaved: saved,
      ),
    );
  }
}
