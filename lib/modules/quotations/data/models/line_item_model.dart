import 'package:hive/hive.dart';
import '../../domain/entities/line_item.dart';

part 'line_item_model.g.dart';

@HiveType(typeId: 2)
class LineItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final double totalPrice;

  LineItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  factory LineItemModel.fromDomain(LineItem lineItem) {
    return LineItemModel(
      id: lineItem.id,
      title: lineItem.title,
      price: lineItem.price,
      quantity: lineItem.quantity,
      totalPrice: lineItem.totalPrice,
    );
  }

  LineItem toDomain() {
    return LineItem(
      id: id,
      title: title,
      price: price,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }
}
