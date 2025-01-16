import 'package:hive/hive.dart';
import 'package:quotations_app/core/error/exceptions.dart';
import 'package:quotations_app/modules/quotations/data/models/quotation_model.dart';
import 'package:quotations_app/modules/quotations/domain/entities/quotation.dart';


abstract class LocalDataSource {
  Future<List<Quotation>> getAllQuotations();
  Future<Quotation> getQuotationById(String id);
  Future<void> createQuotation(Quotation quotation);
  Future<void> updateQuotation(Quotation quotation);
  Future<void> deleteQuotation(String id);
}

class HiveDataSource implements LocalDataSource {
  final Box<QuotationModel> quotationsBox;

  HiveDataSource(this.quotationsBox);

  @override
  Future<List<Quotation>> getAllQuotations() async {
    try {
      return quotationsBox.values.map((model) => model.toDomain()).toList();
    } catch (e) {
      throw StorageException('Failed to get quotations: $e');
    }
  }

  @override
  Future<Quotation> getQuotationById(String id) async {
    try {
      final model = quotationsBox.get(id);
      if (model == null) {
        throw StorageException('Quotation not found');
      }
      return model.toDomain();
    } catch (e) {
      throw StorageException('Failed to get quotation: $e');
    }
  }

  @override
  Future<void> createQuotation(Quotation quotation) async {
    try {
      final model = QuotationModel.fromDomain(quotation);
      await quotationsBox.put(model.id, model);
    } catch (e) {
      throw StorageException('Failed to create quotation: $e');
    }
  }

  @override
  Future<void> updateQuotation(Quotation quotation) async {
    try {
      final model = QuotationModel.fromDomain(quotation);
      await quotationsBox.put(model.id, model);
    } catch (e) {
      throw StorageException('Failed to update quotation: $e');
    }
  }

  @override
  Future<void> deleteQuotation(String id) async {
    try {
      await quotationsBox.delete(id);
    } catch (e) {
      throw StorageException('Failed to delete quotation: $e');
    }
  }
}
