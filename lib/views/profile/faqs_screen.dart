import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/app_list_constants.dart';
import 'package:gowild_mobile/constants/app_text_constants.dart';
import 'package:gowild_mobile/models/faq_model.dart';
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

  final List<FAQModel> faqs = AppListConstants.faqs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'FAQS',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How can we help you',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 25,
              ),
             Expanded(child: buildFAQList())
            ],
          ),
        ),

    );
  }

  Widget buildFAQList() => ListView.separated(
    separatorBuilder: (BuildContext ctx , int index) => const SizedBox(height: 15,),
    itemBuilder: (BuildContext context, int index){
    FAQModel faq = faqs[index];
    return FaqsExpandableContainer(question: faq.question, answer: faq.answer);
  }, itemCount: faqs.length,);
}
