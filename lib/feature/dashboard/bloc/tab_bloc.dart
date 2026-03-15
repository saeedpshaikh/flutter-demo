import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyl_demo/feature/dashboard/bloc/tab_event.dart';
import 'package:nyl_demo/feature/dashboard/bloc/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState()) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}