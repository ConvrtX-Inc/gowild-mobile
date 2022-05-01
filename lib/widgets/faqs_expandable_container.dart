import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;
import 'package:gowild_mobile/constants/image_constants.dart';

class FaqsExpandableContainer extends StatelessWidget {
  FaqsExpandableContainer({
    required this.question,
    required this.answer,
    Key? key,
    // this.isExpanded = false,
    this.onIconTap,
  }) : super(key: key);
  final String question;
  // final bool isExpanded;
  final String answer;
  final VoidCallback? onIconTap;

  String arrowForward =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.arrowForward}';
  String arrowDown =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.arrowDown}';
  ValueNotifier<bool> expanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: expanded,
        builder: (context, bool isExpanded, _) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isExpanded ? Color(0xFF00755e) : Colors.transparent,
                border: Border.all(color: AppColorConstants.secondaryGray)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          question,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: isExpanded ? 20 : 17,
                              fontWeight: isExpanded
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: !isExpanded
                                  ? AppColorConstants.secondaryGray
                                  : Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          expanded.value = !expanded.value;
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColorConstants.primaryRed,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                                isExpanded ? arrowDown : arrowForward)),
                      )
                    ],
                  ),
                ),
                if (isExpanded)
                  Text(
                    answer,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
              ],
            ),
          );
        });
  }
}
