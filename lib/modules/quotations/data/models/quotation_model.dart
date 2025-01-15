import 'package:hive/hive.dart';
import '../../domain/entities/quotation.dart';
import 'customer_info_model.dart';
import 'line_item_model.dart';

part 'quotation_model.g.dart';

@HiveType(typeId: 0)
class QuotationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final CustomerInfoModel customerInfo;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<LineItemModel> lineItems;

  @HiveField(5)
  final double totalPrice;

  @HiveField(6)
  final List<String> imageUrls;

  @HiveField(7)
  final DateTime createdAt;

  QuotationModel({
    required this.id,
    required this.customerInfo,
    required this.title,
    required this.description,
    required this.lineItems,
    required this.totalPrice,
    required this.imageUrls,
    required this.createdAt,
  });

  factory QuotationModel.fromDomain(Quotation quotation) {
    return QuotationModel(
      id: quotation.id,
      customerInfo: CustomerInfoModel.fromDomain(quotation.customerInfo),
      title: quotation.title,
      description: quotation.description,
      lineItems: quotation.lineItems.map((item) => LineItemModel.fromDomain(item)).toList(),
      totalPrice: quotation.totalPrice,
      imageUrls: quotation.imageUrls,
      createdAt: quotation.createdAt,
    );
  }

  Quotation toDomain() {
    return Quotation(
      id: id,
      customerInfo: customerInfo.toDomain(),
      title: title,
      description: description,
      lineItems: lineItems.map((item) => item.toDomain()).toList(),
      totalPrice: totalPrice,
      imageUrls: imageUrls,
      createdAt: createdAt,
    );
  }
}
