import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dddnotesapp/domain/auth/i_auth_facade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());
  final IAuthFacade _authFacade;

  @override
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    yield* event.map(
      emailChanged: (EmailChanged e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccess: none(),
        );
      },
      passwordChanged: (PasswordChanged e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccess: none(),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.registerWithEmailAndPassword);
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.signInWithEmailAndPassword);
      },
      signInWithGooglePressed: (SignInWithGooglePressed e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccess: none(),
        );
        final Either<AuthFailure, Unit> failureOrSuccess =
            await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccess: some(failureOrSuccess),
        );
      },
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      @required EmailAddress email,
      @required Password password,
    })
        forwardedCall,
  ) async* {
    final bool isEmailValid = state.emailAddress.isValid();
    final bool isPasswordValid = state.password.isValid();
    Either<AuthFailure, Unit> failureOrSuccess;

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: false,
        authFailureOrSuccess: none(),
      );
      failureOrSuccess = await forwardedCall(
        email: state.emailAddress,
        password: state.password,
      );
    }
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccess: optionOf(failureOrSuccess),
    );
  }
}
