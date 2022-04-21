import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/screens/news.dart';
import 'package:virtual_run_kku/services/firestore_database.dart';
import '../models/profile.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/seconds_to_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProfileModel initialProfile = ProfileModel(
    name: 'name',
    distance: 0,
    events: 0,
    timeInSeconds: 0,
    urlImage: 'assets/images/avatar1.png',
  );

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    setProfileData();
  }

  setProfileData() async {
    bool docExists = await checkIfProfileExists(user.email!);
    if (!docExists) {
      await createProfile(
        collectionName: user.email!,
        profileData: ProfileModel(
          distance: 0,
          events: 0,
          name: user.displayName!,
          timeInSeconds: 0,
          urlImage: user.photoURL!,
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าหลัก'),
        centerTitle: false,
      ),
      backgroundColor: colorBackground,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            FutureBuilder<ProfileModel?>(
              future: readProfile(user.email!),
              builder: (context, snapshot) {
                final profile = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      color: colorWhite,
                      height: 324,
                      width: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  default:
                    return profile == null
                        ? buildStats(initialProfile)
                        : buildStats(profile);
                }
              },
            ),
            const SizedBox(height: 20),
            buildNews(),
          ],
        ),
      ),
    );
  }

  Widget buildStats(ProfileModel profile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      color: colorWhite,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: CachedNetworkImageProvider(
                  user.photoURL!,
                ),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  user.displayName!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'สถิติการวิ่งล่าสุด',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                profile.distance.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 60,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'กิโลเมตร',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colorGrey,
                      height: 0.2,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.events.toString(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'กิจกรรม',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorGrey,
                          height: 1,
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    intToTimeLeft(profile.timeInSeconds),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'เวลาที่ใช้',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorGrey,
                          height: 1,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildNews() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ข่าวสารการวิ่ง',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          StreamBuilder<List<NewsModel>>(
            stream: readNews(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('มีบางอย่างผิดพลาด ${snapshot.error}');
              } else if (snapshot.hasData) {
                final news = snapshot.data!;

                return news.isNotEmpty
                    ? ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: news.map(newsCard).toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'ยังไม่มีข่าวสาร',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget newsCard(NewsModel news) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => News(
                news: news,
              ),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: CachedNetworkImage(
                imageUrl: news.urlImage,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    DateFormat('วันที่ dd/MM/yyyy', 'th')
                        .format(DateTime.parse(news.date)),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: colorGrey),
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
