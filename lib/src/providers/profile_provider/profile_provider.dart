import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class ProfileProvider extends ChangeNotifier {
  final NotificationManager _notificationManager = NotificationManager();
  final bool _showTextField = true;
  bool _isDarkTheme = true;
  bool _isNotificationsEnabled = true;
  File? _image;
  String _userName = "";
  File? get image => _image;
  String get userName => _userName;
  bool get isDarkTheme => _isDarkTheme;
  bool get showTextField => _showTextField;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void updateProfile({File? image, String? name}) {
    if (image != null) _image = image;
    if (name != null) _userName = name;
    notifyListeners();
  }

  void updateUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    await _notificationManager.showNotificationAction(value);
    _isNotificationsEnabled = _notificationManager.notificationsEnabled;
    notifyListeners();
  }

  Future<void> rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<void> saveProfile() async {
    if (_userName.isNotEmpty && _image != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _userName);
      await prefs.setString('userImage', _image!.path);
      notifyListeners();
    }
  }

  void reset() {
    _image = null;
    _userName = '';
    notifyListeners();
  }
}

class NotificationManager {
  bool notificationsEnabled = false;
  bool qrlPermissionDeniedOnceYUI = false;

  Future<void> checkNotificationPermission() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var permissionStatus = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: false,
          badge: false,
          sound: false,
        );

    notificationsEnabled = permissionStatus ?? false;
  }

  Future<void> showNotificationAction(bool value) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var permissionGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: value,
          badge: value,
          sound: value,
        );

    if (permissionGranted == true) {
      notificationsEnabled = value;
      // Сохранение состояния в файл или SharedPreferences, если необходимо
    } else {
      notificationsEnabled = false;
      qrlPermissionDeniedOnceYUI = true;
      // Сохранение состояния отказа в файл или SharedPreferences, если необходимо
    }
  }

  // Дополнительно, можно добавить методы для сохранения и загрузки предпочтений
}
