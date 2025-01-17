import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/quotation.dart';
import '../bloc/quotation_bloc.dart';
import 'create_quotation_screen.dart';
import 'dart:io';

class QuotationDetailScreen extends StatelessWidget {
  final Quotation quotation;

  const QuotationDetailScreen({super.key, required this.quotation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quotation.title),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateQuotationScreen(
                    editQuotation: quotation,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerInfo(),
            const SizedBox(height: AppDimensions.paddingL),
            _buildQuotationDetails(),
            const SizedBox(height: AppDimensions.paddingL),
            _buildLineItems(),
            const SizedBox(height: AppDimensions.paddingL),
            if (quotation.imageUrls.isNotEmpty) ...[
              _buildImages(),
              const SizedBox(height: AppDimensions.paddingL),
            ],
            _buildTotalPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return _buildSection(
      AppStrings.customerInfo,
      [
        _buildInfoRow(
          AppStrings.companyName,
          quotation.customerInfo.companyName,
          Icons.business_outlined,
        ),
        _buildInfoRow(
          AppStrings.companyAddress,
          quotation.customerInfo.companyAddress,
          Icons.location_on_outlined,
        ),
        _buildInfoRow(
          AppStrings.emailAddress,
          quotation.customerInfo.emailAddress,
          Icons.email_outlined,
        ),
        _buildInfoRow(
          AppStrings.vatNumber,
          quotation.customerInfo.vatNumber,
          Icons.numbers_outlined,
        ),
      ],
    );
  }

  Widget _buildQuotationDetails() {
    return _buildSection(
      AppStrings.quotationDetails,
      [
        _buildInfoRow(
          AppStrings.description,
          quotation.description,
          Icons.description_outlined,
        ),
        _buildInfoRow(
          'Created At',
          Formatters.formatDate(quotation.createdAt),
          Icons.calendar_today_outlined,
        ),
      ],
    );
  }

  Widget _buildLineItems() {
    return _buildSection(
      AppStrings.lineItems,
      [
        const Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingS),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Item',
                  style: AppTextStyles.subtitle1,
                ),
              ),
              Expanded(
                child: Text(
                  'Price',
                  style: AppTextStyles.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Qty',
                  style: AppTextStyles.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Total',
                  style: AppTextStyles.subtitle1,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        ...quotation.lineItems.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(item.title, style: AppTextStyles.body1),
                  ),
                  Expanded(
                    child: Text(
                      Formatters.formatCurrency(item.price),
                      style: AppTextStyles.body1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Formatters.formatQuantity(item.quantity),
                      style: AppTextStyles.body1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Formatters.formatCurrency(item.totalPrice),
                      style: AppTextStyles.body1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildImages() {
    return _buildSection(
      AppStrings.images,
      [
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quotation.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: AppDimensions.paddingS),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  child: _buildImage(quotation.imageUrls[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildTotalPrice() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.totalPrice,
              style: AppTextStyles.headline2,
            ),
            Text(
              Formatters.formatCurrency(quotation.totalPrice),
              style: AppTextStyles.headline2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headline2,
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey,
          ),
          const SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.body1.copyWith(color: Colors.grey),
                ),
                Text(
                  value,
                  style: AppTextStyles.subtitle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.delete),
        content: const Text(AppStrings.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<QuotationBloc>().add(DeleteQuotationEvent(quotation.id));
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to list
            },
            child: Text(
              AppStrings.delete,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
