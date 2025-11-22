import 'dart:convert';

import 'package:fdelux_source_neytrip/core/errors/exceptions.dart';
import 'package:fdelux_source_neytrip/data/data_sources/local/session_local_data_source.dart';
import 'package:fdelux_source_neytrip/data/models/destination_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class DestinationRemoteDataSource {
  Future<List<DestinationModel>> fetchPopular();
  Future<List<DestinationModel>> fetchNearby(
    double latitude,
    double longitude,
    double radius,
  );
  Future<DestinationModel> findById(int id);
}

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  static const String _baseURL = 'https://fdelux.globeapp.dev/api/destinations';

  final http.Client _client;
  final SessionLocalDataSource _sessionLocalDataSource;

  const DestinationRemoteDataSourceImpl({
    required http.Client client,
    required SessionLocalDataSource sessionLocalDataSource,
  }) : _sessionLocalDataSource = sessionLocalDataSource,
       _client = client;

  Future<String> _getAuthHeader() async {
    final tokenModel = await _sessionLocalDataSource.getAuthToken();
    if (tokenModel == null || tokenModel.accessToken.isEmpty) {
      throw const UnauthenticatedException(
        message: 'Authentication token missing.',
      );
    }
    return 'Bearer ${tokenModel.accessToken}';
  }

  @override
  Future<List<DestinationModel>> fetchPopular() async {
    try {
      final String authHeader = await _getAuthHeader();
      final Uri uri = Uri.parse('$_baseURL/popular');
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authHeader,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        final List<dynamic> destinationsJson =
            responseBody['data']['destinations'] as List<dynamic>;
        final List<DestinationModel> destinations = await compute(
          _parseJsonArrayDestinations,
          destinationsJson,
        );
        return destinations;
      }

      String errorMessage =
          responseBody['message'] ?? 'An unknown error occurred.';

      if (statusCode == 401) {
        throw UnauthenticatedException(
          message: errorMessage,
          statusCode: statusCode,
        );
      }

      throw ServerException(
        message:
            'Failed to fetch popular destinations. Status code: $statusCode, Body: ${response.body}',
        statusCode: statusCode,
        error: response.body,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error: ${e.message}', error: e);
    } on FormatException catch (e) {
      throw DataParsingException(
        message: 'Invalid response format from server: ${e.message}',
        error: e,
      );
    } on TypeError catch (e) {
      throw DataParsingException(
        message: 'Unexpected data type during parsing: ${e.toString()}',
        error: e,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DestinationModel>> fetchNearby(
    double latitude,
    double longitude,
    double radius,
  ) async {
    try {
      final String authHeader = await _getAuthHeader();
      final Uri uri = Uri.parse('$_baseURL/nearby');
      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authHeader,
        },
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longitude,
          'radius': radius,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        final List<dynamic> destinationsJson =
            responseBody['data']['destinations'] as List<dynamic>;
        final List<DestinationModel> destinations = await compute(
          _parseJsonArrayDestinations,
          destinationsJson,
        );
        return destinations;
      }

      String errorMessage =
          responseBody['message'] ?? 'An unknown error occurred.';

      if (statusCode == 401) {
        throw UnauthenticatedException(
          message: errorMessage,
          statusCode: statusCode,
        );
      }

      if (statusCode == 404) {
        throw NotFoundException(message: errorMessage, statusCode: statusCode);
      }

      throw ServerException(
        message:
            'Failed to fetch nearby destinations. Status code: $statusCode, Body: ${response.body}',
        statusCode: statusCode,
        error: response.body,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error: ${e.message}', error: e);
    } on FormatException catch (e) {
      throw DataParsingException(
        message: 'Invalid response format from server: ${e.message}',
        error: e,
      );
    } on TypeError catch (e) {
      throw DataParsingException(
        message: 'Unexpected data type during parsing: ${e.toString()}',
        error: e,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DestinationModel> findById(int id) async {
    try {
      final String authHeader = await _getAuthHeader();
      final Uri uri = Uri.parse('$_baseURL/$id');
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authHeader,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return DestinationModel.fromJson(
          responseBody['data']['destination'] as Map<String, dynamic>,
        );
      }

      String errorMessage =
          responseBody['message'] ?? 'An unknown error occurred.';

      if (statusCode == 401) {
        throw UnauthenticatedException(
          message: errorMessage,
          statusCode: statusCode,
        );
      }

      if (statusCode == 404) {
        throw NotFoundException(message: errorMessage, statusCode: statusCode);
      }

      throw ServerException(
        message:
            'Failed to fetch destination by ID. Status code: $statusCode, Body: ${response.body}',
        statusCode: statusCode,
        error: response.body,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error: ${e.message}', error: e);
    } on FormatException catch (e) {
      throw DataParsingException(
        message: 'Invalid response format from server: ${e.message}',
        error: e,
      );
    } on TypeError catch (e) {
      throw DataParsingException(
        message: 'Unexpected data type during parsing: ${e.toString()}',
        error: e,
      );
    } catch (e) {
      rethrow;
    }
  }
}

List<DestinationModel> _parseJsonArrayDestinations(
  List<dynamic> jsonArrayDestinations,
) {
  return jsonArrayDestinations
      .map((item) => DestinationModel.fromJson(item as Map<String, dynamic>))
      .toList();
}
