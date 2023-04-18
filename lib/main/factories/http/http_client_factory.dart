import 'package:http/http.dart';
import 'package:http_adapter/http_adapter.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());
