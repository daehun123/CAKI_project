import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FilterResultScreen extends StatelessWidget {
  final List<String> selectedKeywords; // 선택된 키워드 리스트를 받음

  const FilterResultScreen({Key? key, required this.selectedKeywords})
      : super(key: key);


  static const storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> _fetchSearchResults(String selectedItem) async {
    String baseUrl = 'http://13.124.205.29/search';
    String keywords = selectedKeywords.isNotEmpty
        ? selectedKeywords.join(", ")
        : '';

    String url = '$baseUrl?q=&k=$keywords'; // 백엔드 요청 URL

    try {
      // 토큰 가져오기
      String? access_token = await storage.read(key: 'jwt_accessToken');
      // Dio 인스턴스 생성
      Dio dio = Dio();
      // 헤더에 토큰 추가
      dio.options.headers['Authorization'] = 'Bearer $access_token';
      // 요청 보내기
      Response response = await dio.get(url);

      // JSON 데이터 반환
      Map<String, dynamic> data = json.decode(response.toString());

      // 콘솔에 결과값 출력
      print(data);

      return data;
    } catch (error) {
      // 에러 발생 시 빈 맵 반환
      print(error);
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder(
        future: _fetchSearchResults(
            selectedKeywords.isNotEmpty ? selectedKeywords.join(", ") : ''),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> data = snapshot.data ?? {};
              List<dynamic> postList = data['post_list'] != null
                  ? List<dynamic>.from(data['post_list'])
                  : [];
              if (postList.isEmpty) {
                return Center(
                  child: Text('No information found.'),
                );
              } else {
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> post = postList[index];
                    String writerNickname = post['writer_nickname'] ?? '';
                    int postId = post['post_id'] ?? 0;
                    String postTitle = post['post_title'] ?? '';
                    List<String> postImages =
                    List<String>.from(post['post_image'] ?? []);
                    List<String> postTags =
                    List<String>.from(post['post_tag'] ?? []);
                    int postLike = post['post_like'] ?? 0;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    postImages[0],
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        writerNickname,
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        postTitle,
                                        style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if (postTags.isNotEmpty)
                                                for (int i = postTags.length -
                                                    2; i < postTags.length; i++)
                                                  Text(
                                                    '#' + postTags[i] + ' ',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(postLike.toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
        },
      ),
    );
  }
}