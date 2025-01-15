import '../entities/quotation.dart';
import '../repositories/quotation_repository.dart';

class GetAllQuotations {
  final QuotationRepository repository;

  GetAllQuotations(this.repository);

  Future<List<Quotation>> call() async {
    return await repository.getAllQuotations();
  }
}
