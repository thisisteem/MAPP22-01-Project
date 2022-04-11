import 'package:flutter/material.dart';
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
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () {},
          child: Text(
            'เข้าร่วม',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: colorWhite,
                ),
          ),
        ),
      ),
      backgroundColor: colorWhite,
      body: SafeArea(
        child: ListView(
          children: [Text(widget.news.title)],
        ),
      ),
    );
  }
}
