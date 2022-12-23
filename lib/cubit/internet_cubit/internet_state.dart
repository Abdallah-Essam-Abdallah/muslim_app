part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class ConnectedInternetState extends InternetState {}

class DisconnectedInternetState extends InternetState {}
