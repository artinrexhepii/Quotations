import '../repositories/quotation_repository.dart';

class DeleteQuotation {
  final QuotationRepository repository;

  DeleteQuotation(this.repository);

  Future<void> call(String id) async {
    await repository.deleteQuotation(id);
  }
}
