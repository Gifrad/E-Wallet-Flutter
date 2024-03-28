import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:bank_sha/services/transaction/transaction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is GetTransaction) {
        try {
          emit(TransactionLoading());

          final transaction = await TransactionService().getTransaction();

          emit(TransactionSuccess(transaction));
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
    });
  }
}
