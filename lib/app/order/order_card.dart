import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/models/response/order_model.dart';
import 'package:mobile_app/core/constant/enum.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.data,
    this.onTap,
  });

  final OrderModel data;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMd('id');
    var dateString = format.format(DateTime.parse(data.dateOrder));

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              const SizedBox(
                child: Icon(FluentIcons.box_24_filled, size: 48),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tanggal Order',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(dateString),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Status',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(
                                data.status == OrderStatusType.waiting
                                    ? 'Menunggu'
                                    : data.status == OrderStatusType.ontheway
                                        ? 'Diantar'
                                        : 'Selesai',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tempat Asal',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(data.origin),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Icon(FluentIcons.arrow_right_16_regular),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tempat Tujuan',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(data.destination),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
