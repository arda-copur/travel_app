import 'package:flutter_dotenv/flutter_dotenv.dart';

//Dotenv initialization for environment variables
Future<void> initializeDotenv() async {
  await dotenv.load(fileName: ".env");
}
