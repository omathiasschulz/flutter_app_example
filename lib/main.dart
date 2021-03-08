import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// style dos titulos
const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// número de notícias verificadas
var numNoticias = 19897;

// widget principal da aplicação
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
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
              // campo nome
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O campo de nome é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.texto = value;
                },
                decoration: InputDecoration(
                    hintText: '',
                    labelText: 'Texto',
                ),
              ),
              // // campo cpf
              // TextFormField(
              //   keyboardType: TextInputType.text,
              //   validator: (String value) {
              //     print(value);
              //     if (value.length != 11) {
              //       return 'O campo de CPF é obrigatório e deve possuir 11 caracteres';
              //     }
              //     return null;
              //   },
              //   onSaved: (String value) {
              //     this._usuario.cpf = value;
              //   },
              //   decoration: InputDecoration(
              //       hintText: 'xxxyyyzzzww',
              //       labelText: 'CPF (Sem pontuação)',
              //   ),
              // ),
              // // campo email
              // TextFormField(
              //   keyboardType: TextInputType.name,
              //   validator: (String value) {
              //     print(value);
              //     if (value.length == 0) {
              //       return 'O campo de e-mail é obrigatório';
              //     }
              //     return null;
              //   },
              //   onSaved: (String value) {
              //     this._usuario.email = value;
              //   },
              //   decoration: InputDecoration(
              //       hintText: 'nome@servidor',
              //       labelText: 'E-mail',
              //   ),
              // ),
              // // botão
              // Padding(
              //   padding: EdgeInsets.only(top: 16, left: 250),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState.validate()) {
              //         // informa uma mensagem de sucesso
              //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //           content: Text('Vacinação registrada com sucesso! '),
              //           action: SnackBarAction(label: 'Fechar', onPressed:(){}),
              //         ));
              //         // apresenta algumas informações
              //         print('=> Cadastro do usuário: ');
              //         print('Nome: ${_usuario.nome}');
              //         print('E-mail: ${_usuario.email}');
              //         print('CPF: ${_usuario.cpf}');
              //         _formKey.currentState.save();
              //         numVacinas += 1;
              //         // reseta o formulário
              //         _formKey.currentState.reset();
              //       }
              //     },
              //     child: Text('Gravar'),
              //   ),
              // ),
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
