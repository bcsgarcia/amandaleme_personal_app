import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static late EnvironmentType _currentEnv;

  static Future loadDotEnv(EnvironmentType envType) async {
    _currentEnv = envType;
    await dotenv.load(fileName: Environment.fileName);
  }

  static String get fileName => _currentEnv == EnvironmentType.prod ? '.env' : '.env';
  static EnvironmentType get env => _currentEnv;

  static String get apiBaseUsr => dotenv.env['API_BASE_URL'] ?? 'MY_FALLBACK';
  static String get appPath => dotenv.env['APP_PATH'] ?? 'MY_FALLBACK';
  static String get getMeetAppPath => dotenv.env['GET_MEET_APP_PATH'] ?? 'MY_FALLBACK';
  static String get appHomePath => dotenv.env['APP_HOME_PATH'] ?? 'MY_FALLBACK';
  static String get notificationPath => dotenv.env['NOTIFICATION_PATH'] ?? 'MY_FALLBACK';
  static String get workoutsheetPath => dotenv.env['WORKOUTSHEET_PATH'] ?? 'MY_FALLBACK';
  static String get workoutPath => dotenv.env['WORKOUT_PATH'] ?? 'MY_FALLBACK';
  static String get authPath => dotenv.env['AUTH_PATH'] ?? 'MY_FALLBACK';
  static String get companyId => dotenv.env['COMPANY_ID'] ?? 'MY_FALLBACK';
  static String get refreshTokenPath => dotenv.env['REFRESH_TOKEN_PATH'] ?? 'MY_FALLBACK';
  static String get screenPath => dotenv.env['SCREEN_PATH'] ?? 'MY_FALLBACK';
  static String get updateUnreadNotificationPath => dotenv.env['UPDATE_UNREAD_NOTIFICATION_PATH'] ?? 'MY_FALLBACK';
  static String get allMediaSyncPath => dotenv.env['ALL_MEDIA_SYNC_PATH'] ?? 'MY_FALLBACK';
  static String get changePassPath => dotenv.env['CHANGE_PASS_PATH'] ?? 'MY_FALLBACK';
  static String get myMediasDirectoryPath => dotenv.env['MY_MEDIAS_DIRECTORY_PATH'] ?? 'MY_FALLBACK';
  static String get feedbackPath => dotenv.env['FEEDBACK_PATH'] ?? 'MY_FALLBACK';
  static String get workoutsheetDonePath => dotenv.env['WORKOUTSHEET_DONE_PATH'] ?? 'MY_FALLBACK';
}
