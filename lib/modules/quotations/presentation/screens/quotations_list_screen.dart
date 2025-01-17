import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/routing/app_router.dart';
import '../../domain/entities/quotation.dart';
import '../bloc/quotation_bloc.dart';

class QuotationsListScreen extends StatelessWidget {
  const QuotationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<QuotationBloc, QuotationState>(
        builder: (context, state) {
          if (state is QuotationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuotationLoaded) {
            if (state.quotations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 64,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    Text(
                      'No quotations yet',
                      style: AppTextStyles.headline2.copyWith(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(
                      'Create your first quotation by tapping the + button',
                      style: AppTextStyles.body1.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return _buildQuotationsList(context, state.quotations);
          } else if (state is QuotationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 64,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Text(
                    'Error',
                    style: AppTextStyles.headline2.copyWith(color: AppColors.error),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text(
                    state.message,
                    style: AppTextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRouter.create),
        icon: const Icon(Icons.add),
        label: const Text('New Quotation'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
      ),
    );
  }

  Widget _buildQuotationsList(BuildContext context, List<Quotation> quotations) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: quotations.length,
      itemBuilder: (context, index) {
        final quotation = quotations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: InkWell(
            onTap: () => context.push('/quotation/${quotation.id}'),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quotation.title,
                              style: AppTextStyles.headline2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppDimensions.paddingXS),
                            Text(
                              quotation.customerInfo.companyName,
                              style: AppTextStyles.body1.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: AppColors.error,
                        onPressed: () => _showDeleteDialog(context, quotation),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items',
                            style: AppTextStyles.body1.copyWith(color: Colors.grey),
                          ),
                          Text(
                            quotation.lineItems.length.toString(),
                            style: AppTextStyles.subtitle1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total',
                            style: AppTextStyles.body1.copyWith(color: Colors.grey),
                          ),
                          Text(
                            Formatters.formatCurrency(quotation.totalPrice),
                            style: AppTextStyles.subtitle1.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, Quotation quotation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.delete),
        content: const Text(AppStrings.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<QuotationBloc>().add(DeleteQuotationEvent(quotation.id));
              context.pop();
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
