part of 'home_view_bloc.dart';

@immutable
abstract class HomeViewState {
  final int panelIndex;

  const HomeViewState(this.panelIndex);
}

class HomeViewHomePanelState extends HomeViewState {
  const HomeViewHomePanelState() : super(0);
}

class HomeViewProfilePanelState extends HomeViewState {
  const HomeViewProfilePanelState() : super(1);
}

class HomeViewInternetPanelState extends HomeViewState {
  const HomeViewInternetPanelState() : super(2);
}
