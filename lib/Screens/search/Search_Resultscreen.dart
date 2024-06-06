import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../BoardView/board_view_screen.dart';

class ResultScreen extends StatelessWidget {
  final String? selectedItem;

  const ResultScreen({Key? key, this.selectedItem}) : super(key: key);

  static const storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> _fetchSearchResults(String selectedItem) async {
    String baseUrl = 'http://13.124.205.29/search';
    String search = selectedItem ?? ''; // selectedItem이 search로 사용됨

    String url = '$baseUrl?q=$search&k='; // 백엔드 요청 URL

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
        future: _fetchSearchResults(selectedItem ?? ''),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // 응답 데이터 사용
              Map<String, dynamic> data = snapshot.data ?? {};
              List<dynamic> postList = data['post_list'] != null
                  ? List<dynamic>.from(data['post_list'])
                  : [];
              if (postList.isEmpty) {
                // 검색 결과가 없는 경우
                return Center(
                  child: Text('찾는 레시피가 없습니다.'),
                );
              } else {
                // 검색 결과가 있는 경우
                // 결과 화면 생성
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> post = postList[index];
                    // 게시물 정보 추출
                    String writerNickname = post['writer_nickname'] ?? '';
                    int postId = post['post_id'] ?? 0;
                    String postTitle = post['post_title'] ?? '';
                    List<String> postImages =
                    List<String>.from(post['post_image'] ?? []);
                    List<String> postTags =
                    List<String>.from(post['post_tag'] ?? []);
                    int postLike = post['post_like'] ?? 0;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => board_viewer(boardid: postId),
                          ),
                        );
                      },
                      child: Card(
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
                                      postImages.isNotEmpty ? postImages[0] : 'https://via.placeholder.com/100', // 이미지가 없을 때 대체 이미지
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(width: 50),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          writerNickname,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          postTitle,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (postTags.isNotEmpty)
                                                  for (int i = postTags.length - 2; i < postTags.length; i++)
                                                    Text(
                                                      '#' + postTags[i] + ' ',
                                                      style: TextStyle(color: Colors.blue),
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