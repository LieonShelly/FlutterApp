part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.unvalidate(),
    this.password = const Password.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final Email email;
  final Password password;
  final SubmissionStatus submissionStatus;

  SignInState copyWith({
    Email? email,
    Password? password,
    SubmissionStatus? submissionStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [email, password];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  invalidCredentialError,
}
