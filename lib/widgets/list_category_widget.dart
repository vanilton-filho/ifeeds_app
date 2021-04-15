import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/widgets/custom_list_tile_widget.dart';

class ListCategoryWidget extends StatefulWidget {
  int? category;
  String? campus;

  ListCategoryWidget({this.category, this.campus});

  @override
  _ListCategoryWidgetState createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildCategory(context, widget.category!, widget.campus!);
  }

  Widget _buildCategory(BuildContext context, int category, String campus) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rating')
          .where('category', isEqualTo: category)
          .where('campus', isEqualTo: campus)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildCategoryList(context, snapshot.data!.docs);
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro'),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }

  _buildCategoryList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Text(
                _getCategoryName(),
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot
                  .map((data) => CustomTileWidget(
                        context,
                        docSnapshot: data,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  _getCategoryName() {
    if (this.widget.category == 1) {
      return 'Infraestrutura';
    } else if (this.widget.category == 2) {
      return 'Serviços';
    } else if (this.widget.category == 3) {
      return 'Eventos';
    }
  }
}
