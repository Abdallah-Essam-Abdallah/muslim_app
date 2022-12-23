import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sebha_state.dart';

class SebhaCubit extends Cubit<SebhaState> {
  SebhaCubit() : super(SebhaInitial());

  static SebhaCubit getSebhaCubit(context) => BlocProvider.of(context);

  static const String appBarTitle = 'السبحه';
  static const String hint = 'اختار الذكر';

  static final List<String> azkar = [
    'سبحان الله',
    'الحمد لله',
    'لا اله الا الله',
    'الله اكبر',
    'لا حول ولا قوه الا بالله',
    'استغفر الله',
    'سبحان الله وبحمده سبحان الله العظيم',
    'اللهم صلى وسلم وبارك على سيدنا محمد'
  ];

  static String? zekr;
  static int zekrCount = 0;

  void zekrCountIncreament() {
    zekrCount++;
    emit(ZekrCountIncreamentState());
  }

  void resetZekrCount() {
    zekrCount = 0;
    emit(ResetZekrCountState());
  }

  void changeMenuValue(String value) {
    zekr = value;
    emit(ChangeMenuValueState());
  }
}
