import 'package:equatable/equatable.dart';
import 'customer_info.dart';
import 'line_item.dart';

class Quotation extends Equatable {
  final String id;
  final CustomerInfo customerInfo;
  final String title;
  final String description;
  final List<LineItem> lineItems;
  final double totalPrice;
  final List<String> imageUrls;
  final DateTime createdAt;

  const Quotation({
    required this.id,
    required this.customerInfo,
    required this.title,
    required this.description,
    required this.lineItems,
    required this.totalPrice,
    required this.imageUrls,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        customerInfo,
        title,
        description,
        lineItems,
        totalPrice,
        imageUrls,
        createdAt,
      ];
}
