import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/screens/admin.dart';
import 'package:virtual_run_kku/services/firestore_database.dart';

import '../utils/constants/colors.dart';
import '../widgets/news_details_card.dart';

class NewsLists extends StatefulWidget {
  const NewsLists({Key? key}) : super(key: key);

  @override
  State<NewsLists> createState() => _NewsListsState();
}

class _NewsListsState extends State<NewsLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข่าวสารทั้งหมด'),
        centerTitle: false,
      ),
      backgroundColor: colorWhite,
      body: StreamBuilder<List<NewsModel>>(
        stream: readNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;

            return activity.isNotEmpty
                ? ListView(
                    children: activity.map<Widget>(((e) {
                      return NewsDetailsCard(news: e);
                    })).toList(),
                  )
                : emptyResult();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget emptyResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              'ไม่มีข่าว',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: colorPrimary,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Admin(),
                  ),
                );
              },
              child: Text(
                'กลับไปหน้าแรก',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: colorWhite,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
