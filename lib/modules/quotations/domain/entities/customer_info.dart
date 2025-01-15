import 'package:equatable/equatable.dart';

class CustomerInfo extends Equatable {
  final String companyName;
  final String companyAddress;
  final String emailAddress;
  final String vatNumber;

  const CustomerInfo({
    required this.companyName,
    required this.companyAddress,
    required this.emailAddress,
    required this.vatNumber,
  });

  @override
  List<Object?> get props => [
        companyName,
        companyAddress,
        emailAddress,
        vatNumber,
      ];
}
