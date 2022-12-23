import 'package:flutter/material.dart';

import '../configs/size_config.dart';
import '../models/azkar_model.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'الاذكار',
              style: Theme.of(context).textTheme.headline6,
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'اذكار الصباح',
              ),
              Tab(
                text: 'اذكار المساء',
              ),
            ]),
          ),
          body: const TabBarView(children: [
            MorningAzkarWidget(),
            NightAzkarWidget(),
          ]),
        ));
  }
}

class MorningAzkarWidget extends StatelessWidget {
  const MorningAzkarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: AzkarData.morningAzkar.length,
      itemBuilder: ((context, index) => AzkarCard(
            index: index,
            zekr: AzkarData.morningAzkar[index]['zekr'],
            description: AzkarData.morningAzkar[index]['description'],
            zekrCount: int.parse(AzkarData.morningAzkar[index]['count']),
          )),
      separatorBuilder: (context, index) => const SizedBox(
        height: 1,
      ),
    );
  }
}

class NightAzkarWidget extends StatelessWidget {
  const NightAzkarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: AzkarData.nightAzkar.length,
      itemBuilder: ((context, index) => AzkarCard(
          index: index,
          zekr: AzkarData.nightAzkar[index]['zekr']!,
          description: AzkarData.nightAzkar[index]['description']!,
          zekrCount: int.parse(AzkarData.nightAzkar[index]['count']!))),
      separatorBuilder: (context, index) => const SizedBox(
        height: 1,
      ),
    );
  }
}

class AzkarCard extends StatefulWidget {
  const AzkarCard(
      {super.key,
      required this.index,
      required this.zekr,
      required this.description,
      required this.zekrCount});
  final int index;
  final String zekr;
  final String description;
  final int zekrCount;

  @override
  State<AzkarCard> createState() => _AzkarCardState();
}

class _AzkarCardState extends State<AzkarCard> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.horizontal, children: [
      Expanded(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.screenWidth! * .02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.zekr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 5,
                ),
                OutlinedButton(
                  onPressed: (() => setState(() {
                        count == widget.zekrCount ? null : count++;
                      })),
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(50, 50)),
                  ),
                  child: count == widget.zekrCount
                      ? const Icon(
                          Icons.check_circle,
                          size: 50,
                        )
                      : Text(
                          count.toString(),
                          textScaleFactor: 1.5,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
