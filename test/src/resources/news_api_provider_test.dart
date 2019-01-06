import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds should return List of IDs', () async {
    final newsApi = NewsApiProvider();
    final data = [1, 2, 3, 4];
    newsApi.client = MockClient((request) async {
      return Response(json.encode(data), 200);
    });
    final ids = await newsApi.fetchTopIds();

    expect(ids, data);
  });

  test('fetchItem should retune a Item Model', () async {
    final newsApi = NewsApiProvider();
    final jsonMap = {'id': 123};
    newsApi.client = MockClient((request) async {
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchItem(999);
    expect(item.id, jsonMap['id']);
  });
}
