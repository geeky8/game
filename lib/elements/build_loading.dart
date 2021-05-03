import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoading(){
  return Center(
    child: Column(
      children: [
        CircularProgressIndicator(),
      ],
    ),
  );
}