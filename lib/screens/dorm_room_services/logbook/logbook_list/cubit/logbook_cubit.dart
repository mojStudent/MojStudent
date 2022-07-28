import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'logbook_state.dart';

class LogbookCubit extends Cubit<LogbookState> {
  LogbookCubit() : super(LogbookInitial());
}
