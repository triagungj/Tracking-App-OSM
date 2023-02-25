import 'dart:async';
import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:mobile_app/core/constant/enum.dart';
import 'package:mobile_app/core/constant/key_constant.dart';
import 'package:mobile_app/models/response/order_model.dart';
import 'package:mobile_app/services/order_service.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({
    super.key,
    required this.data,
  });

  final OrderModel data;

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  late Timer _timer;
  final markerPointNotifier = ValueNotifier<GeoPoint?>(null);
  final statusNotifier =
      ValueNotifier<OrderStatusType>(OrderStatusType.waiting);

  final orderService = OrderService();
  final controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: -7.7865581, longitude: 110.33559),
  );
  final positionMarker = MarkerIcon(
    iconWidget: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blue,
        child: const Icon(
          FluentIcons.box_16_filled,
          color: Colors.white,
          size: 50,
        ),
      ),
    ),
  );

  Future<void> changePosition(GeoPoint geoPoint, OrderStatusType status) async {
    try {
      if (markerPointNotifier.value != null) {
        await controller.removeMarker(markerPointNotifier.value!);
      }
      markerPointNotifier.value = geoPoint;
      statusNotifier.value = status;
      controller.goToLocation(
        geoPoint,
      );
      await controller.addMarker(
        geoPoint,
        markerIcon: positionMarker,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getTracking() async {
    final result = await orderService.getTrackingOrder(widget.data.id);
    if(result.data?.status == OrderStatusType.done){
      _timer.cancel();
    }

    changePosition(
      GeoPoint(
        latitude: result.data!.latitude!,
        longitude: result.data!.longitude!,
      ),
      result.data!.status,
    );
  }

  @override
  void initState() {
    super.initState();
    statusNotifier.value = widget.data.status;
    Future.delayed(const Duration(seconds: 1), () async {
      await getTracking();
    });
    if (widget.data.status == OrderStatusType.ontheway) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        await getTracking();
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Pengiriman'),
      ),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            trackMyPosition: false,
            initZoom: 12,
            minZoomLevel: 8,
            maxZoomLevel: 19,
            stepZoom: 1.0,
            showZoomController: true,
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: RoadConfiguration(
              startIcon: const MarkerIcon(
                icon: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.brown,
                ),
              ),
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
              defaultMarker: const MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Nama Barang: '),
                        Text(
                          widget.data.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Status Pesanan: '),
                        ValueListenableBuilder<OrderStatusType>(
                          valueListenable: statusNotifier,
                          builder: (context, value, widget) {
                            return Text(
                              value == OrderStatusType.waiting
                                  ? 'Menunggu Penjemputan'
                                  : value == OrderStatusType.ontheway
                                      ? 'Sedang Diantar'
                                      : 'Pesanan Selesai',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Driver:'),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(80)),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
