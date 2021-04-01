/*"organizer_id":6,
"organizer_name":"Ananya",
"organizer_desc":"An organisation dedicated to Indian classical music",
"organizer_website":"www.ananyaculture.in",
"organizer_email":"",
"organizer_logo":"ananya_logo.jpg",
"organizer_phone":"09980991110",
"organizer_address1":"91/2, 4th Main",
"organizer_address2":"Malleshwaram",
"organizer_city":"Bangalore",
"organizer_state":"Karnataka",
"organizer_country":"India",
"organizer_pincode":"560003",
"organizer_mapcoords":"13.003736, 77.569962",
"organizer_is_published":"Yes"*/

class Organizer {
  final int organizer_id;
  final String organizer_name;
  final String organizer_desc;
  final String organizer_logo;
  final String organizer_phone;
  final String organizer_email;
  final String organizer_website;
  final String organizer_address1;
  final String organizer_mapcoords;
  final String organizer_is_published;

  Organizer(
      {this.organizer_name,
      this.organizer_id,
      this.organizer_desc,
      this.organizer_logo,
      this.organizer_phone,
      this.organizer_email,
      this.organizer_website,
      this.organizer_address1,
      this.organizer_mapcoords,
      this.organizer_is_published});

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      organizer_id: json['organizer_id'] as int,
      organizer_name: json['organizer_name'] as String,
      organizer_desc: json['organizer_desc'] as String,
      organizer_logo: json['organizer_logo'] as String,
      organizer_phone: json['organizer_phone'] as String,
      organizer_email: json['organizer_email'] as String,
      organizer_website: json['organizer_website'] as String,
      organizer_address1: json['organizer_address1'] as String,
      organizer_mapcoords: json['organizer_mapcoords'] as String,
      organizer_is_published: json['organizer_is_published'] as String,
    );
  }
}
