part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NavigateToPage extends NavigationEvent {
  final int pageIndex;

  NavigateToPage({required this.pageIndex});
}
