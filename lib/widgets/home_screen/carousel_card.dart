//Flutter Packages
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final double height;
  final String number;
  final String description;

  CarouselCard(this.description, this.number, this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        elevation: 10.0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tip #$number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'KleeOne',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  '$description',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'KleeOne',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
