import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/validators.dart';

class QuotationForm extends StatelessWidget {
  final TextEditingController companyNameController;
  final TextEditingController companyAddressController;
  final TextEditingController emailController;
  final TextEditingController vatNumberController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final GlobalKey<FormState> formKey;

  const QuotationForm({
    super.key,
    required this.formKey,
    required this.companyNameController,
    required this.companyAddressController,
    required this.emailController,
    required this.vatNumberController,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            AppStrings.customerInfo,
            [
              TextFormField(
                controller: companyNameController,
                decoration: const InputDecoration(
                  labelText: AppStrings.companyName,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateRequired(value, AppStrings.companyName),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: companyAddressController,
                decoration: const InputDecoration(
                  labelText: AppStrings.companyAddress,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateRequired(value, AppStrings.companyAddress),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: AppStrings.emailAddress,
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: vatNumberController,
                decoration: const InputDecoration(
                  labelText: AppStrings.vatNumber,
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateVatNumber,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingL),
          _buildSection(
            AppStrings.quotationDetails,
            [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: AppStrings.title,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateRequired(value, AppStrings.title),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: AppStrings.description,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => Validators.validateRequired(value, AppStrings.description),
                maxLines: 3,
              ),
            ],
          ),
        ],
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
        const SizedBox(height: AppDimensions.paddingM),
        ...children,
      ],
    );
  }
}
