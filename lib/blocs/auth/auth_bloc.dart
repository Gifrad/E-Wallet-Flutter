import 'package:bank_sha/models/auth/sign_in_form_model.dart';
import 'package:bank_sha/models/auth/sign_up_form_model.dart';
import 'package:bank_sha/models/auth/user_model.dart';
import 'package:bank_sha/models/user/edit_user_form.dart';
import 'package:bank_sha/services/auth/auth_service.dart';
import 'package:bank_sha/services/user/user_service.dart';
import 'package:bank_sha/services/wallet/wallet_service.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    final authService = AuthService();

    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());

          final res = await authService.checkEmail(event.email);

          if (res == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(const AuthFailed('Email Sudah Terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final user = await authService.register(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final user = await authService.login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SignInFormModel data = await getCredentialFormLocal();
          final UserModel user = await authService.login(data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
          print(e.toString());
        }
      }

      if (event is AuthUpdateUser) {
        try {
          if (state is AuthSuccess) {
            final updateUser = (state as AuthSuccess).user.copyWith(
                  username: event.data.username,
                  name: event.data.name,
                  email: event.data.email,
                  password: event.data.password,
                );
            emit(AuthLoading());

            final data = await UserService().updateUser(event.data);

            if (data) {
              await clearLocalPassStorage();
              await storePassToLocal(event.data.password);
              emit(AuthSuccess(updateUser));
            } else {
              emit(const AuthFailed('Gagal Update'));
            }
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {
            final updatePin = (state as AuthSuccess).user.copyWith(
                  pin: event.newPin,
                );
            emit(AuthLoading());

            await WalletService().updatePin(event.oldPin, event.newPin);

            emit(AuthSuccess(updatePin));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());

          await authService.logout();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateBalance) {
        if (state is AuthSuccess) {
          final currentUser = (state as AuthSuccess).user;
          final userBalance = num.parse(currentUser.balance!);
          final userBlanceEvent = num.parse(event.amount);
          final updateBalance = userBalance + userBlanceEvent;
          final updateUser =
              currentUser.copyWith(balance: updateBalance.toString());

          emit(AuthSuccess(updateUser));
        }
      }
    });
  }
}
