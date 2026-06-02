import 'package:equatable/equatable.dart';

class UpiIdModel extends Equatable {
  final String id;
  final String upiId;
  final bool isPrimary;

  const UpiIdModel({
    required this.id,
    required this.upiId,
    required this.isPrimary,
  });

  factory UpiIdModel.fromJson(Map<String, dynamic> json) => UpiIdModel(
        id: json['id'] as String,
        upiId: json['upiId'] as String,
        isPrimary: json['isPrimary'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'upiId': upiId,
        'isPrimary': isPrimary,
      };

  UpiIdModel copyWith({bool? isPrimary}) => UpiIdModel(
        id: id,
        upiId: upiId,
        isPrimary: isPrimary ?? this.isPrimary,
      );

  @override
  List<Object?> get props => [id, upiId, isPrimary];
}
