part of 'logbook_add_bloc.dart';

@immutable
abstract class LogbookAddState {}

class LogbookAddInitial extends LogbookAddState {}

class LogbookAddLoadingState extends LogbookAddState {}

class LogbookAddLoadedState extends LogbookAddState {
  List<LogbookSubLocation> subLocationOptions;
  List<VandalType> vandalTypeOptions;

  LogbookSubLocation? selectedSubLocation;
  String? room;
  VandalType? selectedVandalType;
  String? vandalDescription;
  String? description;

  LogbookAddLoadedState(
    this.subLocationOptions,
    this.vandalTypeOptions, {
    this.selectedSubLocation,
    this.room,
    this.selectedVandalType,
    this.description,
    this.vandalDescription,
  });

  LogbookAddLoadedState copyWith(LogbookAddLoadedState state) =>
      LogbookAddLoadedState(
        state.subLocationOptions,
        state.vandalTypeOptions,
        selectedSubLocation: state.selectedSubLocation ?? selectedSubLocation,
        room: state.room ?? room,
        selectedVandalType: state.selectedVandalType ?? selectedVandalType,
        vandalDescription: state.vandalDescription ?? vandalDescription,
        description: state.description ?? description,
      );
}

class LogbookAddErrorState extends LogbookAddState {
  final String message;

  LogbookAddErrorState(this.message);
}

class LogbookAddOnSubmitErrorState extends LogbookAddErrorState {
  LogbookAddOnSubmitErrorState(String message) : super(message);
}

class LogbookAddSumittedState extends LogbookAddState {}
