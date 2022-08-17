import 'package:gowild_mobile/models/faq_model.dart';

class AppListConstants {
  const AppListConstants();

  static List<FAQModel> faqs = [
    const FAQModel(
        question: 'Can anyone sign up for the treasure hunts?',
        answer:
            'No, you must be 18 years or older to participate in treasure hunts outside of your home.'),
    const FAQModel(
        question:
            "What if I don't have cell phone service in the area where I think the treasure chest is?",
        answer:
            'There is no cellular service that is favored when the treasure chest is placed. We can confirm that the area the treasure chest is hidden does have cell phone service but we can not confirm the consistency of individual service providers or which one was used when testing the site. Different carriers have different service areas.'),
    const FAQModel(
        question: 'How can I purchase a ticket for the prize hunts?',
        answer:
            'You can click on the link in the website or use the app to go directly to the hunt you are wanting to participate in and follow the steps it takes you through. Tickets are limited on most prize hunts so get your tickets before they sell out.'),
    const FAQModel(
        question:
            'What if I feel like doing something dangerous or stupid while searching for the treasure chest?',
        answer: "Don't"),
    const FAQModel(
        question: 'How old do I have to be to participate in prize hunts?',
        answer:
            'Anyone over the age of 18, thats uploaded their ID for verification, and read the e-waivers/ disclaimers can sign up and claim the prizes in our Treasure Wild hunts.'),
    const FAQModel(
        question:
            'What if multiple people get to the location of the treasure chest at the same time?',
        answer:
            'The winner will be whoever logs the timestamped treasure chest through the app and is first received and verified by Go Wild History.')
  ];
}
