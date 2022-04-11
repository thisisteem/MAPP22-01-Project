import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/models/news_model.dart';

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
        title: const Text('ข่าวสารการวิ่ง'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {},
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
                    child: Hero(
                      tag: 'news_${widget.news.id}',
                      child: CachedNetworkImage(
                        imageUrl: widget.news.urlImage,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 240,
                        fit: BoxFit.cover,
                      ),
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