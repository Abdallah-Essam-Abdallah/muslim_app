import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/configs/constants.dart';
import 'package:muslim_app/cubit/internet_cubit/internet_cubit.dart';

import '../cubit/app_cubit/app_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AppCubit>(context)..determinePosition(context),
        child: Scaffold(
            appBar: const MainAppBar(),
            body: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    return state is DisconnectedInternetState
                        ? const DisconectedInternetWidget()
                        : AppCubit.screens[AppCubit.bnbIndex];
                  },
                );
              },
            ),
            bottomNavigationBar: const AppBottomNavigationBar()));
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Text(
            AppCubit.titels[AppCubit.bnbIndex],
            style: Theme.of(context).textTheme.headline6,
          );
        },
      ),
      actions: [
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () => AppCubit.getAppCubit(context).toggleTheme(),
                icon: AppCubit.isDark
                    ? const Icon(
                        Icons.brightness_7,
                      )
                    : const Icon(
                        Icons.brightness_2,
                        color: Color(0xFF1A2127),
                      ));
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return BottomNavigationBar(
            currentIndex: AppCubit.bnbIndex,
            onTap: (index) {
              AppCubit.getAppCubit(context).changeBnbIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: ' القران الكريم '),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'الرئيسيه'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mosque), label: 'مواقيت الصلاه'),
            ]);
      },
    );
  }
}
