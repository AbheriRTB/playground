/*class Program {
  final String id;
  final String title;
  final String art_type;
  final String event_type;
  final String description;
  final String entry_fee;
  final String organizer_website;
  final DateTime event_date;
  final String venue_name;
  final String organizer_name;
  final String artiste_name;
  final String accompanists;
  final String organizer_phone;
  final DateTime event_start;
  final DateTime event_end;
  final String duration;
  final String venue_address1;
  final String venue_address2;
  final String venue_city;
  final String venue_state;
  final String venue_country;
  final String venue_pincode;
  final String venue_mapcoords;
  final String venue_parking;
  final String venue_eataries;
  final String artiste_image;
  final String is_featured;
  final String splash_url;
  final String is_published;

  Program(
      {this.id,
      this.title,
      this.art_type,
      this.event_type,
      this.description,
      this.entry_fee,
      this.organizer_website,
      this.event_date,
      this.venue_name,
      this.organizer_name,
      this.artiste_name,
      this.accompanists,
      this.organizer_phone,
      this.event_start,
      this.event_end,
      this.duration,
      this.venue_address1,
      this.venue_address2,
      this.venue_city,
      this.venue_state,
      this.venue_country,
      this.venue_pincode,
      this.venue_mapcoords,
      this.venue_parking,
      this.venue_eataries,
      this.artiste_image,
      this.is_featured,
      this.splash_url,
      this.is_published});

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      //id: json['id'],
      title: json['title'],
      art_type: json['art_type'],
    );
  }
/*
  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      title: json['title'],
      art_type: json['art_type'],
      event_type: json['eventy_type'],
      description: json['description'],
      entry_fee: json['entry_fee'],
      organizer_website: json['organizer_website'],
      event_date: json['event_date'],
      venue_name: json['venue_name'],
      organizer_name: json['organizer_name'],
      artiste_name: json['artiste_name'],
      accompanists: json['accompanists'],
      organizer_phone: json['organizer_phone'],
      event_start: json['event_start'],
      event_end: json['event_end'],
      duration: json['duration'],
      venue_address1: json['venue_address1'],
      venue_address2: json['venue_address2'],
      venue_city: json['venue_city'],
      venue_state: json['venue_state'],
      venue_country: json['venue_country'],
      venue_pincode: json['venue_pincode'],
      venue_mapcoords: json['venue_mapcoords'],
      venue_parking: json['venue_parking'],
      venue_eataries: json['venue_eataries'],
      artiste_image: json['artiste_image'],
      is_featured: json['is_featured'],
      splash_url: json['splash_url'],
      is_published: json['is_published'],
    );
  }
  */
}*/
class Programs {
  final int id;
  final String title;
  final String description;
  final String entry_fee;
  final String artiste_image;
  final DateTime event_date;
  final DateTime event_start;
  final String artiste_name;
  final String event_type;
  final String organizer_name;
  final String venue_name;
  final String venue_address1;
  final String venue_address2;
  final String venue_city;
  final String venue_state;
  final String venue_country;
  final String venue_pincode;
  final String splash_url;
  final String is_featured;
  final String is_published;

  Programs({
    this.id,
    this.title,
    this.description,
    this.entry_fee,
    this.event_date,
    this.event_start,
    this.venue_name,
    this.artiste_name,
    this.artiste_image,
    this.event_type,
    this.organizer_name,
    this.venue_address1,
    this.venue_address2,
    this.venue_city,
    this.venue_state,
    this.venue_country,
    this.venue_pincode,
    this.is_featured,
    this.splash_url,
    this.is_published,
  });

  factory Programs.fromJson(Map<String, dynamic> json) {
    return Programs(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      entry_fee: json['entry_fee'] as String,
      event_date:
          DateTime.parse(json['event_date'] + ' ' + json['event_start']),
      artiste_image: json['artiste_image'] as String,
      venue_name: json['venue_name'] as String,
      artiste_name: json['artiste_name'] as String,
      organizer_name: json['organizer_name'] as String,
      event_type: json['event_type'] as String,
      venue_address1: json['venue_address1'] as String,
      venue_address2: json['venue_address2'] as String,
      venue_city: json['venue_city'] as String,
      venue_state: json['venue_state'] as String,
      venue_country: json['venue_country'] as String,
      venue_pincode: json['venue_pincode'] as String,
      is_featured: json['is_featured'] as String,
      splash_url: json['splash_url'] as String,
      is_published: json['is_published'] as String,
    );
  }
}
