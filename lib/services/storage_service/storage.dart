import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:practical_task/models/user_model.dart';
import 'package:practical_task/utils/app_utils.dart';
import 'package:practical_task/utils/logger_utils.dart';
import 'package:practical_task/utils/path_utils.dart';

import 'const.dart';

class Storage {
  static Storage? _instance;
  late BoxCollection _boxCollection;

  late CollectionBox _userBox;
  late CollectionBox _lanBox;

  static Storage get instance {
    _instance ??= Storage._();
    return _instance!;
  }

  Storage._();

  Future<void> init() async {
    _boxCollection = await BoxCollection.open(
      "database",
      {
        ConstKey.user,
        ConstKey.lag,
      },
      path: await PathUtils.instance.getTempDir(),
    );

    _userBox = await _boxCollection.openBox(ConstKey.user);
    _lanBox = await _boxCollection.openBox(ConstKey.lag);
  }

  Future<void> deleteAll() async {
    await _boxCollection.deleteFromDisk();
  }

  Future<void> saveUser(UserModel userModel) async {
    try {
      await _userBox.put(ConstKey.user, userModel.toString());
    } catch (e) {
      logger.e(
          "Error on write student in local storage\n Error : ${e.toString()}");
    }
  }

  Future<void> saveLanguage(String locale) async {
    try {
      await _lanBox.put(ConstKey.lag, locale);
    } catch (e) {
      logger.e(
          "Error on write language in local storage\n Error : ${e.toString()}");
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final str = await _userBox.get(ConstKey.user);
      return UserModel.fromString(str);
    } catch (e) {
      logger.e("There is no student model save in local storage");
      return UserModel();
    }
  }

  Future<String?> getLanguage() async {
    try {
      return await _lanBox.get(ConstKey.lag);
    } catch (e) {
      logger.e("There is no Language save in local storage");
      return "";
    }
  }

  Future<void> removeUser() async {
    try {
      await _userBox.delete(ConstKey.user);
      AppUtils.userModel = UserModel();
    } catch (e) {
      logger.e(
          "Error on removing user details in secure storage\n Error : ${e.toString()}");
    }
  }
}
