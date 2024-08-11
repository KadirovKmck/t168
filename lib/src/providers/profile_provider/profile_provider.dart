import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class ProfileProvider extends ChangeNotifier {
  final NotificationManager _notificationManager = NotificationManager();

  final bool _showTextField = true;
  bool _isNotificationsEnabled = false;
  File? _image;
  String _userName = "";

  File? get image => _image;
  String get userName => _userName;
  bool get showTextField => _showTextField;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  final ImagePicker _picker = ImagePicker();

  ProfileProvider() {
    _loadProfile(); // Load the profile data when the provider is initialized
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? "";
    String? imagePath = prefs.getString('userImage');
    if (imagePath != null && imagePath.isNotEmpty) {
      _image = File(imagePath);
    }
    _isNotificationsEnabled = prefs.getBool('isNotificationsEnabled') ?? false;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await saveProfile(); // Save profile whenever the image is picked
      notifyListeners();
    }
  }

  Future<void> deleteAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    reset();
  }


  void updateProfile({File? image, String? name}) async {
    if (image != null) _image = image;
    if (name != null) _userName = name;
    await saveProfile(); // Save profile whenever the data is updated
    notifyListeners();
  }

  void updateUserName(String name) async {
    _userName = name;
    await saveProfile(); // Save profile whenever the username is updated
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    await _notificationManager.showNotificationAction(value);
    _isNotificationsEnabled = _notificationManager.notificationsEnabled;
    await _saveNotificationPreference(); // Save notification preference
    notifyListeners();
  }

  Future<void> _saveNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationsEnabled', _isNotificationsEnabled);
  }

  Future<void> rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    if (_image != null) {
      await prefs.setString('userImage', _image!.path);
    }
  }

  void reset() async {
    _image = null;
    _userName = '';
    await saveProfile(); // Save profile whenever it is reset
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
    } else {
      notificationsEnabled = false;
      qrlPermissionDeniedOnceYUI = true;
    }
  }
}
