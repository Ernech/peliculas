import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Iron man',
    'Capitana Marvel',
    'Avengers',
    'Star wars'
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan america'];

  @override
  List<Widget> buildActions(BuildContext context) {
    //acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando la persona escribe

    /*final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas.where((p) => p.toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
      itemCount: listaSugerida.length,
    );*/
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder:
              (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if (snapshot.hasData) {
              final peliculas = snapshot.data;
              return ListView(
                children: peliculas.map((pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        image: NetworkImage(pelicula.getPosterImg()),
                        fit: BoxFit.contain),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: () {
                      close(context, null);
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, '/detalle',
                          arguments: pelicula);
                    },
                  );
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
  }
}
