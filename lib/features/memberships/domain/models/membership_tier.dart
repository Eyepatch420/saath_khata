import 'package:equatable/equatable.dart';

/// A vendor-owned membership tier. Each vendor has exactly three (levels 1..3),
/// with editable names (default Bronze / Silver / Gold).
class MembershipTier extends Equatable {
  final String id;
  final int level; // 1 = lowest, 3 = highest
  final String name;

  const MembershipTier({
    required this.id,
    required this.level,
    required this.name,
  });

  factory MembershipTier.fromJson(Map<String, dynamic> json) => MembershipTier(
        id: json['id'] as String,
        level: (json['level'] as num).toInt(),
        name: json['name'] as String,
      );

  @override
  List<Object?> get props => [id, level, name];
}
