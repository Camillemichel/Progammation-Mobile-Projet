import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<dynamic> popularMoviesName = [];
List<dynamic> popularMoviesImage = [];

/** PAS LES BONNES POLICES ! A CHANGER PLUS TARD */
void main() async {

  const apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc'; // METTEZ VOTRE CLEF A VOUS !!
  const endpoint = 'movies';
  final apiUrl = "https://comicvine.gamespot.com/api/${endpoint}?api_key=${apiKey}&format=json";
  List<dynamic> listMovies = [];

  int offset = 0;
  int limit = 100;
  bool hasMoreResults = true;

  while (hasMoreResults) {
    final response = await http.get(Uri.parse('$apiUrl&offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      if (results.isNotEmpty) {
        listMovies.addAll(results);
        offset += limit;
      } else {
        hasMoreResults = false;
      }
    } else {
      // Gérer les erreurs de la requête
      print('Erreur de requête: ${response.statusCode}');
      break;
    }
  }
  // Recuperer les 5 films les plus populaires
  for (int i = 0; i < listMovies.length; i++) {
    final film = listMovies[i];
    final movieName = film['name'];
    final movieImage = film['image']['icon_url'];

    if (movieName == 'X-Men' || movieName == 'Iron Man' || movieName == 'Thor: Tales of Asgard' || movieName == 'Steven Universe: The Movie' ) {
      popularMoviesName.add(movieName);
      popularMoviesImage.add(movieImage);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: const Color(0xFF15232E), // Couleur de fond
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent, // Rendre la barre transparente
        elevation: 0, // Supprimer l'ombre de la barre
      ),
      body: ListView(
          children: [
            SizedBox(
                height: 1229, // Hauteur fixe pour le défilement vertical
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // Vous pouvez remplacer 4 par la taille de votre liste de films populaires
                  itemBuilder: (BuildContext context, int index) {
                    // Vous pouvez personnaliser les éléments de votre liste de films populaires ici
                    return Container(
                      width: 375,
                      height: 1229,
                      color: Theme.of(context).colorScheme.background,
                      child: Stack(
                        children: [
                          /** BIENVENUE !*/
                          Positioned(
                            left: 32, // Position X du texte
                            top: 34, // Position Y du texte
                            child: Container(
                              width: 187, // Largeur du texte
                              height: 41, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "BIENVENUE !", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 30, // Taille du texte
                                    fontWeight: FontWeight.bold, // Poids (Bold)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /** RECTANGLE SERIES POPULAIRES*/
                          Positioned(
                            left: 9, // Position X du rectangle
                            top: 111, // Position Y du rectangle
                            child: Container(
                              width: 424, // Largeur du rectangle
                              height: 329, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 272, // Position X du rectangle
                            top: 140, // Position Y du rectangle
                            child: Container(
                              width: 92, // Largeur du rectangle
                              height: 32, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 295, // Position X du texte
                            top: 145, // Position Y du texte
                            child: Container(
                              width: 57, // Largeur du texte
                              height: 19, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Voir plus", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 14, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /** LOGO */
                          Positioned(
                            left: 244, // Position X de l'image
                            top: 16, // Position Y de l'image
                            child: SvgPicture.asset(
                              'assets/astronaut.svg', // Chemin vers l'image SVG
                              width: 121.85, // Largeur de l'image
                              height: 169.68, // Hauteur de l'image
                            ),
                          ),
                          /** SERIES POPULAIRES */
                          Positioned(
                            left: 26, // Position X du rond
                            top: 142, // Position Y du rond
                            child: Container(
                              width: 10, // Largeur du rond
                              height: 10, // Hauteur du rond
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), // Bordure arrondie pour faire un rond
                                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26, // Position X du texte
                            top: 133, // Position Y du texte
                            child: Container(
                              width: 205, // Largeur du texte
                              height: 27, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Séries populaires", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 20, // Taille du texte
                                    fontWeight: FontWeight.bold, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /** COMICS POPULAIRES */
                          Positioned(
                            left: 9, // Position X du rectangle
                            top: 460, // Position Y du rectangle
                            child: Container(
                              width: 424, // Largeur du rectangle
                              height: 329, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26, // Position X du rond
                            top: 482, // Position Y du rond
                            child: Container(
                              width: 10, // Largeur du rond
                              height: 10, // Hauteur du rond
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), // Bordure arrondie pour faire un rond
                                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30, // Position X du texte
                            top: 472, // Position Y du texte
                            child: Container(
                              width: 205, // Largeur du texte
                              height: 27, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Comics populaires", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 20, // Taille du texte
                                    fontWeight: FontWeight.bold, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 274, // Position X du rectangle
                            top: 474, // Position Y du rectangle
                            child: Container(
                              width: 92, // Largeur du rectangle
                              height: 32, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 292, // Position X du texte
                            top: 480, // Position Y du texte
                            child: Container(
                              width: 57, // Largeur du texte
                              height: 19, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Voir plus", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 14, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /** FILMS POPULAIRES*/
                          Positioned(
                            left: 9, // Position X du rectangle
                            top: 809, // Position Y du rectangle
                            child: Container(
                              width: 424, // Largeur du rectangle
                              height: 329, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26, // Position X du rond
                            top: 840, // Position Y du rond
                            child: Container(
                              width: 10, // Largeur du rond
                              height: 10, // Hauteur du rond
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5), // Bordure arrondie pour faire un rond
                                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 45, // Position X du texte
                            top: 831, // Position Y du texte
                            child: Container(
                              width: 175, // Largeur du texte
                              height: 27, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Films populaires", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 20, // Taille du texte
                                    fontWeight: FontWeight.bold, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 274, // Position X du rectangle
                            top: 831, // Position Y du rectangle
                            child: Container(
                              width: 92, // Largeur du rectangle
                              height: 32, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 292, // Position X du texte
                            top: 837, // Position Y du texte
                            child: Container(
                              width: 57, // Largeur du texte
                              height: 19, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "Voir plus", // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 14, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26, // Position X du rectangle
                            top: 877, // Position Y du rectangle
                            child: Container(
                              width: 180, // Largeur du rectangle
                              height: 242, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(40, 76, 106, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 37, // Position X du texte
                            top: 1066, // Position Y du texte
                            child: Container(
                              width: 156, // Largeur du texte
                              height: 44, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  popularMoviesName[0], // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 16, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 26, // Position X de l'image
                              top: 877, // Position Y de l'image
                              child: Image.network(
                                popularMoviesImage[0],
                                width: 180,
                                height: 177,
                              )
                          ),
                          Positioned(
                            left: 216, // Position X du rectangle
                            top: 877, // Position Y du rectangle
                            child: Container(
                              width: 180, // Largeur du rectangle
                              height: 242, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(40, 76, 106, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 227, // Position X du texte
                            top: 1066, // Position Y du texte
                            child: Container(
                              width: 156, // Largeur du texte
                              height: 44, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  popularMoviesName[1], // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 16, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 216, // Position X de l'image
                              top: 877, // Position Y de l'image
                              child: Image.network(
                                popularMoviesImage[1],
                                width: 180,
                                height: 177,
                              )
                          ),
                          Positioned(
                            left: 406, // Position X du rectangle
                            top: 877, // Position Y du rectangle
                            child: Container(
                              width: 180, // Largeur du rectangle
                              height: 242, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(40, 76, 106, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 417, // Position X du texte
                            top: 1066, // Position Y du texte
                            child: Container(
                              width: 156, // Largeur du texte
                              height: 44, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  popularMoviesName[2], // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 16, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 406, // Position X de l'image
                              top: 877, // Position Y de l'image
                              child: Image.network(
                                popularMoviesImage[2],
                                width: 180,
                                height: 177,
                              )
                          ),

                          Positioned(
                            left: 596, // Position X du rectangle
                            top: 877, // Position Y du rectangle
                            child: Container(
                              width: 180, // Largeur du rectangle
                              height: 242, // Hauteur du rectangle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                                color: const Color.fromRGBO(40, 76, 106, 1), // Couleur du fond
                              ),
                            ),
                          ),
                          Positioned(
                            left: 607, // Position X du texte
                            top: 1066, // Position Y du texte
                            child: Container(
                              width: 156, // Largeur du texte
                              height: 44, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  popularMoviesName[3], // Texte
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                                    fontFamily: 'Nunito', // Police
                                    fontSize: 16, // Taille du texte
                                    fontWeight: FontWeight.normal, // Poids (Normal)
                                    fontStyle: FontStyle.normal, // Style de police
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 596, // Position X de l'image
                              top: 877, // Position Y de l'image
                              child: Image.network(
                                popularMoviesImage[3],
                                width: 180,
                                height: 177,
                              )
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ]),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(15, 30, 43, 1), // Couleur de fond de la barre de navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuer les icônes uniformément
        children: const [
          NavigationIcon(
            iconPath: 'assets/navbar_home.svg',
            label: 'Accueil',
            showHighlight: true, // Seul l'élément "Accueil" aura le surlignage
          ),
          NavigationIcon(
            iconPath: 'assets/ic_books_bicolor.svg',
            label: 'Comics',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/ic_tv_bicolor.svg',
            label: 'Séries',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/ic_movie_bicolor.svg',
            label: 'Films',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/navbar_search.svg',
            label: 'Recherche',
            showHighlight: false,
          ),
        ],
      ),
    );
  }
}

class NavigationIcon extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool showHighlight;

  const NavigationIcon({
    Key? key,
    required this.iconPath,
    required this.label,
    this.showHighlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: showHighlight ? BoxDecoration(
            color: const Color.fromRGBO(55, 146, 255, 0.2), // Couleur de fond pour l'élément mis en évidence
            borderRadius: BorderRadius.circular(18), // Bordure arrondie
          ) : null,
          padding: showHighlight ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null,
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: showHighlight ? const Color.fromRGBO(55, 146, 255, 1) : const Color.fromRGBO(119, 139, 168, 1),
          ),
        ),
        const SizedBox(height: 8), // Espace constant entre l'icône et le texte
        Text(
          label,
          style: TextStyle(
            color: showHighlight ? const Color.fromRGBO(55, 146, 255, 1) : const Color.fromRGBO(119, 139, 168, 1),
            fontSize: 12,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}

