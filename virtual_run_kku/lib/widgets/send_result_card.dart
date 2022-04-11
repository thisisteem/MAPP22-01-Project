import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.model.dart';
import '../utils/constants/colors.dart';

class SendResultCard extends StatefulWidget {
  final EventModel event;
  const SendResultCard({Key? key, required this.event}) : super(key: key);

  @override
  _SendResultCardState createState() => _SendResultCardState();
}

class _SendResultCardState extends State<SendResultCard> {
  static bool isOpened = false;
  ExpandableController eventController = ExpandableController(
    initialExpanded: isOpened,
  );

  @override
  void initState() {
    eventController.addListener(() {
      setState(() {
        isOpened = !isOpened;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpandablePanel(
          controller: eventController,
          header: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.event.date.day.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('MMM', 'th').format(widget.event.date),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: colorPrimary),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: CachedNetworkImage(
                      imageUrl: widget.event.urlImage,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.event.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      maxLines: isOpened ? null : 2,
                      overflow: isOpened ? null : TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorPrimary,
                    minimumSize: const Size.fromHeight(30),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ส่งผลการวิ่ง',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorWhite,
                        ),
                  ),
                ),
              ),
            ],
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        Text(
                          'หมายเลข BIB :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'ระยะทางทั้งหมด :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'วันที่ :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.bib,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${widget.event.distance} กม.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy', 'th')
                              .format(widget.event.date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                )
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
