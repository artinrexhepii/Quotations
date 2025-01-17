import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/quotations/presentation/screens/quotations_list_screen.dart';
import '../../modules/quotations/presentation/screens/quotation_detail_screen.dart';
import '../../modules/quotations/presentation/screens/create_quotation_screen.dart';
import '../../modules/quotations/presentation/bloc/quotation_bloc.dart';

class AppRouter {
  static const String home = '/';
  static const String create = '/create';
  static const String detail = '/quotation/:id';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => QuotationsListScreen(),
      ),
      GoRoute(
        path: create,
        builder: (context, state) => CreateQuotationScreen(),
      ),
      GoRoute(
        path: detail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final bloc = context.read<QuotationBloc>();
          if (bloc.state is QuotationLoaded) {
            final quotations = (bloc.state as QuotationLoaded).quotations;
            final quotation = quotations.firstWhere((q) => q.id == id);
            return QuotationDetailScreen(quotation: quotation);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ],
  );
}
