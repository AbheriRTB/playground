import 'package:sunaad/models/programs.dart';

class Orgs {
  final String title;
  final String artiste_image;
  final List<Programs>
      children; // Since this is an expansion list ...children can be another list of entries
  Orgs(this.title, this.artiste_image, this.children);
}
