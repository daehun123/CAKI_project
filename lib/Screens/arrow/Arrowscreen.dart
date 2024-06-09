import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../Components/constants.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/main_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class ArrowScreen extends StatefulWidget {
  @override
  _ArrowScreenState createState() => _ArrowScreenState();
}

final picker = ImagePicker();
XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class _ArrowScreenState extends State<ArrowScreen> {
  final arrow_formkey = GlobalKey<FormState>();
  String _title = '';
  String _category = '';
  String _alcoholcategory = '';
  String _description = '';
  String _sugarcontent = '';
  String _alcoholconcentration = '';
  String _etc = '';

  //카테고리 종류 목록
  List<String> _categories = ['classic', 'expert', 'simple', 'BFYB'];

  // 레시피 술 종류 목록
  List<String> _alcoholcategories = [
    '보드카',
    '럼',
    '브랜디',
    '위스키',
    '리큐르',
    '진',
    '데킬라',
    '소주',
    '맥주',
    '막걸리'
  ];

  final List<String> _sugar = [
    '당도3',
    '당도2',
    '당도1',
  ];

  List<String> _alcohol = [
    '도수3',
    '도수2',
    '도수1',
  ];

  List<String> _etcall = [
    '탄산',
    '과일',
    '우유/크림',
  ];

  List<String> ingredients = []; // 재료 목록을 저장할 리스트
  static const storage = FlutterSecureStorage();

  // 토큰을 헤더에 추가하여 POST 요청을 보내는 메서드입니다.
  Future<void> uploadRecipe() async {
    // 이미지를 base64로 인코딩하고 데이터 URI 스키마를 사용하도록 수정
    List<String> base64Images = [];
    for (var image in images) {
      if (image != null) {
        List<int> imageBytes = await image.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        String extension = image.path.split('.').last;
        base64Images.add('data:image/$extension;base64,$base64Image');
      }
    }

    // 재료를 "재료: " 형식으로 변환
    String ingredientsText = "재료: ";
    for (int i = 0; i < ingredients.length; i += 2) {
      if (i + 1 < ingredients.length) {
        ingredientsText += "${ingredients[i]} ${ingredients[i + 1]}, ";
      } else {
        ingredientsText += ingredients[i];
      }
    }

    // FormData 생성
    FormData formData = FormData.fromMap({
      "post_body": jsonEncode({
        "title": _title,
        "text": "${ingredientsText}\n제조법${_description}"
      }),
      "post_tag": jsonEncode([
        _category,
        _alcoholcategory,
        _alcoholconcentration,
        _sugarcontent,
        _etc
      ]),
    });

    for (var image in images) {
      if (image != null) {
        formData.files.add(MapEntry(
          "post_image",
          await MultipartFile.fromFile(image.path, filename: image.name),
        ));
      }
    }

    // 백엔드로 보내기 전에 데이터를 출력
    print('보낼 데이터: ${formData.fields}');

    // POST 요청
    var url = 'http://13.124.205.29/createpost/';
    var dio = Dio();
    String? access_token = await storage.read(key: 'jwt_accessToken');

    try {
      var response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $access_token'},
        ),
      );
      // 응답 처리
      if (response.statusCode == 200) {
        print('업로드 성공');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('업로드 완료'),
              content: Text('레시피가 성공적으로 업로드되었습니다.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    setState(() {
                      images.clear(); // 이미지 리스트를 비워줍니다.
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('업로드 실패: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('업로드 실패'),
              content: Text('레시피 업로드에 실패했습니다. 다시 시도해주세요.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('업로드 중 오류 발생: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('업로드 오류'),
            content: Text('업로드 중 오류가 발생했습니다. 다시 시도해주세요.'),
            actions: <Widget>[
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('업 로 드'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 아이콘 설정
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage()), // 설정 페이지로 이동
            );
          },
        ),
        backgroundColor: kColor, // 엡바 색상 설정
      ),
      body: Form(
        key: arrow_formkey, // 폼 키 설정
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: '레시피 제목'),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: '카테고리'),
              value: _category.isEmpty ? null : _category,
              // 빈 문자열이 아닌 경우에만 value 설정
              items: _categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            // 술 종류 선택
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: '술 종류'),
              value: _alcoholcategory.isEmpty ? null : _alcoholcategory,
              // 빈 문자열이 아닌 경우에만 value 설정
              items: _alcoholcategories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _alcoholcategory = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            // 도수 선택
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: '도수'),
              value: _alcoholconcentration.isEmpty ? null : _alcoholconcentration,
              // 빈 문자열이 아닌 경우에만 value 설정
              items: _alcohol.map((String alcohol) {
                return DropdownMenuItem(
                  value: alcohol,
                  child: Text(alcohol),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _alcoholconcentration = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),
            Center(
              child: Text(
                '1=20%미만, 2=20%이상40%미만, 3=40%이상',
                textAlign: TextAlign.center, // 이 줄은 텍스트를 센터 정렬로 합니다
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100, // 텍스트 굵기 줄이기
                ), // 원하는 경우 텍스트 스타일 설정
              ),
            ),
            SizedBox(height: 16.0),
            // 당도 선택
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: '당도'),
              value: _sugarcontent.isEmpty ? null : _sugarcontent,
              // 빈 문자열이 아닌 경우에만 value 설정
              items: _sugar.map((String sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text(sugar),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _sugarcontent = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '필수 입력 항목입니다.';
                }
                return null;
              },
            ),SizedBox(height: 16.0),
            // 기타 선택
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: '기타'),
              value: _etc.isEmpty ? null : _etc,
              // 빈 문자열이 아닌 경우에만 value 설정
              items: _etcall.map((String sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text(sugar),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _etc = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            // 재료추가
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 추가된 재료 입력 칸들
                for (int i = 0; i < ingredients.length; i += 2)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    // 재료가 변경되면 해당 위치에 재료를 저장함
                                    ingredients[i] = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: '재료',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '필수 입력 항목입니다.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              if (i + 1 < ingredients.length)
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        // 재료가 변경되면 해당 위치에 재료를 저장함
                                        ingredients[i + 1] = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'oz/스푼/개',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '필수 입력 항목입니다.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              IconButton(
                                onPressed: () {
                                  // 해당 줄의 재료를 삭제함
                                  setState(() {
                                    ingredients.removeAt(i);
                                    if (i - 1 < ingredients.length) {
                                      ingredients.removeAt(i); // 두 번째 요소도 삭제
                                    }
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                // 추가하기 버튼
                TextButton(
                  onPressed: () {
                    // 버튼을 누르면 재료 입력 칸이 두 개씩 늘어남
                    setState(() {
                      ingredients.add('');
                      ingredients.add('');
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 5),
                      Text('추가하기'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Text(
              '레시피 제작 사진을 넣어주세요\n대표하는 사진을 가장 처음에 넣어주세요',
              style: TextStyle(
                color: Colors.red, // 텍스트 색상을 red로 변경
              ),
            ),
            Row(
              children: [
                // 카메라로 촬영하기
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kColor, // 변경된 부분
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.camera);
                      // 카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.black, // 변경된 부분
                    ),
                  ),
                ),
                // 갤러리에서 가져오기
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kColor, // 변경된 부분
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      multiImage = await picker.pickMultiImage();
                      setState(() {
                        // 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                        images.addAll(multiImage);
                        // 추가된 이미지 파일의 경로를 콘솔에 출력합니다.
                        for (int i = 0; i < multiImage.length; i++) {
                          print('이미지 파일 경로: ${multiImage[i]?.path}');
                        }
                      });
                    },

                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.black, // 변경된 부분
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: images.length,
                // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 1 개의 행에 보여줄 사진 개수
                  childAspectRatio: 1 / 1, // 사진 의 가로 세로의 비율
                  mainAxisSpacing: 10, // 수평 Padding
                  crossAxisSpacing: 10, // 수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover, // 사진을 크기를 상자 크기에 맞게 조절
                            image: FileImage(
                              File(images[index]!
                                  .path), // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // 삭제 버튼
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                            // 버튼을 누르면 해당 이미지가 삭제됨
                            setState(() {
                              images.remove(images[index]);
                            });
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: '레시피 추가 설명'),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (arrow_formkey.currentState!.validate()) {
                  uploadRecipe(); // 업로드 버튼을 누르면 uploadRecipe 메서드 호출
                }
              },
              child: Text('업로드'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
