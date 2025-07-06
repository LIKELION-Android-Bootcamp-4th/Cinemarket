import 'package:cinemarket/features/home/model/box_office_movie.dart';
import 'package:dio/dio.dart';
import 'package:cinemarket/core/network/kobis_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class KobisService {
  final Dio _dio = KobisClient.dio;

  Future<List<BoxOfficeMovie>> fetchDailyBoxOffice(String date) async {
    final apiKey = dotenv.env['KOBIS_API_KEY'] ?? '';
    final url = '/boxoffice/searchDailyBoxOfficeList.json';

    try {
      final response = await _dio.get(url, queryParameters: {
        'key': apiKey,
        'targetDt': date,
      });

      final List<dynamic>? dailyList = response.data['boxOfficeResult']?['dailyBoxOfficeList'];

      if (dailyList == null) return [];

      return dailyList.map((json) => BoxOfficeMovie.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
