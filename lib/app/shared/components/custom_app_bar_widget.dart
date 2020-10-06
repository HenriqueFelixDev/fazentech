import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends AppBar {
  final Widget title;
  final List<Widget> actions;

  CustomAppBarWidget({
    this.title,
    this.actions
  }) : super(
    title: title,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.transparent
  );

}