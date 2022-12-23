import 'package:flutter/material.dart';

import 'package:muslim_app/configs/arabic_numbers.dart';
import 'package:muslim_app/services/cache_helper.dart';

import 'package:muslim_app/screens/azkar_screen.dart';
import 'package:muslim_app/screens/lastRead_screen.dart';

import 'package:muslim_app/screens/sebha_screen.dart';

import '../configs/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.screenWidth! * .01),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * .03,
              ),
              const TimeWidget(),
              SizedBox(
                height: SizeConfig.screenHeight! * .03,
              ),
              const HomeMainContainer(),
              SizedBox(
                height: SizeConfig.screenHeight! * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'الاقسام الفرعيه',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline6,
                    textScaleFactor: 2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  HomeCard(
                    page: AzkarScreen(),
                    image: 'assets/images/azkar.png',
                    title: 'الاذكار',
                  ),
                  HomeCard(
                    page: SebhaScreen(),
                    image: 'assets/images/tasbih.png',
                    title: 'السبحه',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.page,
    required this.title,
    required this.image,
  });
  final Widget page;
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => page))),
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight! * .25,
        child: Card(
            child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width: 120,
                    ),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    ));
  }
}

class HomeMainContainer extends StatelessWidget {
  const HomeMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * .20,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => CacheHelper.getInt(key: 'lastRead') == null
            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                'لا توجد قراه مسجله بعد',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline6,
              )))
            : Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => LastReadPage(
                    pageNumber: CacheHelper.getInt(key: 'lastRead')!)))),
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/quran.png',
                  height: 130,
                ),
                Text(
                  'اخر قرأه',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.right,
                  textScaleFactor: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(
            SizeConfig.screenWidth! * .20, SizeConfig.screenHeight! * .20)),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateTime.now().hour < 12 || DateTime.now().hour == 24 ? 'ص' : 'م',
            style: Theme.of(context).textTheme.headline6,
            textScaleFactor: 2,
          ),
          Text(
            '${ArabicNumbers.toArabicNumbers(DateTime.now().hour.toString())}:${ArabicNumbers.toArabicNumbers(DateTime.now().minute.toString())}',
            style: Theme.of(context).textTheme.headline6,
            textScaleFactor: 2,
          ),
        ],
      ),
    );
  }
}
