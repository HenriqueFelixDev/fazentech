import 'package:fazentech/app/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends AppBar {
  final String titleText;
  final Widget titleWidget;
  final List<Widget> actions;

  CustomAppBarWidget({
    this.titleText,
    this.titleWidget,
    this.actions
  }) : super(
    title: titleWidget ?? Text(titleText ?? '', style: TextStylesSet.appBarTitleStyle),
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.transparent
  );

}