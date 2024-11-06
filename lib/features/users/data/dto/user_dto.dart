import 'package:awesome_app/features/users/domain/model/user_model.dart';

class UserDto {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserDto({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };

  UserModel toModel() => UserModel(
        id: id,
        email: email,
        avatar: avatar,
        firstName: firstName,
        lastName: lastName,
      );
}
