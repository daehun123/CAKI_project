/*import 'package:group_button/group_button.dart';
import 'package:flutter/material.dart';
import 'package:caki_project/Components/constants.dart';

List<String> alcoholGroup = [
  '보드카',
  '럼',
  '브랜디',
  '위스키',
  '리큐르',
  '진',
  '데킬라',
];

GroupButton buildAlcoholGroupButton(
    BuildContext context, // Context 추가
    GroupButtonController controller,
    Function(String, int, bool) onSelected) {
  return GroupButton(
    buttons: alcoholGroup,
    options: GroupButtonOptions(
      selectedShadow: const [],
      unselectedShadow: const [],
      selectedTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      selectedColor: kColor,
      unselectedColor: Colors.grey,
      unselectedTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10),
      spacing: 5,
      buttonWidth: MediaQuery.of(context).size.width / 2.4,
    ),
    isRadio: false,
    controller: controller,
    onSelected: onSelected,
  );
}
*/