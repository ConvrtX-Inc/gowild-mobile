import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';

import '../../constants/colors.dart';

class EwaiverScreen extends StatelessWidget {
  const EwaiverScreen({Key? key}) : super(key: key);
  final bool _value = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: primaryYellow),
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Text(
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
                          value: _value,
                          activeColor: Colors.white,
                          onChanged: (_) {
                            // setState(() => _foo = value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('I agree with local laws and taxes terms',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                mainAuthButton(context, 'I Agree', () {}),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}
