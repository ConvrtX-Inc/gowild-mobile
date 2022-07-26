import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/app_text_constants.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/expandable_container.dart';
import 'package:gowild_mobile/widgets/faqs_expandable_container.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
            children: [
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
                question: 'Can I getx refund of the money sent?',
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
