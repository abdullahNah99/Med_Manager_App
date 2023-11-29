import 'package:equatable/equatable.dart';

final class DepartmentModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const DepartmentModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> jsonData) {
    return DepartmentModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['img'],
    );
  }
  @override
  List<Object> get props => [id, name, image];
}
