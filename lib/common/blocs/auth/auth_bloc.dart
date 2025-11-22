import 'package:equatable/equatable.dart';
import 'package:fdelux_source_neytrip/data/models/user_model.dart';
import 'package:fdelux_source_neytrip/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final _logger = Logger('AuthBloc');

  final AuthRepository _repository;

  AuthBloc({required AuthRepository authRepository})
    : _repository = authRepository,
      super(AuthInitial()) {
    _logger.info('AuthBloc initialized with AuthRepository.');
    on<AppStartedEvent>(_onAppStarted);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
    on<LoggedOutEvent>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<AuthState> emit,
  ) async {
    _logger.info('Event: AppStarted - Checking authentication status.');
    emit(AuthLoading());
    final result = await _repository.checkAuthStatus();
    result.fold(
      (failure) {
        _logger.warning('AppStarted: Unauthenticated - ${failure.message}');
        emit(Unauthenticated(message: failure.message));
      },
      (userModel) {
        _logger.info('AppStarted: Authenticated user: ${userModel.email}');
        emit(Authenticated(userModel));
      },
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    _logger.info('Event: LoginSubmitted for email: ${event.email}');
    emit(AuthLoading());
    final result = await _repository.login(event.email, event.password);
    result.fold(
      (failure) {
        _logger.severe(
          'LoginSubmitted: Authentication failed: ${failure.message}',
        );
        emit(AuthFailed(failure.message));
      },
      (userModel) {
        _logger.info('LoginSubmitted: User logged in: ${userModel.email}');
        emit(Authenticated(userModel));
      },
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    _logger.info('Event: RegisterSubmitted for email: ${event.email}');
    emit(AuthLoading());
    final result = await _repository.register(
      event.name,
      event.email,
      event.password,
    );
    result.fold(
      (failure) {
        _logger.severe(
          'RegisterSubmitted: Registration failed: ${failure.message}',
        );
        emit(AuthFailed(failure.message));
      },
      (userModel) {
        _logger.info('RegisterSubmitted: User registered: ${userModel.email}');
        emit(RegistrationSuccess(userModel));
      },
    );
  }

  Future<void> _onLoggedOut(
    LoggedOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    _logger.info('Event: LoggedOut - Clearing session.');
    emit(AuthLoading());
    await _repository.logout();
    _logger.info('LoggedOut: Session cleared, user unauthenticated.');
    emit(const Unauthenticated());
  }
}
