import 'package:intl/intl.dart';

class Formatters {
  static final _currencyFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final _dateFormatter = DateFormat('MMM dd, yyyy HH:mm');

  static String formatCurrency(double value) {
    return _currencyFormatter.format(value);
  }

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  static String formatQuantity(int quantity) {
    return NumberFormat.decimalPattern().format(quantity);
  }
}