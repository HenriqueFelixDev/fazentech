import 'package:fazentech/app/modules/home/components/home_banner_widget.dart';
import 'package:fazentech/app/modules/home/components/product_home_section.dart';
import 'package:fazentech/app/shared/components/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: Text('FazenTech', style: TextStyle(color: Colors.black))
      ),
      drawer: Drawer(
        child: Container()
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          children: [
            HomeBannerWidget(),
            SizedBox(height: 16.0),
            ProductHomeSection(),
            ProductHomeSection(),
            ProductHomeSection(),
          ],
        )
      )
    );
  }
}