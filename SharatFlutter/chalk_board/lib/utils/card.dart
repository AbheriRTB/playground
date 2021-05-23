import 'package:chalk_board/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardList extends StatelessWidget {
  const CardList({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Posts post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Card(
        color: Colors.grey[900].withOpacity(0.1),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.dishName,
                      style: TextStyle(
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        color: Colors.amber,
                        fontSize: 24.0,
                        backgroundColor: Colors.grey[900],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      post.recipie,
                      style: TextStyle(
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        color: Colors.amber,
                        fontSize: 18.0,
                        backgroundColor: Colors.grey[900],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Time taken ${post.durationTime} ${post.durationUnit.toLowerCase()}',
                      style: TextStyle(
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }
}
