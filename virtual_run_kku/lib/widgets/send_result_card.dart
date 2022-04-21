import 'package:expandable/expandable.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/models/activity_model.dart';

import '../providers/file_upload_provider.dart';
import '../screens/send_result_step.dart';
import '../utils/constants/colors.dart';

class SendResultCard extends StatefulWidget {
  final ActivityModel activity;
  const SendResultCard({Key? key, required this.activity}) : super(key: key);

  @override
  _SendResultCardState createState() => _SendResultCardState();
}

class _SendResultCardState extends State<SendResultCard> {
  @override
  Widget build(BuildContext context) {
    final fileUploadProvider = Provider.of<FileUploadProvider>(context);

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
                          widget.activity.eventDate.day.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('MMM', 'th')
                              .format(widget.activity.eventDate),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: colorPrimary),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Image(
                      image: FirebaseImage(
                          'gs://virtualrunkku-c67d1.appspot.com/${widget.activity.eventImage}'),
                      fit: BoxFit.cover,
                      height: 80,
                      width: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.activity.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                  onPressed: () {
                    fileUploadProvider.setFileName('');
                    fileUploadProvider.setFilePath('');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SendResultStep(activity: widget.activity)),
                    );
                  },
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
