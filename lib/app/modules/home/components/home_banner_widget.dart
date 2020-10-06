import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/img/apples.jpg'),
          fit: BoxFit.cover
        )
      ),
      child: Text(
        'Produtos selecionados e da melhor qualidade',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      )
    );
  }
}