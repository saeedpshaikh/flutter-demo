import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyl_demo/feature/dashboard/view_model/tab_event.dart';
import 'package:nyl_demo/feature/dashboard/view_model/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(const TabState()) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}