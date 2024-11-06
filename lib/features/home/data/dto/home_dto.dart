
import '../../domain/model/home_model.dart';

class HomeDto {
  final String? id;
  final String? name; 

  HomeDto({
    this.id,
    this.name,
  });

  factory HomeDto.fromJson(Map<String, dynamic> json) => HomeDto(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  HomeModel toModel() => HomeModel(
    id: id,
    name: name,
  );
}