import 'package:flutter/material.dart';
import 'package:ifeeds/pages/history_page.dart';
import 'package:ifeeds/pages/user_page.dart';
import 'package:ifeeds/pages/utils/campus_utils.dart';
import 'package:ifeeds/widgets/list_category_widget.dart';

class RatingPage extends StatefulWidget {
  // Dados para teste
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 23.0),
        color: Color(0xff4E986E),
        child: Container(
          padding: const EdgeInsets.only(top: 23.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42.0),
              topRight: Radius.circular(42.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemExtent: 300,
              children: [
                ListCategoryWidget(
                  category: 1,
                  campus: CampusUtils.campus,
                ),
                ListCategoryWidget(
                  category: 2,
                  campus: CampusUtils.campus,
                ),
                ListCategoryWidget(
                  category: 3,
                  campus: CampusUtils.campus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
