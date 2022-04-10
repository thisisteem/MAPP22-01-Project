import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';
import '../utils/constants/texts.dart';

class RunningResultCard extends StatefulWidget {
  final String bib;
  final double distance;
  final String date;
  final String status;
  const RunningResultCard({
    Key? key,
    required this.status,
    required this.bib,
    required this.distance,
    required this.date,
  }) : super(key: key);

  @override
  _RunningResultCardState createState() => _RunningResultCardState();
}

class _RunningResultCardState extends State<RunningResultCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            border: Border(
              right:
                  BorderSide(color: checkStatusColor(widget.status), width: 8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'BIB',
                    style: MyConstant.h3Style(colorGrey),
                  ),
                  Text(
                    widget.bib,
                    style: MyConstant.h3Style(colorSecondary),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ระยะทาง',
                    style: MyConstant.h3Style(colorGrey),
                  ),
                  Text(
                    '${widget.distance}',
                    style: MyConstant.h3Style(colorSecondary),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'วันที่',
                    style: MyConstant.h3Style(colorGrey),
                  ),
                  Text(
                    widget.date,
                    style: MyConstant.h3Style(colorSecondary),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Text(
                  widget.status,
                  style: MyConstant.h3Style(colorSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color checkStatusColor(String status) {
  if (status == statusApproved) {
    return colorGreen;
  } else if (status == statusChecking) {
    return colorYellow;
  } else if (status == statusDenied) {
    return colorRed;
  } else {
    return Colors.white;
  }
}
