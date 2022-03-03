part of 'internet_log_cubit.dart';

@immutable
abstract class InternetLogState {}

class InternetLogInitial extends InternetLogState {}

class InternetLogLoadedState extends InternetLogState {
  final bool showOnlyActive;
  final List<InternetConnectionLogModel> connections;

  List<InternetConnectionLogModel> getConnections() => showOnlyActive
      ? connections.where((el) => el.status == 0).toList()
      : connections;

  InternetLogLoadedState(this.connections, this.showOnlyActive);
}
