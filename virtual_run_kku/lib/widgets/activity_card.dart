import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/activity_model.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/seconds_to_time.dart';

class ActivityCard extends StatefulWidget {
  final ActivityModel activity;
  const ActivityCard({Key? key, required this.activity}) : super(key: key);

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
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
          header: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: CachedNetworkImage(
                  imageUrl: widget.activity.eventImage,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.activity.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'สถานะผลการวิ่ง',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    resultStatus(widget.activity.status),
                  ],
                ),
              ),
            ],
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: widget.activity.status == 'rejected'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เหตุผล',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.activity.rejectReason,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : Column(
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                              widget.activity.status == 'approved'
                                  ? Text(
                                      intToTimeLeft(widget
                                              .activity.timeSpendInSeconds!)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  : Container(),
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
                                    .format(widget.activity.eventDate),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      widget.activity.status == 'approved'
                          ? Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.archive,
                                            color: colorGreen,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'จัดเก็บ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: colorGreen),
                                          ),
                                        ],
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: colorGreen),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
          ),
          // tapHeaderToExpand: true,
          // hasIcon: true,
        ),
      ),
    );
  }

  Widget resultStatus(String status) {
    var thaiStatus = status == 'checking'
        ? 'กำลังตรวจสอบ'
        : status == 'approved'
            ? 'ผ่าน'
            : 'ไม่ผ่าน';
    return Container(
      height: 30,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: status == 'checking'
              ? colorYellow
              : status == 'approved'
                  ? colorGreen
                  : colorRed,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: Text(
            thaiStatus,
            // textScaleFactor: 2,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: colorWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
