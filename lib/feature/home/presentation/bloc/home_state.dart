import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String userName;
  final String policyName;
  final String policyStatus;
  final String nextDueDate;
  final double premiumAmount;

  const HomeState({
    this.userName = "Saeed",
    this.policyName = "NYL Secure Life",
    this.policyStatus = "Active",
    this.nextDueDate = "Mar 25, 2026",
    this.premiumAmount = 150,
  });

  @override
  List<Object?> get props => [
    userName,
    policyName,
    policyStatus,
    nextDueDate,
    premiumAmount,
  ];
}