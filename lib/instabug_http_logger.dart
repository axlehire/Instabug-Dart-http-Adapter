import 'package:instabug_flutter/NetworkLogger.dart';
import 'package:instabug_flutter/models/network_data.dart';
import 'package:http/http.dart' as http;

class InstabugHttpLogger {
  void onLooger(http.Response response, {DateTime? startTime}) {
    final Map<String, dynamic> requestHeaders = <String, dynamic>{};
    response.request!.headers.forEach((String header, dynamic value) {
      requestHeaders[header] = value[0];
    });

    final http.Request? request = response.request as http.Request;

    if (request == null) {
      return;
    }

    final NetworkData requestData = NetworkData(
      startTime: startTime!,
      method: request.method,
      url: request.url.toString(),
      requestHeaders: requestHeaders,
      requestBody: request.body,
    );

    final DateTime endTime = DateTime.now();

    final Map<String, dynamic> responseHeaders = <String, dynamic>{};
    response.headers.forEach((String header, dynamic value) {
      responseHeaders[header] = value[0];
    });

    NetworkLogger.networkLog(requestData.copyWith(
      status: response.statusCode,
      duration: endTime.difference(requestData.startTime).inMilliseconds,
      contentType: response.headers.containsKey('content-type')
          ? response.headers['content-type']
          : '',
      responseHeaders: responseHeaders,
      responseBody: response.body,
    ));
  }
}
