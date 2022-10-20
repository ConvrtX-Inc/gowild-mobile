import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild/constants/app_text_constants.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FaqsScreen extends HookConsumerWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'FAQS',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'How can we help you',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
              SizedBox(
                height: 25,
              ),
              FaqsExpandableContainer(
                question: 'How do I send gift?',
                answer: AppTextConstants.loremIpsum,
                // isExpanded: isExpanded,
              ),
              SizedBox(
                height: 15,
              ),
              FaqsExpandableContainer(
                question: 'What method of payment does Go Wild History accept?',
                answer:
                    r'Go Wild History accepts variety of payment methods which includes PayPal, Bitcoin, Bank trasnfers, Credit/Debit Cards, Google Pay, Apple Pay',
                // isExpanded: isExpanded,
              ),
              SizedBox(
                height: 15,
              ),
              FaqsExpandableContainer(
                question: 'How do I place a cancellation request?',
                answer: AppTextConstants.loremIpsum,
                // isExpanded: isExpanded,
              ),
              SizedBox(
                height: 15,
              ),
              FaqsExpandableContainer(
                question: 'How do I edit or remove a method?',
                answer: AppTextConstants.loremIpsum,
                // isExpanded: isExpanded,
              ),
              SizedBox(
                height: 15,
              ),
              FaqsExpandableContainer(
                question: 'Can I get refund of the money sent?',
                answer: AppTextConstants.loremIpsum,
                // isExpanded: isExpanded,
              )
            ],
          ),
        ),
      ),
    );
  }
}

String arrowForward =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.arrowForward}';
String arrowDown = '${ImageAssetPath.imagePathSvg}${ImageAssetName.arrowDown}';

class FaqsExpandableContainer extends HookWidget {
  const FaqsExpandableContainer(
      {required this.question,
      required this.answer,
      this.onIconTap,
      super.key});

  final String question;
  final String answer;
  final VoidCallback? onIconTap;

  @override
  Widget build(BuildContext context) {
    final expanded = useValueNotifier(false);

    return ValueListenableBuilder(
      valueListenable: expanded,
      builder: (context, bool isExpanded, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isExpanded ? const Color(0xFF00755e) : Colors.transparent,
              border: Border.all(color: secondaryGray)),
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
                            fontWeight:
                                isExpanded ? FontWeight.w700 : FontWeight.w600,
                            color: !isExpanded ? secondaryGray : Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        expanded.value = !expanded.value;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: primaryRed,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          isExpanded ? arrowDown : arrowForward,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (isExpanded)
                Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
