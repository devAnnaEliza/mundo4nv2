import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:appviagens/teladestinos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Destino> destinos = [];
  List<Destino> displayedDestinos = [];
  List<Destino> carouselDestinos = [
    Destino(nome: "Brasil", descricao: "O Brasil é o maior e mais populoso país da América do Sul", imageUrl: "https://res.cloudinary.com/worldpackers/image/upload/c_fill,f_auto,q_auto,w_1024/v1/guides/article_cover/cj6mryoqn9otslfywira"),
    Destino(nome: "Canadá", descricao: "O Canadá é o país com a maior área em território das Américas", imageUrl: "https://paxpro.com.br/wp-content/uploads/2022/08/image-29.png"),
    Destino(nome: "Japão", descricao: "Tóquio, a capital do Japão, é a cidade mais populosa do mundo", imageUrl: "https://wise.com/imaginary-v2/e57def54f829e2bad52465c9fbaffeed.jpg"),
  ];

  @override
  void initState() {
    super.initState();
    destinos = getDestinos();
    displayedDestinos = destinos;
  }

  List<Destino> getDestinos() {
    return [
      Destino(nome: "Maceió", descricao: "Conhecida como Cidade-Sorriso ou Paraíso das Águas, suas belezas naturais atraem turistas do mundo inteiro.", imageUrl: "https://maceioalgovbr.dhost.cloud/uploads/imagens/26-07-23-Ponta-Verde-Maceio-Orla-Praia-SEMTUR-foto-Jonathan-Lins-7.jpg"),
      Destino(nome: "New York", descricao: "Muito famosa em todo mundo por causa da Estátua da Liberdade, a cidade de Nova York também é conhecida como Big Apple.", imageUrl: "https://sophiamartins.com.br/wp-content/uploads/2023/05/Best-Views-of-New-York-City.jpg.optimal.jpg"),
      Destino(nome: "Cancún", descricao: "Famosa por suas praias paradisíacas e sua cultura ancestral preservada em sítios arqueológicos, a cidade de Cancún é o equilíbrio perfeito entre a agitação e a calmaria.", imageUrl: "https://ns.clubmed.com/dream/PRODUCT_CENTER/DESTINATIONS/SUN/Caraibes___Amerique_du_Nord/Mexique/Cancun/14401-e5rmtcnl7f-swhr.jpg"),
      Destino(nome: "Veneza", descricao: "Situada no norte da Itália, Veneza é formada por mais de 100 pequenas ilhas.", imageUrl: "https://img.freepik.com/fotos-premium/imagem-da-paisagem-urbana-de-veneza-italia-a-noite_255553-2428.jpg"),
      Destino(nome: "Cairo", descricao: "Capital do Egito e localizada às margens do rio Nilo, a cidade co Cairo tem como atração as famosas pirâmides de Gizé.", imageUrl: "https://www.weseektravel.com/wp-content/uploads/2023/03/where-to-stay-in-cairo-1.jpg"),
      Destino(nome: "Buenos Aires", descricao: "Segunda maior área metropolitana da América do Sul, é conhecida por sua arquitetura com estilo europeu.", imageUrl: "https://www.dicasdeviagem.com/wp-content/uploads/2019/05/puerto-madero.jpg"),
      Destino(nome: "Pequim", descricao: "Com 3 milênios de história, a capital chinesa é conhecida tanto por sua arquitetura moderna quanto por seus templos antigos.", imageUrl: "https://www.cvc.com.br/dicas-de-viagem/wp-content/uploads/2018/04/topo-pequim-templo-e-predios-credito-thinkstock-491990549.jpg"),
    ];
  }

  void updateSearchQuery(String newQuery) {
    if (newQuery.isEmpty) {
      displayedDestinos = List.from(destinos); 
    } else {
      displayedDestinos = destinos.where((destino) {
        return destino.nome.toLowerCase().contains(newQuery.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore Mundo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map), text: "Destinos"),
              Tab(icon: Icon(Icons.card_travel), text: "Roteiros"),
              Tab(icon: Icon(Icons.contact_mail), text: "Fale Conosco"),
              Tab(icon: Icon(Icons.info_outline), text: "Sobre Nós"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(displayedDestinos),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildDestinationsTab(context),
            buildPackagesTab(),
            buildContactTab(),
            buildAboutUsTab(),
          ],
        ),
      ),
    );
  }

  Widget buildDestinationsTab(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            ),
            items: carouselDestinos.map((destino) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaDestinos(
                          imageUrl: destino.imageUrl,
                          nome: destino.nome,
                          descricao: destino.descricao,
                        )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 185, 209),
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(destino.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        buildDestinationList(context),
      ],
    );
  }

  Widget buildPackagesTab() {
    return ListView(
      children: [
        _buildPackageTile(
          title: "Roteiro Américas",
          subtitle: "Conheça as grandes capitais das Ámericas.",
          thumbnailUrl: "https://www.cvc.com.br/dicas-de-viagem/wp-content/uploads/2019/02/dicas-de-viagem-top-5-america-do-sul.jpg",
          destinations: ["Estados Unidos", "Canadá", "México", "Brasil", "Argentina"],
        ),
        _buildPackageTile(
          title: "Roteiro Ásia",
          subtitle: "Descubra os segredos do continente asiático.",
          thumbnailUrl: "https://www.viagemnaplanilha.com.br/content/images/2019/08/roteiro-asia.JPG",
          destinations: ["China", "Japão", "Filipinas", "Indonésia", "Índia"],
        ),
        _buildPackageTile(
          title: "Roteiro Europa + África",
          subtitle: "Conheça os continentes mais antigos de um novo jeito.",
          thumbnailUrl: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQ4hEV_tmc2xzsd6-QnfRw5XY9dlpzmRSyGFV5m1YAyU8hyO3-Qx4wiko_IfUe1DPUDn7hRYHCNWg7_Z2QgJ9X3EqV77vod2rbzmymboQEKljWIZY5L9dacFGEZDxrDZXcjZ13kb-OrjAC/s1600/par%25C3%25ADs+roma+amsterdam.jpg",
          destinations: ["França", "Itália", "Reino Unido", "Egito", "África do Sul"],
        ),
      ],
    );
  }

  Widget _buildPackageTile({
    required String title,
    required String subtitle,
    required String thumbnailUrl,
    required List<String> destinations,
  }) {
    return ListTile(
      leading: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          SizedBox(height: 4),
          Text("Paradas inclusas:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: destinations.map((destination) {
              return Row(
                children: [
                  Icon(Icons.location_on, size: 16),
                  SizedBox(width: 4),
                  Text(destination),
                ],
              );
            }).toList(),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget buildContactTab() {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("app.explore@gmail.com"),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text("Contato"),
          subtitle: Text("+55 21 00000-0000"),
        ),
      ],
    );
  }

  Widget buildAboutUsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sobre Nós",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "Nós da Explore Mundo somos uma empresa de viagens que tem como objetivo principal proporcionar experiências únicas para nossos clientes. Queremos ensinar a diferença entre passeios e roteiros de viagens. E agora, também podemos ser encontrados na sua loja de aplicativos favorita.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDestinationList(BuildContext context) {
    return Column(
      children: displayedDestinos.map((destino) {
        return ListTile(
          leading: Container(
            width: 100,
            height: 60,
            child: Image.network(destino.imageUrl, fit: BoxFit.cover),
          ),
          title: Text(destino.nome),
          subtitle: Text(destino.descricao),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaDestinos(
                imageUrl: destino.imageUrl,
                nome: destino.nome,
                descricao: destino.descricao,
              )),
            );
          },
        );
      }).toList(),
    );
  }
}

TelaDestinos({required String imageUrl, required String nome, required String descricao}) {
}

class Destino {
  final String nome;
  final String descricao;
  final String imageUrl;

  Destino({required this.nome, required this.descricao, required this.imageUrl});
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Destino> filteredDestinos;

  CustomSearchDelegate(this.filteredDestinos);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final queryLower = query.toLowerCase();
    final results = filteredDestinos.where((d) => d.nome.toLowerCase().contains(queryLower)).toList();
    return ListView(
      children: results.map((destino) => ListTile(
        title: Text(destino.nome),
        subtitle: Text(destino.descricao),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDestinos(
            imageUrl: destino.imageUrl,
            nome: destino.nome,
            descricao: destino.descricao,
          )));
        },
      )).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final queryLower = query.toLowerCase();
    final suggestions = filteredDestinos.where((d) => d.nome.toLowerCase().contains(queryLower)).toList();
    return ListView(
      children: suggestions.map((destino) => ListTile(
        title: Text(destino.nome),
      )).toList(),
    );
  }
}
