import 'package:hive/hive.dart';
import '../../domain/entities/customer_info.dart';

part 'customer_info_model.g.dart';

@HiveType(typeId: 1)
class CustomerInfoModel extends HiveObject {
  @HiveField(0)
  final String companyName;

  @HiveField(1)
  final String companyAddress;

  @HiveField(2)
  final String emailAddress;

  @HiveField(3)
  final String vatNumber;

  CustomerInfoModel({
    required this.companyName,
    required this.companyAddress,
    required this.emailAddress,
    required this.vatNumber,
  });

  factory CustomerInfoModel.fromDomain(CustomerInfo customerInfo) {
    return CustomerInfoModel(
      companyName: customerInfo.companyName,
      companyAddress: customerInfo.companyAddress,
      emailAddress: customerInfo.emailAddress,
      vatNumber: customerInfo.vatNumber,
    );
  }

  CustomerInfo toDomain() {
    return CustomerInfo(
      companyName: companyName,
      companyAddress: companyAddress,
      emailAddress: emailAddress,
      vatNumber: vatNumber,
    );
  }
}
