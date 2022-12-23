import 'package:flutter/material.dart';

import '../cubit/quran_cubit/quran_cubit.dart';
import '../configs/size_config.dart';
import '../services/cache_helper.dart';

class LastReadPage extends StatelessWidget {
  const LastReadPage({super.key, required this.pageNumber});
  final int pageNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'تم حفظ موضع القرأه',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline6,
                )));
                CacheHelper.setInt(
                    key: 'lastRead', value: QuranCubit.lastReadPage);
              },
              icon: const Icon(Icons.bookmark_add))
        ],
      ),
      body: PageView.builder(
        itemCount: 605 - pageNumber,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          return Image.asset(
            'assets/images/quran/${pageNumber + index}.png',
            fit: BoxFit.fill,
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
          );
        }),
        onPageChanged: (value) {
          value = pageNumber + value;
          QuranCubit.getQuranCubit(context).saveLastReadPage(value);
        },
      ),
    );
  }
}
