import '../entities/quotation.dart';
import '../repositories/quotation_repository.dart';

class CreateQuotation {
  final QuotationRepository repository;

  CreateQuotation(this.repository);

  Future<void> call(Quotation quotation) async {
    await repository.createQuotation(quotation);
  }
}
