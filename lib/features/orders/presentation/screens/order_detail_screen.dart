import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ledger_attachment_service.dart';
import '../../../../shared/models/order_model.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

/// Full order detail, shared by vendor and staff. Vendors can confirm/reject a
/// pending order and deliver a confirmed one; staff can deliver confirmed orders.
/// Customers get a read-only view.
class OrderDetailScreen extends StatelessWidget {
  final Order order;

  /// 'vendor' | 'staff' | 'customer' — controls which actions are shown.
  final String role;

  const OrderDetailScreen({super.key, required this.order, required this.role});

  bool get _canManage => role == 'vendor' || role == 'staff';

  Color _statusColor(OrderStatus s) => switch (s) {
        OrderStatus.pending => AppColors.warning,
        OrderStatus.confirmed => Colors.blue,
        OrderStatus.delivered => AppColors.success,
        OrderStatus.rejected => AppColors.error,
        OrderStatus.cancelled => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listenWhen: (_, curr) => curr is OrderError || curr is OrderLoaded,
      listener: (context, state) {
        if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      builder: (context, state) {
        // Use the freshest copy of this order from the bloc if present.
        final current = state is OrderLoaded
            ? state.orders.firstWhere((o) => o.id == order.id, orElse: () => order)
            : order;
        final busy = state is OrderActionLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Order Details'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _statusHeader(current),
              const SizedBox(height: 16),
              if (current.customerName != null) ...[
                _SectionCard(
                  title: 'Customer',
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                        child: Text(current.customerName![0].toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(current.customerName!)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              _SectionCard(
                title: 'Items (${current.items.length})',
                child: Column(
                  children: [
                    ...current.items.map((it) => _ItemRow(item: it)),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${current.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              if (current.note != null && current.note!.isNotEmpty) ...[
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Order note',
                  child: Text(current.note!,
                      style: const TextStyle(color: AppColors.textSecondary)),
                ),
              ],
              if (current.status == OrderStatus.delivered) ...[
                const SizedBox(height: 12),
                _deliveryProofCard(current),
              ],
              const SizedBox(height: 24),
            ],
          ),
          bottomNavigationBar: _canManage
              ? _actionBar(context, current, busy)
              : null,
        );
      },
    );
  }

  Widget _statusHeader(Order order) {
    final color = _statusColor(order.status);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.receipt_long_rounded, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.status.label,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text('Placed ${_fmt(order.createdAt)}',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryProofCard(Order order) {
    return _SectionCard(
      title: 'Delivery',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order.deliveredByRole != null)
            Text('Marked delivered by ${order.deliveredByRole}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
          if (order.deliveredAt != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(_fmt(order.deliveredAt!),
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
            ),
          if (order.deliveryNote != null && order.deliveryNote!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Note: ${order.deliveryNote}',
                style: const TextStyle(color: AppColors.textSecondary)),
          ],
          if (order.proofUrl != null && order.proofUrl!.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(order.proofUrl!,
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionBar(BuildContext context, Order order, bool busy) {
    final bloc = context.read<OrderBloc>();
    Widget body;
    if (order.status == OrderStatus.pending && role == 'vendor') {
      body = Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: busy
                  ? null
                  : () => bloc.add(UpdateOrderStatus(
                      orderId: order.id, status: OrderStatus.rejected)),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Reject'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: busy
                  ? null
                  : () => bloc.add(UpdateOrderStatus(
                      orderId: order.id, status: OrderStatus.confirmed)),
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Confirm'),
            ),
          ),
        ],
      );
    } else if (order.status == OrderStatus.confirmed) {
      body = FilledButton.icon(
        onPressed: busy ? null : () => _openDeliverySheet(context, bloc, order),
        icon: const Icon(Icons.local_shipping_outlined),
        label: const Text('Mark as Delivered'),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(50),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(padding: const EdgeInsets.all(16), child: body),
    );
  }

  void _openDeliverySheet(BuildContext context, OrderBloc bloc, Order order) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: _DeliveryProofSheet(order: order),
      ),
    );
  }

  static String _fmt(DateTime dt) =>
      '${dt.day}/${dt.month}/${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

class _ItemRow extends StatelessWidget {
  final OrderItem item;
  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final qtyUnit = [
      if (item.qty != null) item.qty,
      if (item.unit != null) item.unit,
    ].join(' ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                if (qtyUnit.isNotEmpty || item.pricePerUnit != null)
                  Text(
                    [
                      if (qtyUnit.isNotEmpty) qtyUnit,
                      if (item.pricePerUnit != null)
                        '@ ₹${item.pricePerUnit!.toStringAsFixed(0)}',
                    ].join('  '),
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.subtotal != null
                ? '₹${item.subtotal!.toStringAsFixed(2)}'
                : '—',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textHint.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.textHint,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// Bottom sheet: optional note + optional photo before marking delivered.
class _DeliveryProofSheet extends StatefulWidget {
  final Order order;
  const _DeliveryProofSheet({required this.order});

  @override
  State<_DeliveryProofSheet> createState() => _DeliveryProofSheetState();
}

class _DeliveryProofSheetState extends State<_DeliveryProofSheet> {
  final _noteCtrl = TextEditingController();
  File? _photo;
  bool _uploading = false;

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (picked != null) setState(() => _photo = File(picked.path));
  }

  Future<void> _confirm() async {
    setState(() => _uploading = true);
    String? proofUrl;
    try {
      if (_photo != null) {
        proofUrl = await getIt<LedgerAttachmentService>().uploadAttachment(
          imageFile: _photo!,
          linkId: widget.order.linkId,
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _uploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Photo upload failed: $e'),
            backgroundColor: AppColors.error),
      );
      return;
    }

    if (!mounted) return;
    context.read<OrderBloc>().add(UpdateOrderStatus(
          orderId: widget.order.id,
          status: OrderStatus.delivered,
          deliveryNote: _noteCtrl.text.trim(),
          proofUrl: proofUrl,
        ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Confirm Delivery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('₹${widget.order.total.toStringAsFixed(2)} will be added to the customer\'s due.',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          TextField(
            controller: _noteCtrl,
            decoration: const InputDecoration(
              labelText: 'Delivery note (optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          if (_photo != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(_photo!,
                  height: 140, width: double.infinity, fit: BoxFit.cover),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickPhoto(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: const Text('Camera'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickPhoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: const Text('Gallery'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _uploading ? null : _confirm,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(50),
            ),
            child: _uploading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : const Text('Mark as Delivered'),
          ),
        ],
      ),
    );
  }
}
