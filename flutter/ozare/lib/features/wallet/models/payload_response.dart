import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload_response.freezed.dart';
part 'payload_response.g.dart';

@freezed
class Payload with _$Payload {
  const factory Payload({
    required String type,
    required int uid,
    required String from,
    bool? outcome,
    int? amount,
    String? address,
    bool? result,
  }) = _Payload;

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
}

@freezed
class Response with _$Response {
  const factory Response({
    required String status,
    required String message,
    dynamic data,
  }) = _Response;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}
