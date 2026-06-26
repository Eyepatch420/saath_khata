import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/models/booking_model.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';

// ─── Helpers ──────────────────────────────────────────────────────────────────

String _to12h(String hhmm) {
  final parts = hhmm.split(':');
  int h = int.parse(parts[0]);
  final m = parts[1];
  final period = h < 12 ? 'AM' : 'PM';
  if (h == 0) h = 12;
  if (h > 12) h -= 12;
  return '$h:$m $period';
}

/// Convert 12h TimeOfDay to 'HH:MM' 24h string
String _tod24(TimeOfDay tod) {
  final hh = tod.hour.toString().padLeft(2, '0');
  final mm = tod.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}

bool _slotsOverlap(List<DaySlot> slots) {
  final sorted = List<DaySlot>.from(slots)
    ..sort((a, b) => _toMins(a.startTime).compareTo(_toMins(b.startTime)));
  for (int i = 1; i < sorted.length; i++) {
    if (_toMins(sorted[i].startTime) < _toMins(sorted[i - 1].endTime)) return true;
  }
  return false;
}

int _toMins(String hhmm) {
  final p = hhmm.split(':');
  return int.parse(p[0]) * 60 + int.parse(p[1]);
}

const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const _daysFull = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

// ─── Screen ───────────────────────────────────────────────────────────────────

class VendorScheduleSetupScreen extends StatelessWidget {
  const VendorScheduleSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(getIt())..add(LoadBookingConfig()),
      child: const _ScheduleSetupView(),
    );
  }
}

class _ScheduleSetupView extends StatefulWidget {
  const _ScheduleSetupView();

  @override
  State<_ScheduleSetupView> createState() => _ScheduleSetupViewState();
}

class _ScheduleSetupViewState extends State<_ScheduleSetupView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Local mutable copy of the config being edited
  BookingConfig _config = BookingConfig.empty();
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _applyConfig(BookingConfig config) {
    if (!_hasLoaded) {
      setState(() {
        _config = config;
        _hasLoaded = true;
      });
    }
  }

  void _addSlot(int day) async {
    final result = await showDialog<DaySlot>(
      context: context,
      builder: (_) => _AddSlotDialog(existingSlots: _config.slotsForDay(day)),
    );
    if (result == null) return;
    final updated = List<DaySlot>.from(_config.slotsForDay(day))..add(result);
    updated.sort((a, b) => _toMins(a.startTime).compareTo(_toMins(b.startTime)));
    setState(() => _config = _config.withUpdatedDay(day, updated));
  }

  void _editSlot(int day, int slotIndex) async {
    final existing = _config.slotsForDay(day)[slotIndex];
    final others = List<DaySlot>.from(_config.slotsForDay(day))..removeAt(slotIndex);
    final result = await showDialog<DaySlot>(
      context: context,
      builder: (_) => _AddSlotDialog(
        existingSlots: others,
        initial: existing,
      ),
    );
    if (result == null) return;
    final updated = List<DaySlot>.from(_config.slotsForDay(day));
    updated[slotIndex] = result;
    updated.sort((a, b) => _toMins(a.startTime).compareTo(_toMins(b.startTime)));
    setState(() => _config = _config.withUpdatedDay(day, updated));
  }

  void _deleteSlot(int day, int slotIndex) {
    final updated = List<DaySlot>.from(_config.slotsForDay(day))..removeAt(slotIndex);
    setState(() => _config = _config.withUpdatedDay(day, updated));
  }

  void _toggleEnabled(int day, int slotIndex, bool value) {
    final updated = List<DaySlot>.from(_config.slotsForDay(day));
    updated[slotIndex] = updated[slotIndex].copyWith(isEnabled: value);
    setState(() => _config = _config.withUpdatedDay(day, updated));
  }

  void _toggleFull(int day, int slotIndex, bool value) {
    final updated = List<DaySlot>.from(_config.slotsForDay(day));
    updated[slotIndex] = updated[slotIndex].copyWith(isFull: value);
    setState(() => _config = _config.withUpdatedDay(day, updated));
    // Also persist toggle to backend immediately
    context.read<BookingBloc>().add(ToggleSlotFull(
          dayOfWeek: day,
          startTime: updated[slotIndex].startTime,
          isFull: value,
        ));
  }

  void _save() {
    context.read<BookingBloc>().add(SaveBookingConfig(_config));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingConfigLoaded) {
          _applyConfig(state.config);
        } else if (state is BookingConfigSaved) {
          _applyConfig(state.config);
          AppToast.show(context, 'Schedule saved!', type: ToastType.success);
          if (context.mounted) context.pop();
        } else if (state is BookingConfigError) {
          AppToast.show(context, state.message, type: ToastType.error);
          if (state.config != null) _applyConfig(state.config!);
        }
      },
      builder: (context, state) {
        final isLoading = state is BookingConfigLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text('Manage Schedule', style: AppTypography.h3),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.primary,
              unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.5),
              indicatorColor: AppColors.primary,
              tabs: List.generate(
                7,
                (i) => Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_days[i], style: AppTypography.bodySmall.copyWith(fontSize: 11)),
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: _config.slotsForDay(i).isNotEmpty
                              ? AppColors.primary
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                TextButton(
                  onPressed: _save,
                  child: Text(
                    'Save',
                    style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                  ),
                ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: List.generate(7, (day) => _DayTab(
              day: day,
              slots: _config.slotsForDay(day),
              onAdd: () => _addSlot(day),
              onEdit: (i) => _editSlot(day, i),
              onDelete: (i) => _deleteSlot(day, i),
              onToggleEnabled: (i, v) => _toggleEnabled(day, i, v),
              onToggleFull: (i, v) => _toggleFull(day, i, v),
            )),
          ),
        );
      },
    );
  }
}

