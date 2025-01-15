import '../entities/quotation.dart';
import '../repositories/quotation_repository.dart';

class UpdateQuotation {
  final QuotationRepository repository;

  UpdateQuotation(this.repository);

  Future<void> call(Quotation quotation) async {
    await repository.updateQuotation(quotation);
  }
}
