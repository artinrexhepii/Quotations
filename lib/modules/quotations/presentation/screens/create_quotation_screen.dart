import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/customer_info.dart';
import '../../domain/entities/line_item.dart';
import '../../domain/entities/quotation.dart';
import '../bloc/quotation_bloc.dart';
import '../widgets/line_item_list.dart';
import '../widgets/quotation_form.dart';
import 'dart:io';

class CreateQuotationScreen extends StatefulWidget {
  final Quotation? editQuotation;

  const CreateQuotationScreen({super.key, this.editQuotation});

  @override
  State<CreateQuotationScreen> createState() => _CreateQuotationScreenState();
}

class _CreateQuotationScreenState extends State<CreateQuotationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _emailController = TextEditingController();
  final _vatNumberController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late List<LineItem> _lineItems;
  late List<String> _imageUrls;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _lineItems = widget.editQuotation?.lineItems.toList() ?? [];
    _imageUrls = widget.editQuotation?.imageUrls.toList() ?? [];

    if (widget.editQuotation != null) {
      _companyNameController.text = widget.editQuotation!.customerInfo.companyName;
      _companyAddressController.text = widget.editQuotation!.customerInfo.companyAddress;
      _emailController.text = widget.editQuotation!.customerInfo.emailAddress;
      _vatNumberController.text = widget.editQuotation!.customerInfo.vatNumber;
      _titleController.text = widget.editQuotation!.title;
      _descriptionController.text = widget.editQuotation!.description;
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyAddressController.dispose();
    _emailController.dispose();
    _vatNumberController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addLineItem() {
    showDialog(
      context: context,
      builder: (context) => _LineItemDialog(
        onAdd: (lineItem) {
          setState(() {
            _lineItems.add(lineItem);
          });
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageUrls.add(image.path);
      });
    }
  }

  void _saveQuotation() {
    if (_formKey.currentState!.validate()) {
      final quotation = Quotation(
        id: widget.editQuotation?.id ?? const Uuid().v4(),
        customerInfo: CustomerInfo(
          companyName: _companyNameController.text,
          companyAddress: _companyAddressController.text,
          emailAddress: _emailController.text,
          vatNumber: _vatNumberController.text,
        ),
        title: _titleController.text,
        description: _descriptionController.text,
        lineItems: _lineItems,
        totalPrice: _lineItems.fold(0, (sum, item) => sum + item.totalPrice),
        imageUrls: _imageUrls,
        createdAt: widget.editQuotation?.createdAt ?? DateTime.now(),
      );

      if (widget.editQuotation != null) {
        context.read<QuotationBloc>().add(UpdateQuotationEvent(quotation));
      } else {
        context.read<QuotationBloc>().add(CreateQuotationEvent(quotation));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editQuotation != null ? AppStrings.edit : 'Create Quotation'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuotationForm(
              formKey: _formKey,
              companyNameController: _companyNameController,
              companyAddressController: _companyAddressController,
              emailController: _emailController,
              vatNumberController: _vatNumberController,
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            LineItemList(
              lineItems: _lineItems,
              onDelete: (index) {
                setState(() {
                  _lineItems.removeAt(index);
                });
              },
              onAdd: _addLineItem,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            _buildImages(),
            const SizedBox(height: AppDimensions.paddingL),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.images,
          style: AppTextStyles.headline2,
        ),
        const SizedBox(height: AppDimensions.paddingM),
        if (_imageUrls.isEmpty)
          const Text(
            AppStrings.noImagesAdded,
            style: AppTextStyles.body1,
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppDimensions.paddingS),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        child: Image.file(
                          File(_imageUrls[index]),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: AppDimensions.paddingS,
                      top: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        onPressed: () {
                          setState(() {
                            _imageUrls.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        const SizedBox(height: AppDimensions.paddingS),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image_outlined),
          label: const Text('Add Image'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: _saveQuotation,
        child: Text(
          widget.editQuotation != null ? AppStrings.save : 'Create Quotation',
          style: AppTextStyles.subtitle1,
        ),
      ),
    );
  }
}

class _LineItemDialog extends StatefulWidget {
  final void Function(LineItem) onAdd;

  const _LineItemDialog({required this.onAdd});

  @override
  State<_LineItemDialog> createState() => _LineItemDialogState();
}

class _LineItemDialogState extends State<_LineItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addLineItem() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final price = double.parse(_priceController.text);
      final quantity = int.parse(_quantityController.text);

      widget.onAdd(
        LineItem(
          id: const Uuid().v4(),
          title: title,
          price: price,
          quantity: quantity,
          totalPrice: price * quantity,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Line Item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: AppStrings.title,
              ),
              validator: (value) => Validators.validateRequired(value, AppStrings.title),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: AppStrings.price,
              ),
              keyboardType: TextInputType.number,
              validator: Validators.validatePrice,
            ),
            const SizedBox(height: AppDimensions.paddingM),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: AppStrings.quantity,
              ),
              keyboardType: TextInputType.number,
              validator: Validators.validateQuantity,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: _addLineItem,
          child: const Text(AppStrings.add),
        ),
      ],
    );
  }
}
