// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Payload _$$_PayloadFromJson(Map<String, dynamic> json) => _$_Payload(
      type: json['type'] as String,
      uid: json['uid'] as int,
      outcome: json['outcome'] as String?,
      amount: json['amount'] as int?,
      address: json['address'] as String?,
      result: json['result'] as bool?,
    );

Map<String, dynamic> _$$_PayloadToJson(_$_Payload instance) =>
    <String, dynamic>{
      'type': instance.type,
      'uid': instance.uid,
      'outcome': instance.outcome,
      'amount': instance.amount,
      'address': instance.address,
      'result': instance.result,
    };

_$_Response _$$_ResponseFromJson(Map<String, dynamic> json) => _$_Response(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$_ResponseToJson(_$_Response instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
