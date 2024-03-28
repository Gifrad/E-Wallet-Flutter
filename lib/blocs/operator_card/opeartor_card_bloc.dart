import 'package:bank_sha/models/operator-card/operator_card_model.dart';
import 'package:bank_sha/services/transaction/transaction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'opeartor_card_event.dart';
part 'opeartor_card_state.dart';

class OpeartorCardBloc extends Bloc<OpeartorCardEvent, OpeartorCardState> {
  OpeartorCardBloc() : super(OpeartorCardInitial()) {
    on<OpeartorCardEvent>((event, emit) async {
      if (event is OperatorCardGet) {
        try {
          emit(OpeartorCardLoading());

          final operatorCard = await TransactionService().getOperatorCards();

          emit(OpeartorCardSuccess(operatorCard));
        } catch (e) {
          emit(OpeartorCardFailed(e.toString()));
        }
      }
    });
  }
}
