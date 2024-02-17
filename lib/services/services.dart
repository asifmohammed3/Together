import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiProvider {
  final String _baseUrl = "https://api-stg.together.buzz";

  Future<List<Items>> fetchItems(int page, int pageSize) async {
    final response = await http.get(Uri.parse("$_baseUrl/mocks/discovery?page=$page&limit=$pageSize"));
    final responseBody = response.body;
    List jsonResponse = json.decode(responseBody.toString())['data'];
    return jsonResponse.map((item) => Items.fromJson(item)).toList();
  }
}

class Items {
  final int id;
  final String title;
  final String description;
  final String image_url;
  Items({
required this.id,
required this.title,
required this.description,
required this.image_url
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    image_url: json['image_url']
    );
  }
}