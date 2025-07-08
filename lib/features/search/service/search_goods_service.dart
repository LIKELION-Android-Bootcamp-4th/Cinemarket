import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:dio/dio.dart';

class SearchGoodsService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: 'http://git.hansul.kr:3000')
  );

  Future<List<SearchItem>> fetchGoodsByContentId(int contentId) async {
    final response = await _dio.get(
      '/api/content-product/products/$contentId',
      options: Options(
        headers: {
          'X-Company-Code': '6866fd245b230f5dc709bdf3',
          'Content-Type': 'application/json',
        }
      ),
    );

    final List items = response.data['data']['items'];
    return items.map((e) => SearchItem.fromJson(e)).toList();
  }
}