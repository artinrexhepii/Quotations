import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quotation.dart';
import '../../domain/usecases/create_quotation.dart';
import '../../domain/usecases/delete_quotation.dart';
import '../../domain/usecases/get_all_quotations.dart';
import '../../domain/usecases/get_quotation_by_id.dart';
import '../../domain/usecases/update_quotation.dart';

// Events
abstract class QuotationEvent {}

class LoadQuotations extends QuotationEvent {}

class LoadQuotationById extends QuotationEvent {
  final String id;
  LoadQuotationById(this.id);
}

class CreateQuotationEvent extends QuotationEvent {
  final Quotation quotation;
  CreateQuotationEvent(this.quotation);
}

class UpdateQuotationEvent extends QuotationEvent {
  final Quotation quotation;
  UpdateQuotationEvent(this.quotation);
}

class DeleteQuotationEvent extends QuotationEvent {
  final String id;
  DeleteQuotationEvent(this.id);
}

// States
abstract class QuotationState {}

class QuotationLoading extends QuotationState {}

class QuotationLoaded extends QuotationState {
  final List<Quotation> quotations;
  final Quotation? selectedQuotation;

  QuotationLoaded({
    required this.quotations,
    this.selectedQuotation,
  });
}

class QuotationError extends QuotationState {
  final String message;
  QuotationError(this.message);
}

class QuotationBloc extends Bloc<QuotationEvent, QuotationState> {
  final GetAllQuotations getAllQuotations;
  final GetQuotationById getQuotationById;
  final CreateQuotation createQuotation;
  final UpdateQuotation updateQuotation;
  final DeleteQuotation deleteQuotation;

  QuotationBloc({
    required this.getAllQuotations,
    required this.getQuotationById,
    required this.createQuotation,
    required this.updateQuotation,
    required this.deleteQuotation,
  }) : super(QuotationLoading()) {
    on<LoadQuotations>(_onLoadQuotations);
    on<LoadQuotationById>(_onLoadQuotationById);
    on<CreateQuotationEvent>(_onCreateQuotation);
    on<UpdateQuotationEvent>(_onUpdateQuotation);
    on<DeleteQuotationEvent>(_onDeleteQuotation);
  }

  Future<void> _onLoadQuotations(LoadQuotations event, Emitter<QuotationState> emit) async {
    emit(QuotationLoading());
    try {
      final quotations = await getAllQuotations();
      emit(QuotationLoaded(quotations: quotations));
    } catch (e) {
      emit(QuotationError(e.toString()));
    }
  }

  Future<void> _onLoadQuotationById(LoadQuotationById event, Emitter<QuotationState> emit) async {
    emit(QuotationLoading());
    try {
      final quotation = await getQuotationById(event.id);
      final quotations = await getAllQuotations();
      emit(QuotationLoaded(
        quotations: quotations,
        selectedQuotation: quotation,
      ));
    } catch (e) {
      emit(QuotationError(e.toString()));
    }
  }

  Future<void> _onCreateQuotation(CreateQuotationEvent event, Emitter<QuotationState> emit) async {
    try {
      await createQuotation(event.quotation);
      add(LoadQuotations());
    } catch (e) {
      emit(QuotationError(e.toString()));
    }
  }

  Future<void> _onUpdateQuotation(UpdateQuotationEvent event, Emitter<QuotationState> emit) async {
    try {
      await updateQuotation(event.quotation);
      add(LoadQuotations());
    } catch (e) {
      emit(QuotationError(e.toString()));
    }
  }

  Future<void> _onDeleteQuotation(DeleteQuotationEvent event, Emitter<QuotationState> emit) async {
    try {
      await deleteQuotation(event.id);
      add(LoadQuotations());
    } catch (e) {
      emit(QuotationError(e.toString()));
    }
  }
}
