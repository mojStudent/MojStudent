part of 'damages_bloc.dart';

@immutable
abstract class DamagesState {}

class DamagesInitial extends DamagesState {}

class DamagesLoading extends DamagesState {}

class DamagesLoaded extends DamagesState {
  
}
