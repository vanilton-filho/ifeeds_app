import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/models/rating.dart';
import 'package:ifeeds/pages/form_page.dart';

class CustomTileWidget extends StatefulWidget {
  final DocumentSnapshot? docSnapshot;

  CustomTileWidget(BuildContext context, {this.docSnapshot});

  @override
  _CustomTileWidgetState createState() => _CustomTileWidgetState();
}

class _CustomTileWidgetState extends State<CustomTileWidget> {
  late String ratingId;

  @override
  Widget build(BuildContext context) {
    Rating? record = Rating.fromSnapshot(this.widget.docSnapshot);
    ratingId = this.widget.docSnapshot!.id;
    return _buildCustomTile(record);
  }

  _buildCustomTile(Rating rating) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 300,
        child: InkWell(
          splashColor: Colors.green[50],
          onTap: () => _navigateToForm(context),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Image.network(rating.img!),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              rating.title!,
                              style: GoogleFonts.roboto(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: Colors.amber,
                              size: 25,
                            ),
                            child: Icon(
                              Icons.star_rounded,
                            ),
                          ),
                          Text(
                            '${rating.ratingAverage!.toStringAsPrecision(2)}',
                            style: GoogleFonts.robotoMono(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToForm(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FormPage(ratingId: ratingId);
      }),
    );
  }
}
