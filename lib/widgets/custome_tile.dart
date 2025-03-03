import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  late double height, width;

  CustomTile({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(101, 99, 99, 0.25882352941176473),
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(99, 97, 97, 0.5450980392156862),
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  Transform.rotate(
                    angle: math.pi * 7 / 2,
                    child: FaIcon(FontAwesomeIcons.vial, size: 15),
                  ),
                  SizedBox(width: width * 0.03),

                  Text(
                    'N,P,K +2 More',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_outlined, size: 15),
        ],
      ),
    );
  }
}
