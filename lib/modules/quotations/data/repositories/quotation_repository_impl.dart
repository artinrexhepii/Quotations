
import '../../../../core/error/failures.dart';
import '../../domain/entities/quotation.dart';
import '../../domain/repositories/quotation_repository.dart';
import '../datasources/hive_datasource.dart';


class QuotationRepositoryImpl implements QuotationRepository {
  final LocalDataSource localDataSource;

  QuotationRepositoryImpl(this.localDataSource);

  @override
  Future<List<Quotation>> getAllQuotations() async {
    try {
      return await localDataSource.getAllQuotations();
    } catch (e) {
      throw StorageFailure('Failed to get quotations: $e');
    }
  }

  @override
  Future<Quotation> getQuotationById(String id) async {
    try {
      return await localDataSource.getQuotationById(id);
    } catch (e) {
      throw StorageFailure('Failed to get quotation: $e');
    }
  }

  @override
  Future<void> createQuotation(Quotation quotation) async {
    try {
      await localDataSource.createQuotation(quotation);
    } catch (e) {
      throw StorageFailure('Failed to create quotation: $e');
    }
  }

  @override
  Future<void> updateQuotation(Quotation quotation) async {
    try {
      await localDataSource.updateQuotation(quotation);
    } catch (e) {
      throw StorageFailure('Failed to update quotation: $e');
    }
  }

  @override
  Future<void> deleteQuotation(String id) async {
    try {
      await localDataSource.deleteQuotation(id);
    } catch (e) {
      throw StorageFailure('Failed to delete quotation: $e');
    }
  }
}
