import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/models/news_model.dart';

import '../services/firestore_database.dart';
import '../utils/constants/colors.dart';

class News extends StatefulWidget {
  final NewsModel news;
  const News({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(widget.news.title),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                title: '',
                confirmBtnText: 'ใช่',
                cancelBtnText: 'ยกเลิก',
                widget: Text(
                  'คุณแน่ใจหรือไม่ ?\nที่จะเข้าร่วมกิจกรรม\n${widget.news.title}',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  joinEvent(widget.news);
                });
          },
          child: Text(
            'เข้าร่วม',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: colorWhite,
                ),
          ),
        ),
      ),
      backgroundColor: colorWhite,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: CachedNetworkImage(
                      imageUrl: widget.news.urlImage,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.news.title,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'วันที่: ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: colorGrey),
                      ),
                      Expanded(
                        child: Text(
                          DateFormat('dd MMMM yyyy', 'th')
                              .format(widget.news.date),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'ระยะทาง: ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: colorGrey),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.news.distance.toString()} กม.',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\t \t \t ${widget.news.description}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
