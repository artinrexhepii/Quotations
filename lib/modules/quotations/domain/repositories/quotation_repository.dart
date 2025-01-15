import '../entities/quotation.dart';

abstract class QuotationRepository {
  Future<List<Quotation>> getAllQuotations();
  Future<Quotation> getQuotationById(String id);
  Future<void> createQuotation(Quotation quotation);
  Future<void> updateQuotation(Quotation quotation);
  Future<void> deleteQuotation(String id);
}
