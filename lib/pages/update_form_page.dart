import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/models/form_rating.dart';

class UpdateFormPage extends StatefulWidget {
  FormRating? rating;
  String? documentId;

  UpdateFormPage({this.rating, this.documentId});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<UpdateFormPage> {
  double? _rating;
  TextEditingController? _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CollectionReference forms = FirebaseFirestore.instance.collection('forms');
  CollectionReference ratings = FirebaseFirestore.instance.collection('rating');
  @override
  void initState() {
    super.initState();
    _description!.text = this.widget.rating!.description!;
    _rating = this.widget.rating!.stars as double;
  }

  @override
  void dispose() {
    _description!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 32.0,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Elogio/Reclamação',
                    style: GoogleFonts.roboto(fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _description,
                      maxLines: 200,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Forneça algum comentário!"),
                      validator: (String? val) => (val!.isEmpty)
                          ? 'Por favor, forneça algum comentário'
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      '$_rating',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 33,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: RatingBar.builder(
                      glowColor: Colors.transparent,
                      itemSize: 42.0,
                      initialRating: this.widget.rating!.stars as double,
                      minRating: 0,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,

                      ),
                      onRatingUpdate: (double value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                      updateOnDrag: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.zero,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        _update();
                      }
                    },
                    child: Text(
                      'Enviar',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(8.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.green,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green,
                      ),

                      // shape: MaterialStateProperty.all<
                      //     RoundedRectangleBorder>(
                      //   RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(18.0),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _update() async {
    await forms
        .doc(this.widget.documentId)
        .update({'stars': _rating, 'description': _description!.text, 'updateDate': Timestamp.now()})
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Done'),
            ),
          ),
        )
        .catchError((error) => print("FALHA: $error"));

    await _updateRatingAverage();
  }

  _updateRatingAverage() async {
    num newRatingAverage = await _getTotalStars() / await _getTotalFormsRating();
    ratings
        .doc(widget.rating!.rating)
        .update({'ratingAverage': newRatingAverage})
        .then((value) => print("RATING AVERAGE ATUALIZADO"))
        .catchError((error) => print("FALHA: $error"));
  }

  Future<num> _getTotalStars() async {
    num counter = 0;
    var result = await FirebaseFirestore.instance
        .collection('forms')
        .where('rating', isEqualTo: widget.rating!.rating)
        .get();

    result.docs.forEach((element) {
      counter += element.get('stars');
    });

    return counter;
  }

  Future<num> _getTotalFormsRating() async {
    var result = await FirebaseFirestore.instance
        .collection('forms')
        .where('rating', isEqualTo: widget.rating!.rating)
        .get();

    return result.docs.length;
  }
}
