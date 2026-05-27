import 'user_model.dart';

class TokensModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  const TokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        expiresIn: json['expiresIn'] as int,
      );
}

class AuthResponseModel {
  final UserModel user;
  final TokensModel tokens;

  const AuthResponseModel({required this.user, required this.tokens});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        tokens: TokensModel.fromJson(json['tokens'] as Map<String, dynamic>),
      );
}
