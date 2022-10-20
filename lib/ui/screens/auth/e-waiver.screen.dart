import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EWaiverScreen extends HookConsumerWidget {
  const EWaiverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final checked = useState(false);

    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: primaryYellow),
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: const Text(
          'E-WAIVER',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w400, color: primaryYellow),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 30,
          ),
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 15,
                ),
                child: Text(
                  'Bacon ipsum dolor amet ribeye short loin pig chuck beef. Flank capicola shoulder, pork chop chislic chicken cupim pancetta pork turkey porchetta salami meatball pastrami venison. Ham tongue burgdoggen tri-tip boudin alcatra, doner meatball ground round filet mignon. Kevin tri-tip ham hock, jowl boudin capicola bresaola meatball venison meatloaf. Flank filet mignon venison hamburger corned beef ground round t-bone bresaola shank cupim sausage swine shoulder boudin sirloin. Burgdoggen t-bone shank andouille capicola cupim. Rump shank ham short ribs biltong',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 15,
                ),
                child: Text(
                  'Bacon ipsum dolor amet ribeye short loin pig chuck beef. Flank capicola shoulder, pork chop chislic chicken cupim pancetta pork turkey porchetta salami meatball pastrami venison.',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 15,
                ),
                child: Text(
                  'Bacon ipsum dolor amet ribeye short loin pig chuck beef. Flank capicola shoulder, Ham tongue burgdoggen tri-tip boudin alcatra, doner meatball ground round filet mignon. Kevin tri-tip ham hock, jowl boudin capicola bresaola meatball venison meatloaf. Flank filet mignon venison hamburger corned beef ground round t-bone bresaola shank cupim sausage swine shoulder boudin sirloin. Burgdoggen t-bone shank andouille capicola cupim. Rump shank ham short ribs biltong',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 24,
                      width: 27,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Checkbox(
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        value: checked.value,
                        activeColor: primaryBlack,
                        checkColor: primaryBlack,
                        onChanged: (status) {
                          checked.value = status == true;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'I agree with local laws and taxes terms',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MainAuthButtonWidget(
                text: 'I Agree',
                onTap: () {
                  context.beamToNamed('/main');
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
