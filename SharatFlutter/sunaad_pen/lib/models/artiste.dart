/*
"artiste_id":418,
"artiste_name":"Rajamani",
"artiste_desc":"A well known singer",
"artiste_phone":"ph_Raja_72256",
"artiste_website":"",
"art_type":"Carnatic",
"audio_clip":"",
"artiste_instrument":"Bhajan",
"artiste_address1":"",
"artiste_address2":"",
"artiste_city":"",
"artiste_state":"",
"artiste_country":"",
"artiste_pincode":"",
"artiste_mapcoords":"",
"artiste_image":"",
"artiste_gender":"Male",
"artiste_email":"",
"artiste_dob":"2001-01-01",
"artiste_is_published":"Yes"},
*/
class Artiste {
  final int artiste_id;
  final String artiste_name;
  final String artiste_desc;
  final String artiste_phone;
  final String artiste_website;
  final String art_type;
  final String artiste_instrument;
  final String artiste_image;
  final String artiste_email;
  final String artiste_is_published;

  Artiste(
      {this.artiste_id,
      this.artiste_name,
      this.artiste_desc,
      this.artiste_phone,
      this.artiste_website,
      this.art_type,
      this.artiste_instrument,
      this.artiste_image,
      this.artiste_email,
      this.artiste_is_published});

  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
      artiste_id: json['artiste_id'] as int,
      artiste_name: json['artiste_name'] as String,
      artiste_desc: json['artiste_desc'] as String,
      artiste_phone: json['artiste_phone'] as String,
      artiste_website: json['artiste_website'] as String,
      art_type: json['art_type'] as String,
      artiste_instrument: json['artiste_instrument'] as String,
      artiste_image: json['artiste_image'] as String,
      artiste_email: json['artiste_email'] as String,
      artiste_is_published: json['artiste_is_published'] as String,
    );
  }
}
