class Tickets {
  Tickets({this.tickets = const <Ticket>[]});

  factory Tickets.fromJson(Map<String, dynamic> json) {
    return Tickets(
        tickets: (json['data'] as List<dynamic>)
            .map((ticket) => Ticket.fromJson(ticket))
            .toList());
  }

  final List<Ticket> tickets;
}

class Ticket {
  Ticket(
      {this.id,
      this.userId,
      this.subject,
      this.message,
      this.imgUrl,
      this.status = 0,
      this.createdDate});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        userId: json['user_id'],
        subject: json['subject'],
        message: json['message'],
        imgUrl: json['img_url'],
        status: json['status'],
        createdDate: json['created_date']);
  }

  final String? id;
  final String? userId;
  final String? subject;
  final String? message;
  final String? imgUrl;
  final int status;
  final String? createdDate;
}
