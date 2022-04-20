import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/models/checking_model.dart';

import '../screens/running_detail.dart';
import '../utils/constants/colors.dart';

class RunningResultCard extends StatefulWidget {
  final CheckingModel activity;
  const RunningResultCard({Key? key, required this.activity}) : super(key: key);

  @override
  _RunningResultCardState createState() => _RunningResultCardState();
}

class _RunningResultCardState extends State<RunningResultCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      elevation: 3,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RunningDetail(
              activity: widget.activity,
            ),
          ),
        ),
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
                right: BorderSide(
                    color: checkStatusColor(widget.activity.status), width: 8),
              ),
            ),
            child: Row(
              children: [
                Image(
                  image: FirebaseImage(
                    'gs://virtualrunkku-c67d1.appspot.com/${widget.activity.resultImage}',
                    maxSizeBytes: 10000 * 1000,
                  ),
                  fit: BoxFit.cover,
                  // width: double.infinity,
                  height: 80,
                  width: 60,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.activity.bib,
                      style: Theme.of(context).textTheme.headlineMedium,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ระยะทาง',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'วันที่ส่ง',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.activity.distance} กม.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              DateFormat('dd MMM yyyy', 'th')
                                  .format(widget.activity.sendResultDate!),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color checkStatusColor(String status) {
  if (status == 'approved') {
    return colorGreen;
  } else if (status == 'checking') {
    return colorYellow;
  } else if (status == 'rejected') {
    return colorRed;
  } else {
    return Colors.white;
  }
}
