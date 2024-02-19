// Generated by Celest. This file should not be modified manually, but
// it can be checked into version control.
// ignore_for_file: type=lint, unused_local_variable, unnecessary_cast, unnecessary_import

library;

import 'dart:convert';

import 'package:celest/celest.dart';
import 'package:celest_backend/src/links/exceptions.dart';
import 'package:celest_backend/src/links/models.dart';
import 'package:celest_core/src/exception/cloud_exception.dart';

import '../../client.dart';

class CelestFunctions {
  final clicks = CelestFunctionsClicks();

  final links = CelestFunctionsLinks();
}

class CelestFunctionsClicks {
  Future<int> getClicksNumber(int linkId) async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/clicks/get-clicks-number'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({r'linkId': linkId}),
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return ($body['response'] as num).toInt();
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }
}

class CelestFunctionsLinks {
  Future<List<Link>> getLink() async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/links/get-link'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return ($body['response'] as Iterable<Object?>)
          .map((el) => Serializers.instance.deserialize<Link>(el))
          .toList();
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }

  Future<Link> createLink(LinkRequest linkRequest) async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/links/create-link'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({
        r'linkRequest': Serializers.instance.serialize<LinkRequest>(linkRequest)
      }),
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return Serializers.instance.deserialize<Link>($body['response']);
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'InvalidLinkDataException':
        throw Serializers.instance
            .deserialize<InvalidLinkDataException>($details);
      case r'CreateLinkException':
        throw Serializers.instance.deserialize<CreateLinkException>($details);
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }

  Future<Link> deleteLink(int id) async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/links/delete-link'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({r'id': id}),
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return Serializers.instance.deserialize<Link>($body['response']);
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'DeleteLinkException':
        throw Serializers.instance.deserialize<DeleteLinkException>($details);
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }
}
