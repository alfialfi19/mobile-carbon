part of 'master_bloc.dart';

abstract class MasterState extends BlocState {
  const MasterState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class MasterInitial extends MasterState {}

class MasterArticleCategoryLoading extends MasterState {}

class MasterArticleCategoryLoaded extends MasterState {
  final List<EmisiCategory> articleCategory;

  const MasterArticleCategoryLoaded(this.articleCategory);
}

class MasterArticleCategoryEmpty extends MasterState {}

class MasterArticleCategoryError extends MasterState {
  final GenericErrorResponse errorResponse;

  const MasterArticleCategoryError(this.errorResponse);
}

class MasterCategoryLoading extends MasterState {}

class MasterCategoryLoaded extends MasterState {
  final List<EmisiCategory> emisiCategory;

  const MasterCategoryLoaded(this.emisiCategory);
}

class MasterCategoryEmpty extends MasterState {}

class MasterCategoryError extends MasterState {
  final GenericErrorResponse errorResponse;

  const MasterCategoryError(this.errorResponse);
}

class MasterSubCategoryLoading extends MasterState {}

class MasterSubCategoryLoaded extends MasterState {
  final List<EmisiCategory> emisiCategory;

  const MasterSubCategoryLoaded(this.emisiCategory);
}

class MasterSubCategoryEmpty extends MasterState {}

class MasterSubCategoryError extends MasterState {
  final GenericErrorResponse errorResponse;

  const MasterSubCategoryError(this.errorResponse);
}
