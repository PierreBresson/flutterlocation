// Ignored since there is a bug in the coverage report tool
// https://github.com/dart-lang/coverage/issues/339
// coverage:ignore-file
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:location_platform_interface/location_platform_interface.dart';

export 'package:location_platform_interface/location_platform_interface.dart'
    show PermissionStatus, LocationAccuracy, LocationData;

class Location implements LocationPlatform {
  /// Initializes the plugin and starts listening for potential platform events.
  factory Location() => instance;

  Location._();

  static Location instance = Location._();

  /// Change settings of the location request.
  ///
  /// The [accuracy] argument is controlling the precision of the
  /// [LocationData]. The [interval] and [distanceFilter] are controlling how
  /// often a new location is sent through [onLocationChanged].
  ///
  /// [interval] and [distanceFilter] are not used on web.
  @override
  Future<bool> changeSettings({
    LocationAccuracy? accuracy = LocationAccuracy.high,
    int? interval = 1000,
    double? distanceFilter = 0,
  }) {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.changeSettings(
        accuracy: accuracy,
        interval: interval,
        distanceFilter: distanceFilter,
      );
    } else {
      return Future.value(false);
    }
  }

  /// Checks if service is enabled in the background mode.
  @override
  Future<bool> isBackgroundModeEnabled() {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.isBackgroundModeEnabled();
    } else {
      return Future.value(false);
    }
  }

  /// Enables or disables service in the background mode.
  @override
  Future<bool> enableBackgroundMode({bool? enable = true}) {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.enableBackgroundMode(enable: enable);
    } else {
      return Future.value(false);
    }
  }

  /// Gets the current location of the user.
  ///
  /// Throws an error if the app has no permission to access location.
  /// Returns a [LocationData] object.
  @override
  Future<LocationData> getLocation() async {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.getLocation();
    } else {
      return Future.value(LocationData.fromMap({}));
    }
  }

  /// Checks if the app has permission to access location.
  ///
  /// If the result is [PermissionStatus.deniedForever], no dialog will be
  /// shown on [requestPermission].
  /// Returns a [PermissionStatus] object.
  @override
  Future<PermissionStatus> hasPermission() {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.hasPermission();
    } else {
      return Future.value(PermissionStatus.denied);
    }
  }

  /// Requests permission to access location.
  ///
  /// If the result is [PermissionStatus.deniedForever], no dialog will be
  /// shown on [requestPermission].
  /// Returns a [PermissionStatus] object.
  @override
  Future<PermissionStatus> requestPermission() {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.requestPermission();
    } else {
      return Future.value(PermissionStatus.denied);
    }
  }

  /// Checks if the location service is enabled.
  @override
  Future<bool> serviceEnabled() {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.serviceEnabled();
    } else {
      return Future.value(false);
    }
  }

  /// Request the activation of the location service.
  @override
  Future<bool> requestService() {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.requestService();
    } else {
      return Future.value(false);
    }
  }

  /// Returns a stream of [LocationData] objects.
  /// The frequency and accuracy of this stream can be changed with
  /// [changeSettings]
  ///
  /// Throws an error if the app has no permission to access location.
  @override
  Stream<LocationData> get onLocationChanged {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.onLocationChanged;
    } else {
      return StreamController<LocationData>().stream;
    }
  }

  /// Change options of sticky background notification on Android.
  ///
  /// This method only applies to Android and allows for customizing the
  /// notification, which is shown when [enableBackgroundMode] is set to true.
  ///
  /// Uses [title] as the notification's content title and searches for a
  /// drawable resource with the given [iconName]. If no matching resource is
  /// found, no icon is shown. The content text will be set to [subTitle], while
  /// the sub text will be set to [description]. The notification [color] can
  /// also be customized.
  ///
  /// When [onTapBringToFront] is set to true, tapping the notification will
  /// bring the activity back to the front.
  ///
  /// Both [title] and [channelName] will be set to defaults, if no values are
  /// provided. All other null arguments will be ignored.
  ///
  /// Returns [AndroidNotificationData] if the notification is currently being
  /// shown. This can be used to change the notification from other parts of the
  /// app.
  ///
  /// For Android SDK versions above 25, uses [channelName] for the
  /// [NotificationChannel](https://developer.android.com/reference/android/app/NotificationChannel).
  @override
  Future<AndroidNotificationData?> changeNotificationOptions({
    String? channelName,
    String? title,
    String? iconName,
    String? subtitle,
    String? description,
    Color? color,
    bool? onTapBringToFront,
  }) {
    if (Platform.isAndroid) {
      return LocationPlatform.instance.changeNotificationOptions(
        channelName: channelName,
        title: title,
        iconName: iconName,
        subtitle: subtitle,
        description: description,
        color: color,
        onTapBringToFront: onTapBringToFront,
      );
    } else {
      return Future.value(null);
    }
  }
}
