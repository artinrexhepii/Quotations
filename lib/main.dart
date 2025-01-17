import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'core/utils/constants.dart';
import 'core/routing/app_router.dart';
import 'modules/quotations/data/models/quotation_model.dart';
import 'modules/quotations/data/models/customer_info_model.dart';
import 'modules/quotations/data/models/line_item_model.dart';
import 'modules/quotations/data/repositories/quotation_repository_impl.dart';
import 'modules/quotations/data/datasources/hive_datasource.dart';
import 'modules/quotations/domain/usecases/get_all_quotations.dart';
import 'modules/quotations/domain/usecases/get_quotation_by_id.dart';
import 'modules/quotations/domain/usecases/create_quotation.dart';
import 'modules/quotations/domain/usecases/update_quotation.dart' as use_cases;
import 'modules/quotations/domain/usecases/delete_quotation.dart' as use_cases;
import 'modules/quotations/presentation/bloc/quotation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Register Hive Adapters
    Hive.registerAdapter(QuotationModelAdapter());
    Hive.registerAdapter(CustomerInfoModelAdapter());
    Hive.registerAdapter(LineItemModelAdapter());

    // Open Hive Box
    final quotationsBox = await Hive.openBox<QuotationModel>('quotations');
    final dataSource = HiveDataSource(quotationsBox);

    runApp(MyApp(dataSource: dataSource));
  } catch (e) {
    debugPrint('Failed to initialize app: $e');
    runApp(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Container(
            color: AppColors.background,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
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
                      'Failed to initialize app',
                      style: AppTextStyles.headline2.copyWith(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(
                      e.toString(),
                      style: AppTextStyles.body1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final LocalDataSource dataSource;

  const MyApp({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    final repository = QuotationRepositoryImpl(dataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider<QuotationBloc>(
          create: (context) => QuotationBloc(
            getAllQuotations: GetAllQuotations(repository),
            getQuotationById: GetQuotationById(repository),
            createQuotation: CreateQuotation(repository),
            updateQuotation: use_cases.UpdateQuotation(repository),
            deleteQuotation: use_cases.DeleteQuotation(repository),
          )..add(LoadQuotations()),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            background: AppColors.background,
          ),
          scaffoldBackgroundColor: AppColors.background,
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
            ),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
