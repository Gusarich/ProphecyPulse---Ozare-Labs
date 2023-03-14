// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livescore_api/livescore_api.dart';

import '../../../livescore_repository/test/src/testing_data.dart';

void main() {
  LivescoreApiClient _client;
  group('LivescoreApi', () {
    test('can be instantiated', () {
      expect(LivescoreApiClient(), isNotNull);
    });

    test(
      'getLeagues',
      () async {
        _client = LivescoreApiClient();
        final dataBasket = await _client.getLeagues(
          'basketball',
        );
        final dataSoccer = await _client.getLeagues(
          'soccer',
        );

        print('Basket:: $dataBasket');
        print('Soccer:: $dataSoccer');

        expect(dataBasket, isNotEmpty);
        expect(dataSoccer, isNotEmpty);
        expect(dataSoccer, isNot(equals(dataBasket)));
      },
    );
  });
}
