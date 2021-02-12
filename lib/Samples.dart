import 'package:flutter/material.dart';
import 'package:flutterlearn/Doctors.dart';
class Samples extends StatelessWidget {
  static const routeName = '/extractArguments';
  final Doctors doctors;
  Samples( {Key key, @required this.doctors,} ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${doctors.name}"),);
  }
}
