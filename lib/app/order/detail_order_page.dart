import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/app/order/order_tracking_page.dart';
import 'package:mobile_app/core/constant/enum.dart';
import 'package:mobile_app/core/constant/key_constant.dart';
import 'package:mobile_app/models/response/order_model.dart';

class DetailOrderPage extends StatefulWidget {
  const DetailOrderPage({
    super.key,
    required this.data,
  });

  final OrderModel data;

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMMEEEEd('id');
    var dateString = format.format(DateTime.parse(widget.data.dateOrder));

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(FluentIcons.box_24_filled, size: 100),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        widget.data.name,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(dateString),
                      const SizedBox(height: 2),
                      Text(
                          widget.data.status == OrderStatusType.waiting
                              ? 'Menunggu Penjemputan'
                              : widget.data.status == OrderStatusType.ontheway
                                  ? 'Sedang Diantar'
                                  : 'Pesanan Selesai',
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Tempat Asal',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                          Text(widget.data.origin),
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
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                          Text(widget.data.destination),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Driver',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(80)),
                      child: widget.data.driver.avatar != null
                          ? Image.network(
                              widget.data.driver.avatar!,
                              width: 80,
                              height: 80,
                            )
                          : Image.asset(
                              KeyConstant.dummyPathImage,
                              width: 80,
                              height: 80,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            widget.data.driver.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.data.driver.noHp,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(FluentIcons.location_20_regular),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Text('Lacak Pengiriman'),
            ],
          ),
        ),
        onPressed: () => Get.to<void>(
          () => OrderTrackingPage(
            data: widget.data,
          ),
        ),
      ),
    );
  }
}
