import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/activity_model.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/seconds_to_time.dart';
import 'package:firebase_image/firebase_image.dart';

class HistoryCard extends StatefulWidget {
  final ActivityModel activity;

  const HistoryCard({Key? key, required this.activity}) : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpandablePanel(
          header: Column(
            children: [
              Image(
                image: FirebaseImage(
                    'gs://virtualrunkku-c67d1.appspot.com/${widget.activity.resultImage}'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.activity.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy', 'th')
                              .format(widget.activity.eventDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: colorGrey),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.activity.distance}',
                              style: Theme.of(context).textTheme.headlineMedium,
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'กม.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: colorGrey),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.bottom,
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'รายละเอียด',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.activity.status == 'approved'
                            ? Text(
                                'ระยะเวลาที่ใช้ :',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : Container(),
                        Text(
                          'หมายเลข BIB :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'ระยะทางทั้งหมด :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'วันที่จัดกิจกรรม :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'วันที่ส่งผลการวิ่ง :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          intToTimeLeft(widget.activity.timeSpendInSeconds!)
                              .toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.activity.bib,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${widget.activity.distance} กม.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy', 'th')
                              .format(widget.activity.eventDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy', 'th')
                              .format(widget.activity.sendResultDate!),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // tapHeaderToExpand: true,
          // hasIcon: true,
        ),
      ),
    );
  }
}
