import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2196F3);
  static const background = Color(0xFFF5F5F5);
  static const error = Color(0xFFD32F2F);
  static const surface = Colors.white;
}

class AppDimensions {
  static const paddingXS = 4.0;
  static const paddingS = 8.0;
  static const paddingM = 16.0;
  static const paddingL = 24.0;
  static const buttonHeight = 50.0;
  static const radiusM = 8.0;
}

class AppTextStyles {
  static const headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const body1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}

class AppStrings {
  static const appName = 'Quotations App';
  static const customerInfo = 'Customer Information';
  static const quotationDetails = 'Quotation Details';
  static const lineItems = 'Line Items';
  static const noLineItemsAdded = 'No line items added yet';
  static const add = 'Add Line Item';
  static const companyName = 'Company Name';
  static const companyAddress = 'Company Address';
  static const emailAddress = 'Email Address';
  static const vatNumber = 'VAT Number';
  static const title = 'Title';
  static const description = 'Description';
  static const edit = 'Edit Quotation';
  static const save = 'Save';
  static const cancel = 'Cancel';
  static const delete = 'Delete';
  static const deleteConfirmation = 'Are you sure you want to delete this quotation?';
  static const price = 'Price';
  static const quantity = 'Quantity';
  static const totalPrice = 'Total Price';
  static const images = 'Images';
  static const noImagesAdded = 'No images added yet';
}
