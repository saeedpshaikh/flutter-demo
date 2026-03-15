import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyl_demo/feature/policies/presentation/bloc/policies_event.dart';
import 'package:nyl_demo/feature/policies/presentation/bloc/policies_state.dart';

import '../../domain/usecase/get_policies_usecase.dart';

class PoliciesBloc extends Bloc<PoliciesEvent, PoliciesState> {
  final GetPoliciesUseCase getPoliciesUseCase;

  PoliciesBloc({required this.getPoliciesUseCase})
      : super(const PoliciesState()) {
    on<FetchPoliciesEvent>(_onFetchPolicies);
  }

  Future<void> _onFetchPolicies(
      FetchPoliciesEvent event,
      Emitter<PoliciesState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
      ),
    );

    try {
      final result = await getPoliciesUseCase();

      emit(
        state.copyWith(
          isLoading: false,
          policies: result,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

}