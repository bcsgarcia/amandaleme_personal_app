import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'http.dart';

abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  });

  Future<dynamic> send({
    required String url,
    required Uint8List fileData,
    String filename,
    Map? headers,
  });
}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({required String url, required String method, Map? body, Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'content-type': 'application/json', 'accept': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      if (method == 'post') {
        futureResponse = client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == 'put') {
        futureResponse = client.put(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == 'download') {
        futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
        response = await futureResponse.timeout(Duration(minutes: 3));

        return _handleResponse(response, bodyBytes: true);
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(Duration(seconds: 10));
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  @override
  Future<dynamic> send({
    required String url,
    required Uint8List fileData,
    String filename = 'file.jpg',
    Map? headers,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'content-type': 'application/json', 'accept': 'application/json'});

    var uri = Uri.parse(url);
    var request = MultipartRequest('POST', uri)
      ..headers.addAll(defaultHeaders)
      ..files.add(MultipartFile.fromBytes(
        'file',
        fileData,
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ));

    try {
      var streamedResponse = await client.send(request);
      var response = await Response.fromStream(streamedResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw HttpError.serverError;
      }

      return _handleResponse(response);
    } catch (e) {
      throw HttpError.serverError;
    }
  }

  dynamic _handleResponse(Response response, {bool bodyBytes = false}) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isEmpty
            ? null
            : bodyBytes
                ? response.bodyBytes
                : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpBadRequestException;
      case 401:
        throw HttpUnauthorizedException;
      case 403:
        throw HttpForbiddenException;
      case 404:
        throw HttpNotFoundException;
      default:
        throw HttpServerErrorException;
    }
  }
}
