part of 'sebha_cubit.dart';

@immutable
abstract class SebhaState {}

class SebhaInitial extends SebhaState {}

class ZekrCountIncreamentState extends SebhaState {}

class ResetZekrCountState extends SebhaState {}

class ChangeMenuValueState extends SebhaState {}