// ─── Day Tab ──────────────────────────────────────────────────────────────────

class _DayTab extends StatelessWidget {
  final int day;
  final List<DaySlot> slots;
  final VoidCallback onAdd;
  final ValueChanged<int> onEdit;
  final ValueChanged<int> onDelete;
  final void Function(int, bool) onToggleEnabled;
  final void Function(int, bool) onToggleFull;

  const _DayTab({
    required this.day,
    required this.slots,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleEnabled,
    required this.onToggleFull,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _daysFull[day],
                    style: AppTypography.h3,
                  ),
                ),
                TextButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                  label: const Text('Add Slot'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        if (slots.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.event_available_rounded,
                    size: 48,
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No slots for ${_daysFull[day]}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap "Add Slot" to set your availability',
                    style: AppTypography.bodySmall.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _SlotCard(
                  slot: slots[i],
                  index: i,
                  onEdit: () => onEdit(i),
                  onDelete: () => onDelete(i),
                  onToggleEnabled: (v) => onToggleEnabled(i, v),
                  onToggleFull: (v) => onToggleFull(i, v),
                ),
                childCount: slots.length,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Slot Card ────────────────────────────────────────────────────────────────

class _SlotCard extends StatelessWidget {
  final DaySlot slot;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleEnabled;
  final ValueChanged<bool> onToggleFull;

  const _SlotCard({
    required this.slot,
    required this.index,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleEnabled,
    required this.onToggleFull,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDisabled = !slot.isEnabled;
    final cardColor = isDisabled
        ? colorScheme.surface.withValues(alpha: 0.5)
        : colorScheme.surface;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: slot.isFull
              ? AppColors.warning.withValues(alpha: 0.5)
              : isDisabled
                  ? colorScheme.outline.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: isDisabled
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
      ),
      child: Column(
        children: [
          // ── Header row ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDisabled
                        ? colorScheme.outline.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.access_time_rounded,
                    size: 18,
                    color: isDisabled ? colorScheme.outline : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_to12h(slot.startTime)} – ${_to12h(slot.endTime)}',
                      style: AppTypography.labelLarge.copyWith(
                        color: isDisabled
                            ? colorScheme.onSurface.withValues(alpha: 0.4)
                            : colorScheme.onSurface,
                        decoration: isDisabled ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (slot.isFull)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'SLOTS FULL',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 10,
                              color: AppColors.warning,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                // Edit
                IconButton(
                  onPressed: isDisabled ? null : onEdit,
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: isDisabled
                        ? colorScheme.outline.withValues(alpha: 0.3)
                        : AppColors.primary,
                  ),
                  tooltip: 'Edit slot',
                ),
                // Delete
                IconButton(
                  onPressed: () => _confirmDelete(context),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: AppColors.error.withValues(alpha: isDisabled ? 0.4 : 1),
                  ),
                  tooltip: 'Delete slot',
                ),
              ],
            ),
          ),
          // ── Toggle row ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Row(
              children: [
                // Available toggle
                Expanded(
                  child: _ToggleRow(
                    label: 'Available',
                    value: slot.isEnabled,
                    activeColor: AppColors.success,
                    onChanged: onToggleEnabled,
                  ),
                ),
                const SizedBox(width: 8),
                // Slot Full toggle
                Expanded(
                  child: _ToggleRow(
                    label: 'Slots Full',
                    value: slot.isFull,
                    activeColor: AppColors.warning,
                    onChanged: slot.isEnabled ? onToggleFull : null,
                    tooltip: slot.isEnabled
                        ? 'Mark this slot as fully booked'
                        : 'Enable slot first',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Slot'),
        content: Text(
          'Remove the ${_to12h(slot.startTime)} – ${_to12h(slot.endTime)} slot?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final Color activeColor;
  final ValueChanged<bool>? onChanged;
  final String? tooltip;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.activeColor,
    required this.onChanged,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final enabled = onChanged != null;
    return Tooltip(
      message: tooltip ?? '',
      child: Row(
        children: [
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: activeColor,
            activeTrackColor: activeColor.withValues(alpha: 0.4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: enabled
                  ? colorScheme.onSurface.withValues(alpha: 0.7)
                  : colorScheme.onSurface.withValues(alpha: 0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Add / Edit Slot Dialog ───────────────────────────────────────────────────

class _AddSlotDialog extends StatefulWidget {
  final List<DaySlot> existingSlots;
  final DaySlot? initial;

  const _AddSlotDialog({required this.existingSlots, this.initial});

  @override
  State<_AddSlotDialog> createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<_AddSlotDialog> {
  late TimeOfDay _start;
  late TimeOfDay _end;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      final sp = widget.initial!.startTime.split(':');
      final ep = widget.initial!.endTime.split(':');
      _start = TimeOfDay(hour: int.parse(sp[0]), minute: int.parse(sp[1]));
      _end = TimeOfDay(hour: int.parse(ep[0]), minute: int.parse(ep[1]));
    } else {
      _start = const TimeOfDay(hour: 9, minute: 0);
      _end = const TimeOfDay(hour: 10, minute: 0);
    }
  }

  Future<void> _pickStart() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _start,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _start = picked);
  }

  Future<void> _pickEnd() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _end,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _end = picked);
  }

  void _confirm() {
    final startStr = _tod24(_start);
    final endStr = _tod24(_end);

    if (_toMins(endStr) <= _toMins(startStr)) {
      setState(() => _error = 'End time must be after start time');
      return;
    }

    // Check overlap with existing slots
    final candidate = DaySlot(startTime: startStr, endTime: endStr);
    final testList = [...widget.existingSlots, candidate];
    if (_slotsOverlap(testList)) {
      setState(() => _error = 'This slot overlaps with an existing one');
      return;
    }

    Navigator.pop(context, candidate);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEdit = widget.initial != null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEdit ? 'Edit Time Slot' : 'Add Time Slot',
              style: AppTypography.h3,
            ),
            const SizedBox(height: 6),
            Text(
              'Select start and end time in 12-hour format',
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _TimePickerButton(
                    label: 'Start',
                    time: _start,
                    onTap: _pickStart,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '–',
                    style: AppTypography.h3.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                Expanded(
                  child: _TimePickerButton(
                    label: 'End',
                    time: _end,
                    onTap: _pickEnd,
                  ),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.error_outline_rounded, size: 16, color: AppColors.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _error!,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _confirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEdit ? 'Update' : 'Add',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePickerButton extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  const _TimePickerButton({
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final formatted = time.format(context); // system locale 12h
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatted,
                    style: AppTypography.labelLarge.copyWith(color: AppColors.primary),
                  ),
                ),
                Icon(Icons.schedule_rounded, size: 16, color: AppColors.primary.withValues(alpha: 0.7)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
