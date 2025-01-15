import '../entities/quotation.dart';
import '../repositories/quotation_repository.dart';

class GetQuotationById {
  final QuotationRepository repository;

  GetQuotationById(this.repository);

  Future<Quotation> call(String id) async {
    return await repository.getQuotationById(id);
  }
}
