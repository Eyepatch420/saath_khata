import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../shared/models/link_model.dart';
import '../../../../shared/models/product_template.dart';
import '../../../../shared/models/schedule_model.dart';
import '../../../schedule/domain/repositories/schedule_repository.dart';
import '../../data/repositories/template_repository.dart';

part 'bulk_charge_state.dart';

class BulkChargeCubit extends Cubit<BulkChargeState> {
  static const _m = 'BulkCharge';
  final TemplateRepository _repo;
  final ScheduleRepository _scheduleRepo;

  BulkChargeCubit(this._repo, this._scheduleRepo)
    : super(const BulkChargeState());

  Future<void> loadTemplates() async {
    emit(state.copyWith(templatesLoading: true, templateError: null));
    try {
      // Merge saved bulk-charge templates with the vendor's active Schedule
      // (F005) services, so a service created there can be bulk-charged too
      // without needing a separate template.
      final results = await Future.wait([
        _repo.getTemplates(),
        _scheduleRepo.getServices().catchError((Object e) {
          AppLogger.w(
            _m,
            'Failed to load schedule services for bulk charge: $e',
          );
          return <ScheduledService>[];
        }),
      ]);
      final templates = results[0] as List<ProductTemplate>;
      final services = results[1] as List<ScheduledService>;
      final fromServices = services
          .where(
            (s) =>
                s.isActive && s.unit != null && s.defaultPricePerUnit != null,
          )
          .map(
            (s) => ProductTemplate(
              id: s.id,
              vendorId: '',
              name: s.name,
              unit: s.unit!,
              pricePerUnit: s.defaultPricePerUnit!,
              isActive: s.isActive,
              createdAt: s.createdAt,
              isScheduleService: true,
            ),
          )
          .toList();
      emit(
        state.copyWith(
          templates: [...templates, ...fromServices],
          templatesLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          templatesLoading: false,
          templateError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void selectTemplate(ProductTemplate template) {
    emit(state.copyWith(selectedTemplate: template, quantities: {}));
  }

  void setQuantity(String linkId, double qty) {
    final updated = Map<String, double>.from(state.quantities);
    if (qty <= 0) {
      updated.remove(linkId);
    } else {
      updated[linkId] = qty;
    }
    emit(state.copyWith(quantities: updated));
  }

  Future<void> createTemplate({
    required String name,
    required String unit,
    required double pricePerUnit,
  }) async {
    try {
      final t = await _repo.createTemplate(
        name: name,
        unit: unit,
        pricePerUnit: pricePerUnit,
      );
      final updated = [...state.templates, t];
      emit(
        state.copyWith(templates: updated, selectedTemplate: t, quantities: {}),
      );
    } catch (e) {
      emit(
        state.copyWith(
          templateError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> updateTemplate({
    required String id,
    required String name,
    required String unit,
    required double pricePerUnit,
  }) async {
    try {
      final updated = await _repo.updateTemplate(
        id: id,
        name: name,
        unit: unit,
        pricePerUnit: pricePerUnit,
      );
      final templates = state.templates
          .map((t) => t.id == id ? updated : t)
          .toList();
      final sel = state.selectedTemplate?.id == id
          ? updated
          : state.selectedTemplate;
      emit(state.copyWith(templates: templates, selectedTemplate: sel));
    } catch (e) {
      emit(
        state.copyWith(
          templateError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> deleteTemplate(String id) async {
    try {
      await _repo.deleteTemplate(id);
      final updated = state.templates.where((t) => t.id != id).toList();
      final sel = state.selectedTemplate?.id == id
          ? null
          : state.selectedTemplate;
      emit(
        state.copyWith(
          templates: updated,
          selectedTemplate: sel,
          quantities: {},
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          templateError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<BulkChargeResult?> submitCharge(
    List<CustomerLinkItem> customers,
  ) async {
    final template = state.selectedTemplate;
    if (template == null) return null;

    final items = state.quantities.entries
        .where((e) => e.value > 0)
        .map((e) => BulkChargeItem(linkId: e.key, quantity: e.value))
        .toList();

    if (items.isEmpty) return null;

    emit(state.copyWith(isSubmitting: true, submitError: null));
    try {
      final result = await _repo.bulkCharge(
        templateId: template.id,
        isScheduleService: template.isScheduleService,
        items: items,
      );
      emit(state.copyWith(isSubmitting: false, quantities: {}));
      return result;
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          submitError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      return null;
    }
  }
}
