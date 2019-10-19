import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static Future<List<Message>> browse({status = "important"}) async {
    // String content = await rootBundle.loadString('data/message.json');

    String url = status == "important"
        ? "http://www.mocky.io/v2/5daae5c53100007d00becde5"
        : "http://www.mocky.io/v2/5da864c71200001100edae5f";

    http.Response response = await http.get(url);

    await Future.delayed(Duration(seconds: 1));

    String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages =
        collection.map((json) => Message.fromJson(json)).toList();
    return _messages;
  }
}
