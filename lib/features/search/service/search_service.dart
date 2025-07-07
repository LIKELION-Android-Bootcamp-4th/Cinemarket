import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:dio/dio.dart';

class SearchService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: 'http://git.hansul.kr:3000')
  );

  Future<List<SearchItem>> fetchSearchResults(String keyword) async {
    try {
      final response = await _dio.get(
          '/api/products',
          queryParameters: {
            'search': keyword
          },
        options: Options(
          headers: {
            'X-Company-Code': '6866fd245b230f5dc709bdf3',
            'Content-Type': 'application/json',
          }
        ),
      );
      final items = response.data['data']['items'] as List;
      return items.map((e) => SearchItem.fromJson(e)).toList();
    } catch (e) {
      if (e is DioError) {
        print('❌ DioError: ${e.response?.statusCode}');
        print('응답: ${e.response?.data}');
      } else {
        print('❌ Unknown error: $e');
      }
      rethrow;
    }
  }
}