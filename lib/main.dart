import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

// style dos titulos
const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// número de notícias verificadas
var numNoticias = 5789;

// widget principal da aplicação
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// splash screen
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 4,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal[100],
              Colors.teal[900],
            ],
          ),
          navigateAfterSeconds: Start(),
          loaderColor: Colors.transparent,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('imagens/logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);
  _Start createState() => _Start();
}

class _Start extends State {
  // variavel que controla a página atual
  var _currentPage = 0;
  var _pages = [
    PageVerificacao(),
    PageInformacoes(),
    PageSobre(),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Detecção de Fake News')),
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              label: 'Verificação',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined),
              label: 'Informações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind_rounded),
              label: 'Sobre',
            ),
          ],
          currentIndex: _currentPage,
          fixedColor: Colors.teal,
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          }
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

// objeto Noticia
class Noticia {
  String titulo = '';
  String texto = '';
  String email = '';
}

// pagina de verificação
// ignore: must_be_immutable
class PageVerificacao extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Noticia _noticia = new Noticia();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              // verificacao
              Text('Verificação', style: optionStyle),
              // campo titulo
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O preenchimento do campo de título é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.titulo = value;
                },
                decoration: InputDecoration(
                    hintText: 'Título da notícia',
                    labelText: 'Título',
                ),
              ),
              // campo texto
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 6,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O preenchimento do campo de texto é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.texto = value;
                },
                decoration: InputDecoration(
                    hintText: 'Texto da notícia',
                    labelText: 'Texto',
                ),
              ),
              // campo email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  print(value);
                  if (value.length == 0) {
                    return 'O preenchimento do campo de e-mail é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.email = value;
                },
                decoration: InputDecoration(
                    hintText: 'nome@servidor',
                    labelText: 'E-mail',
                ),
              ),
              // botão
              Padding(
                padding: EdgeInsets.only(top: 16, left: 250),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // informa uma mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Notícia verificada com sucesso! '),
                        action: SnackBarAction(label: 'Fechar', onPressed:(){}),
                      ));
                      // apresenta as informações da notícia
                      print('=> Informações da notícia: ');
                      print('Título: ${_noticia.titulo}');
                      print('Texto: ${_noticia.texto}');
                      print('E-mail: ${_noticia.email}');
                      _formKey.currentState.save();
                      numNoticias += 1;
                      // reseta o formulário
                      _formKey.currentState.reset();
                    }
                  },
                  child: Text('Gravar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// pagina de informações sobre as notícias
// ignore: must_be_immutable
class PageInformacoes extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Informações', style: optionStyle),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Número de notícias verificadas: '
                       + numNoticias.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// pagina sobre as informações do aplicativo
// ignore: must_be_immutable
class PageSobre extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Sobre', style: optionStyle),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mathias Artur Schulz',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                'imagens/logo.png',
              ),
              Image.asset(
                'imagens/governo.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
