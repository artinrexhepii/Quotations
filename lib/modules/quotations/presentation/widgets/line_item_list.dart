import 'package:flutter/material.dart';
import 'package:quotations_app/modules/quotations/domain/entities/line_item.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/formatters.dart';

class LineItemList extends StatelessWidget {
  final List<LineItem> lineItems;
  final Function(int) onDelete;
  final VoidCallback onAdd;

  const LineItemList({
    super.key,
    required this.lineItems,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.lineItems,
          style: AppTextStyles.headline2,
        ),
        const SizedBox(height: AppDimensions.paddingM),
        if (lineItems.isEmpty)
          const Text(
            AppStrings.noLineItemsAdded,
            style: AppTextStyles.body1,
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lineItems.length,
            itemBuilder: (context, index) {
              final item = lineItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
                child: ListTile(
                  title: Text(item.title, style: AppTextStyles.subtitle1),
                  subtitle: Text(
                    'Quantity: ${Formatters.formatQuantity(item.quantity)} x ${Formatters.formatCurrency(item.price)} = ${Formatters.formatCurrency(item.totalPrice)}',
                    style: AppTextStyles.body1,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: AppColors.error),
                    onPressed: () => onDelete(index),
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: AppDimensions.paddingS),
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.add),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          ),
        ),
      ],
    );
  }
}
