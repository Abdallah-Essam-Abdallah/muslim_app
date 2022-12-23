import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../configs/size_config.dart';

import '../cubit/sebha_cubit/sebha_cubit.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SebhaCubit.appBarTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: BlocProvider(
        create: (context) => SebhaCubit(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * .10,
                ),
                const AppDropDownButton(),
                SizedBox(
                  height: SizeConfig.screenHeight! * .10,
                ),
                const SebhaButton(),
                SizedBox(
                  height: SizeConfig.screenHeight! * .10,
                ),
                const SebhaResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SebhaCubit, SebhaState>(
      builder: (context, state) {
        return DropdownButton<String>(
          elevation: 20,
          borderRadius: BorderRadius.circular(15),
          onChanged: (newValue) {
            SebhaCubit.getSebhaCubit(context).changeMenuValue(newValue!);
          },
          hint: SizedBox(
            width: SizeConfig.screenWidth! * .65,
            child: const Text(
              SebhaCubit.hint,
              textAlign: TextAlign.center,
            ),
          ),
          value: SebhaCubit.zekr,
          items: SebhaCubit.azkar.map((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: SizeConfig.screenWidth! * .65,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ));
          }).toList(),
        );
      },
    );
  }
}

class SebhaButton extends StatelessWidget {
  const SebhaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SebhaCubit, SebhaState>(
      builder: (context, state) {
        return OutlinedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(
                SizeConfig.screenWidth! * .50, SizeConfig.screenHeight! * .30)),
          ),
          onPressed: () =>
              SebhaCubit.getSebhaCubit(context).zekrCountIncreament(),
          child: Text(
            SebhaCubit.zekrCount.toString(),
            textScaleFactor: 4,
          ),
        );
      },
    );
  }
}

class SebhaResetButton extends StatelessWidget {
  const SebhaResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * .06,
      width: SizeConfig.screenWidth! * .50,
      child: ElevatedButton(
          onPressed: () => SebhaCubit.getSebhaCubit(context).resetZekrCount(),
          child: const Text(
            'تصفير العداد',
            textScaleFactor: 1.5,
          )),
    );
  }
}
