import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/models/news_model.dart';

import '../providers/file_upload_provider.dart';
import '../screens/send_result_step.dart';
import '../utils/constants/colors.dart';

class NewsDetailsCard extends StatefulWidget {
  final NewsModel news;
  const NewsDetailsCard({Key? key, required this.news}) : super(key: key);

  @override
  _NewsDetailsCardState createState() => _NewsDetailsCardState();
}

class _NewsDetailsCardState extends State<NewsDetailsCard> {
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
                          DateFormat('d', 'th')
                              .format(DateTime.parse(widget.news.date)),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('MMM', 'th')
                              .format(DateTime.parse(widget.news.date)),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: CachedNetworkImage(
                        imageUrl: widget.news.urlImage,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 80,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.news.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.news.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
