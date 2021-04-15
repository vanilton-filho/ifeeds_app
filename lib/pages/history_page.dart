import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/models/form_rating.dart';
import 'package:ifeeds/pages/update_form_page.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  User? usuario = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildHistoryList(),
    );
  }

  _buildHistoryList() {
    return _buildList();
  }

  _showModal(FormRating formRating, String id) async {
    String? response = formRating.response;
    String dataCriacao =
        DateFormat('dd-MM-yyyy HH:mm').format(formRating.creationDate!);

    String? dataAtualizacao = formRating.updateDate == null
        ? null
        : DateFormat('dd-MM-yyyy HH:mm').format(formRating.updateDate!);

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingBar.builder(
                      itemSize: 42,
                      initialRating: formRating.stars as double,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (_) => {},
                    ),
                  ),
                  Text(
                    '${formRating.stars}',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      children: [
                        Text(
                          '${formRating.description}',
                          style: GoogleFonts.roboto(fontSize: 21.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      'Campus ${formRating.campus!}',
                      style: GoogleFonts.roboto(),
                    ),
                  ),
                  formRating.updateDate == null
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Data de criação $dataCriacao',
                            style: GoogleFonts.roboto(color: Colors.grey),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Data de atualização $dataAtualizacao',
                            style: GoogleFonts.roboto(color: Colors.grey),

                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 23.0),
                      child: Text(
                        'Resposta',
                        style: GoogleFonts.roboto(fontSize: 20.0),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: response == null
                        ? Text(
                            'Nenhuma resposta até o momento...',
                            style: GoogleFonts.roboto(
                                fontSize: 14.0, color: Colors.grey),
                          )
                        : Text(
                            response,
                            style: GoogleFonts.roboto(fontSize: 16.0),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateFormPage(
                                    rating: formRating,
                                    documentId: id,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Editar',
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
                ],
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42.0), topRight: Radius.circular(42.0)),
        ));
  }

  _buildList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('forms')
            .orderBy('creationDate', descending: true)
            .where('user', isEqualTo: usuario!.uid)
            .snapshots()
        
        ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return docs.length > 0
                ? ListView(
                    children: docs.map((data) {
                      FormRating? form = FormRating.fromSnapshot(data);
                      String dataCriacao =
                          DateFormat('dd-MM-yyyy HH:mm').format(form.creationDate!);
                      String description = form.description!.length > 42
                          ? form.description!.substring(0, 42) + ' ...'
                          : form.description!;
                      return ListTile(
                        dense: true,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            description,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        subtitle: Text(
                            'Data de criação: $dataCriacao | Campus: ${form.campus}',
                            style: GoogleFonts.robotoCondensed(fontSize: 14.0)),
                        onTap: () => _showModal(form, data.id),
                      );
                    }).toList(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_edu,
                          size: 101.0,
                          color: Colors.grey,
                        ),
                        Text(
                          'Nenhum histórico até o momento...',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 21.0,
                          ),
                        )
                      ],
                    ),
                  );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
