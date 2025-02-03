import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:find_friend/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../data/services/location_service.dart';
import '../data/model/user.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  late User user;
  MapScreen({required this.user, super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  _MapScreenState() {
    _moveToCurrentLocation();
  }
  final List<MapObject> mapObjects = [];
  void setData() async {
    final currentLocation = await LocationService().getCurrentLocation();
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: currentLocation.lat,
            longitude: currentLocation.long,
          ),
          zoom: 11,
        ),
      ),
    );
    final users = await AuthRepository().getUsers();
    for (int i = 0; i < users.length; i++) {
      mapObjects.add(PlacemarkMapObject(
        mapId: MapObjectId(users[i].id),
        opacity: 1,
        point: Point(
          latitude: double.parse(users[i].lat),
          longitude: double.parse(users[i].long),
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            anchor: const Offset(0.5, 1),
            scale: 0.7,
            image: BitmapDescriptor.fromBytes(
                await loadNetworkImage(users[i].image)),
          ),
        ),
        onTap: (object, point) {
          if (context.mounted) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _launchGoogleMaps(users[i].lat, users[i].long);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 10, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.5),
                                  width: 2,
                                  style: BorderStyle.solid)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/route.png",
                                  width: 24,
                                  height: 24,
                                  color: const Color(0xFFF5BE00)),
                              const SizedBox(width: 8),
                              const Text(
                                "Marshurt",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ));
      setState(() {});
    }
  }

  Future<Uint8List> loadNetworkImage(String imageUrl) async {
    final response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    if (response.statusCode == 200) {
      return response.data as Uint8List;
    } else {
      throw Exception('Image download failed!');
    }
  }

  void _launchGoogleMaps(String lat, String long) async {
    final Uri googleMapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$long',
    );

    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Google Mapsni ochib bo‘lmadi';
    }
  }

  Future<void> _moveToCurrentLocation() async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: double.parse(widget.user.lat),
            longitude: double.parse(widget.user.long),
          ),
          zoom: 15,
        ),
      ),
    );
    mapObjects.add(PlacemarkMapObject(
      mapId: MapObjectId(widget.user.id),
      opacity: 1,
      point: Point(
        latitude: double.parse(widget.user.lat),
        longitude: double.parse(widget.user.long),
      ),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          anchor: Offset(0.5, 1),
          scale: 0.7,
          image: BitmapDescriptor.fromBytes(
              await loadNetworkImage(widget.user.image)),
        ),
      ),
      onTap: (object, point) {
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchGoogleMaps(widget.user.lat, widget.user.long);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 10, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withOpacity(.5),
                                width: 2,
                                style: BorderStyle.solid)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/route.png",
                                width: 24,
                                height: 24,
                                color: const Color(0xFFF5BE00)),
                            const SizedBox(width: 8),
                            const Text(
                              "Marshurt",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: YandexMap(
      onMapCreated: (controller) {
        mapControllerCompleter.complete(controller);
      },
      zoomGesturesEnabled: true,
      mapObjects: mapObjects,
    ));
  }
}
