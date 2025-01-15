import 'package:equatable/equatable.dart';

class LineItem extends Equatable {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final double totalPrice;

  const LineItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        quantity,
        totalPrice,
      ];
}
