import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryData {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDelete;
  @HiveField(3)
  final CategoryType type;

  CategoryData(
      {required this.id,
      required this.name,
      required this.type,
      this.isDelete = false});
}
