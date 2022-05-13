import 'package:flutter/material.dart';
import 'package:gowild_mobile/models/tickets.dart';
import 'package:gowild_mobile/services/database.dart';
import 'package:gowild_mobile/views/support/new_ticket_screen.dart';
import 'package:gowild_mobile/views/support/ticket_messages_screen.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';

import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Future<Tickets> getTickets;

  @override
  void initState() {
    super.initState();
    getTickets = Database.getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'SUPPORT',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<Tickets>(
          future: getTickets,
          builder: (BuildContext context, AsyncSnapshot<Tickets> snapshot) {
            print(snapshot.error);

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.tickets.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final Ticket ticket = snapshot.data!.tickets[index];
                    return _ticketCard(ticket);
                  });
            }
            return Container();
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: GrassThemedButton(
          title: 'Send New Ticket',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewTicketScreen())),
        ),
      ),
    );
  }

  Widget _ticketCard(Ticket ticket) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => TicketMessagesScreen())),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(18),
            border:
                Border.all(width: .2, color: AppColorConstants.primaryYellow)),
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.id!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: ticket.status == 0
                                ? AppColorConstants.ticketBadgePendingColor
                                : const Color(0xFF43b877),
                            borderRadius: BorderRadius.circular(18),
                            shape: BoxShape.rectangle),
                        child: Text(
                          ticket.status == 0 ? 'Pending' : 'Completed',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ticket.createdDate!,
                    style: TextStyle(
                        color: AppColorConstants.primaryYellow, fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    ticket.message!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColorConstants.secondaryGray),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
