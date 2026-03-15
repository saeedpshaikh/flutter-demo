class PolicyEntity {
  final String id;
  final String name;
  final String policyNo;
  final String status;
  final double premium;
  final String nextDue;

  const PolicyEntity({
    required this.id,
    required this.name,
    required this.policyNo,
    required this.status,
    required this.premium,
    required this.nextDue,
  });
}