/*
"venue_id":2,
"venue_name":"Moodaganapathy Sabhabhavan",
"venue_desc":"A Nice Sabha",
"venue_image":"moodaganapathy.jpeg",
"venue_phone":"ph_mdgnpty",
"venue_email":"",
"venue_website":"",
"venue_address1":"Prabhath Nagar",
"venue_address2":",",
"venue_city":"Honnavar Uttar Karnataka",
"venue_state":"Karnataka",
"venue_country":"India",
"venue_pincode":"581334",
"venue_mapcoords":"14.286900, 74.454803",
"venue_parking":"No",
"venue_eateries":"No",
"venue_is_published":"Yes"
*/

class Venue {
  final int venue_id;
  final String venue_name;
  final String venue_desc;
  final String venue_image;
  final String venue_phone;
  final String venue_email;
  final String venue_website;
  final String venue_address1;
  final String venue_mapcoords;
  final String venue_parking;
  final String venue_eateries;
  final String venue_is_published;

  Venue(
      {this.venue_id,
      this.venue_name,
      this.venue_desc,
      this.venue_image,
      this.venue_phone,
      this.venue_email,
      this.venue_website,
      this.venue_address1,
      this.venue_mapcoords,
      this.venue_parking,
      this.venue_eateries,
      this.venue_is_published});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      venue_id: json['venue_id'] as int,
      venue_name: json['venue_name'] as String,
      venue_desc: json['venue_desc'] as String,
      venue_image: json['venue_image'] as String,
      venue_phone: json['venue_phone'] as String,
      venue_email: json['venue_email'] as String,
      venue_website: json['venue_website'] as String,
      venue_address1: json['venue_address1'] as String,
      venue_mapcoords: json['venue_mapcoords'] as String,
      venue_parking: json['venue_parking'] as String,
      venue_eateries: json['venue_eateries'] as String,
      venue_is_published: json['venue_is_published'] as String,
    );
  }
}
