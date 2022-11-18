part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ListModel> list;

  const ListLoaded(this.list);
}

class ListError extends ListState {
  final String message;
  const ListError(this.message);
}
