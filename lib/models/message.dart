import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData['message'],jsonData['id']);
  }
}
