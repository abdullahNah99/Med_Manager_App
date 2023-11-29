abstract class FavoriteStates {}

final class FavoriteInitial extends FavoriteStates {}

final class FavoriteLoading extends FavoriteStates {}

// final class ChangeFavoriteState extends FavoriteStates {}

final class FavoriteEmptyState extends FavoriteStates {}

final class FavoriteSuccess extends FavoriteStates {
  // final List<DoctorModel> doctors;

  // FavoriteSuccess({required this.doctors});
}

final class FavoriteFailure extends FavoriteStates {
  final String failureMsg;

  FavoriteFailure({required this.failureMsg});
}
