// String makeApiUrlDEV(String path) => 'http://localhost:3000/$path'; // ios
//String makeApiUrlDEV(String path) => 'http://192.168.3.3:3000/$path'; // android
// String makeApiUrlDEV(String path) => 'http://192.168.0.153:3000/$path'; // android

// String makeApiUrlDEV(String path) => 'https://personal-sys-backend.herokuapp.com/$path'; // android

import 'package:helpers/helpers.dart';

String makeApiUrlDEV(String path) => '${Environment.apiBaseUsr}/$path';
