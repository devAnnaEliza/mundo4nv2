import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Explore Mundo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Mundo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildBannerSection(context),
      _buildTitleSection(),
      _buildButtonSection(context),
      _buildTextSection(),
    ],
  ),
),
bottomNavigationBar: _buildBottomNavigationBar(context), 
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página de destaque
      },
      child: Image.asset(
        'imagens/banffnationalpark.jpg',
        width: MediaQuery.of(context).size.width,
        height: 240,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parque Nacional de Banff',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Alberta, Canadá',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Color.fromARGB(255, 7, 196, 1),
              ),
              SizedBox(width: 8),
              Text('42'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _buildTextSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'O Banff National Park fica na província de Alberta e é um Patrimônio Mundial da UNESCO. Ele se destaca não apenas pela sua paisagem exuberante e uma quantidade incríveis de lagos de águas glaciais azul turquesa. Ele é um dos locais mais ricos em biodiversidade do Canadá e um ótimo passeio para quem gosta de se aventurar pela natureza.',
        softWrap: true,
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Locais',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_travel),
          label: 'Roteiros',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_phone),
          label: 'Reservas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Sobre Nós',
        ),
      ],
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
