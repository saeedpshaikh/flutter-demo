import 'package:equatable/equatable.dart';

class TabState extends Equatable {
  final int selectedIndex;

  const TabState({this.selectedIndex = 0});

  TabState copyWith({int? selectedIndex}) {
    return TabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}