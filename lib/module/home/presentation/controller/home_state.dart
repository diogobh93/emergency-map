abstract class HomeState {
  String get message;
}

class HomeStateSuccess extends HomeState {
  HomeStateSuccess();

  @override
  String get message => 'Success state!';
}

class HomeStateLoading extends HomeState {
  HomeStateLoading();

  @override
  String get message => 'Loading state!';
}

class HomeStateError extends HomeState {
  @override
  final String message;
  HomeStateError({required this.message});
}
