import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Components/constants.dart';
import '../Main_veiw/Bottom_main.dart';
import '../Main_veiw/main_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ArrowScreen extends StatefulWidget {
  @override
  _ArrowScreenState createState() => _ArrowScreenState();
}

final picker = ImagePicker();
XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class _ArrowScreenState extends State<ArrowScreen> {
  String _title = '';
  String _category = '';
  String _description = '';
  String _weather = '';

  // 레시피 종류 목록
  List<String> _categories = [
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

  List<String> _todayweather = [
    '맑음',
    '비',
    '눈',
    '흐림',
  ];

  List<String> ingredients = []; // 재료 목록을 저장할 리스트

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
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
        backgroundColor: Color(0xFF8A9352), // 엡바 색상 설정
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(labelText: '레시피 제목'),
            onChanged: (value) {
              setState(() {
                _title = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField(
            decoration: InputDecoration(labelText: '술 종류'),
            value: _category.isEmpty ? null : _category, // 빈 문자열이 아닌 경우에만 value 설정
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
          ),
          SizedBox(height: 16.0), // 재료추가
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
                                      labelText: 'g/ml',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            IconButton(
                              onPressed: () {
                                // 해당 줄의 재료를 삭제함
                                setState(() {
                                  ingredients.removeAt(i);
                                  if (i + 1 < ingredients.length) {
                                    ingredients.removeAt(i);
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

          SizedBox(height: 16.0),
          DropdownButtonFormField(
            decoration: InputDecoration(labelText: '어울리는 날씨'),
            value: _weather.isEmpty ? null : _weather, // 빈 문자열이 아닌 경우에만 value 설정
            items: _todayweather.map((String category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _weather = value!;
              });
            },
          ),
          SizedBox(height: 16.0),
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
              itemCount: images.length, // 보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
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
                            File(images[index]!.path), // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
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
              // 업로드 로직을 여기에 추가해주세요
              // _title, _category, _description 변수에 저장된 데이터를 사용하여 레시피를 업로드합니다.
            },
            child: Text('업로드'),
          ),
        ],
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
