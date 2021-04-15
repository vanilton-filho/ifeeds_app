import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ifeeds/pages/utils/campus_utils.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    User? usuario = FirebaseAuth.instance.currentUser!;
    String? nome = usuario.displayName;
    String? email = usuario.email;
    String? photoUrl = usuario.photoURL;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: CircleAvatar(
                      maxRadius: 58,
                      backgroundImage: NetworkImage(photoUrl!),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nome!,
                        style: GoogleFonts.roboto(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email!,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(42.0),
                      topRight: Radius.circular(42.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27.0, vertical: 27.0),
                    child: DropdownButtonFormField(
                        isDense: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.tune),
                        ),
                        hint: Text("Selecione um campus"),
                        value: CampusUtils.campus,
                        // isExpanded: true,
                        items: [
                          DropdownMenuItem<String>(
                            child: Text("Campus Aracaju"),
                            value: "Aracaju",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Estância"),
                            value: "Estância",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Glória"),
                            value: "Glória",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Itabaiana"),
                            value: "Itabaiana",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Lagarto"),
                            value: "Lagarto",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Poço Redondo"),
                            value: "Poço Redondo",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Propriá"),
                            value: "Propriá",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus São Cristóvão"),
                            value: "São Cristóvão",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Socorro"),
                            value: "Socorro",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Campus Tobias Barreto"),
                            value: "Tobias Barreto",
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            CampusUtils.campus = value;
                          });
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 42.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.help,
                                      size: 80.0,
                                    ),
                                  ),
                                  Text(
                                    'Entre em contato pelo email abaixo: ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(fontSize: 18.0),
                                  ),
                                  Text(
                                    'ifeeds@contato.com',
                                    style: GoogleFonts.roboto(fontSize: 18.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'Estaremos respondendo assim que possível!',
                                      style: GoogleFonts.roboto(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42.0),
                              topRight: Radius.circular(42.0)),
                        ),
                      );
                    },
                    child: Text(
                      'Ajuda',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double?>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(8.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(42.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sobre',
                                      style: GoogleFonts.roboto(fontSize: 27.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'O IFeedS é um app destinado a capturar dados de feedback sobre os campus do Instituto Federal de Sergipe com o intuito de melhorar a comunidade entendendo em que pontos podem ser melhorados e quais continuar em frente relacionados com infraestrutura, serviços e eventos. Todos podem participar e contribuir dando um elogio ou reclamação e uma quantidade de estrelas. É possível também editar e receber respostas para a avaliação.',
                                        style:
                                            GoogleFonts.roboto(fontSize: 18.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Desenvolvedores: ',
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Vanilton Filho',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Kaiki Mello',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42.0),
                              topRight: Radius.circular(42.0)),
                        ),
                      );
                    },
                    child: Text(
                      'Sobre',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double?>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(8.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  Text('Versão build v0.0.1'),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text(
                      'Sair',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double?>(0),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(8.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    await FirebaseAuth.instance.signOut();

    Navigator.popAndPushNamed(context, '/login');
  }
}
