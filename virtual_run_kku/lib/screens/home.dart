import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';
import '../utils/constants/content_constant.dart';
import '../widgets/running_result_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: MyConstant.white,
      appBar: MyConstant.appBar(MyConstant.titleHome),
      bottomNavigationBar: MyConstant.bottomBar(1),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            buildGreetingText(),
            buildStatsCard(),
            buildContentText('ผลการวิ่ง'),
            RunningResultCard(
              status: MyConstant.statusChecking,
              bib: 'Q0001',
              date: '15/02/65',
              distance: 24.2,
            ),
            RunningResultCard(
              status: MyConstant.statusApproved,
              bib: 'Q0002',
              date: '10/02/65',
              distance: 12.1,
            ),
            RunningResultCard(
              status: MyConstant.statusDenied,
              bib: 'Q0001',
              date: '25/01/65',
              distance: 24.2,
            ),
            buildContentText('ข่าวสารการวิ่ง'),
            // buildCarousel2(context),
            const ContentCarousel(),
          ],
        ),
      ),
    );
  }
}

Container buildGreetingText() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      children: [
        Text(
          'สวัสดี! ',
          style: MyConstant.h3Style(MyConstant.primary),
        ),
        Text(
          'คุณสมชาย ไกรทอง',
          style: MyConstant.h3Style(MyConstant.secondary),
        ),
      ],
    ),
  );
}

Card buildStatsCard() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5),
    elevation: 3,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                MyConstant.womanRunIcon,
                width: 40,
              ),
              const SizedBox(width: 10),
              Text(
                'ระยะทางที่วิ่งได้',
                style: MyConstant.h3Style(MyConstant.secondary),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '154.9',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'km',
                  style: TextStyle(fontSize: 16, color: MyConstant.grey),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Container buildContentText(String title) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: MyConstant.h2Style(MyConstant.secondary),
        ),
        Text(
          'ดูทั้งหมด',
          style: MyConstant.h3Style(MyConstant.grey),
        ),
      ],
    ),
  );
}

class ContentCarousel extends StatefulWidget {
  const ContentCarousel({Key? key}) : super(key: key);

  @override
  _ContentCarouselState createState() => _ContentCarouselState();
}

class _ContentCarouselState extends State<ContentCarousel> {
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: ContentConstant.imagePathList().length,
              itemBuilder: (context, index, realIndex) {
                final pathImage = ContentConstant.imagePathList()[index];
                return buildImage(pathImage, index);
              },
              options: CarouselOptions(
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  viewportFraction: 0.6,
                  aspectRatio: 2.5,
                  initialPage: 0,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index)),
            ),
            const SizedBox(
              height: 20,
            ),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String pathImage, int index) => Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey,
        child: Image.asset(
          pathImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: ContentConstant.imagePathList().length,
        effect: JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: MyConstant.primary,
        ),
        onDotClicked: animateToSlide,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
