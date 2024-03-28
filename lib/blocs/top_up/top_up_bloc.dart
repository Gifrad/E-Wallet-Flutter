import 'package:bank_sha/models/transaction/top_up_form_model.dart';
import 'package:bank_sha/services/transaction/transaction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  TopUpBloc() : super(TopUpInitial()) {
    on<TopUpEvent>((event, emit) async {
      if (event is TopupPost) {
        try {
          emit(TopUpLoading());

          final redirectUrl = await TransactionService().topUp(event.data);

          emit(TopUpSuccess(redirectUrl));
        } catch (e) {
          emit(TopUpFailed(e.toString()));
        }
      }
    });
  }
}
