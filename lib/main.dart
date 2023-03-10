import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Este é o tema da sua aplicação.
        // tente rodar a sua aplicação com "flutter run". você verá uma
        // aplicação com uma barra de ferramentas azul. então, sem sair do app, tente
        // trocar o atributo 'primarySwatch' abaixo para Colors.green e então chame o
        // "hot reload" (pressione "r" no console aonde rodou "flutter run",
        // Note que se o campo de texto não ficar vazio, a sua aplicação não está reinicializada.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculadora Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // Este widget é a pagina principal da sua aplicação. Se ela é stateful, significa
  // que ela tem um objeto State (definifo abaixo) que contem campos que afetam
  // sua aparencia.

  // Esta classe é a configuraçao para o state. Ela mantém o valor (neste
  // caso o tutilo 'title') fornecido pelo parent (neste caso o App widget) e
  // usado pelo metodo contrutor do State. Campo em uma subClass Widged são
  // sempre marcados como final.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value1 = '';
  String value2 = '';
  String operator = '';
  double result = 0;
  //controla o valores inseridos no campo de texto.
  final calculadoraTextController = TextEditingController();

  void _setValueCalculadora(String value) {
    if (operator.isEmpty) {
      value1 = value1 + value;
      setState(() {
        calculadoraTextController.text = value1;
      });
    } else {
      value2 = value2 + value;
      setState(() {
        calculadoraTextController.text = '$value1 ' ' $operator ' ' $value2';
      });
    }
  }

  void _setOperadorCalculadora(String operador) {
    operator = operador;
    setState(() {
      calculadoraTextController.text = '$value1 ' ' $operator ' ' $value2';
    });
  }

  void _calcular() {
    switch (operator) {
      case '+':
        result = double.tryParse(value1)! + double.tryParse(value2)!;
        break;
      case '-':
        result = double.tryParse(value1)! - double.tryParse(value2)!;
        break;
      case '*':
        result = double.tryParse(value1)! * double.tryParse(value2)!;
        break;
      case '/':
        result = double.tryParse(value1)! / double.tryParse(value2)!;
        break;
      case '%':
        result = (double.tryParse(value2)! / 100) * double.tryParse(value1)!;
        break;
      default:
    }

    setState(() {
      calculadoraTextController.text =
          '$value1 ' ' $operator ' ' $value2' ' = ' '$result';
    });
  }

  void _clearValueCalculadora() {
    setState(() {
      value1 = '';
      value2 = '';
      operator = '';
      calculadoraTextController.text = '';
    });
  }

  void _deleteValueCalculadora() {
    if (value2.isNotEmpty) {
      value2 = '';
      setState(() {
        calculadoraTextController.text = '$value1 ' ' $operator ';
      });
    } else if (operator.isNotEmpty) {
      operator = '';
      setState(() {
        calculadoraTextController.text = value1;
      });
    } else if (value1.isNotEmpty) {
      value1 = '';
      setState(() {
        calculadoraTextController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Este método é repetido toda vez que o setSate é chamado, por exemplo como feito
    //pelo metodo acima _setValueCalculadora.
    //
    //O Framework flutter foi otimamizado para fazer métodos de compilação de reinicialização
    //rápida 'Hot Reload', para que você possa simplesmente reconstruir qualquer coisa que precise de atualização
    //sem a necessidade de recompilar a aplicação toda, ele recompila individualmente apenas instâncias de widgets alterados.
    return Scaffold(
      appBar: AppBar(
        // Aqui nós colocamos o valor vindo do objeto 'MyHomePage' que foi criado pelo
        // método App.build, e é utilizado para setar o título na nossa app bar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center é um widget de layout. Ele tem apenas um filho e o posiciona
        // no meio do widget pai.
        child: Column(
          // Column é também um widget de layout. Ela possui uma lista de widgets 'filhos' e
          // e os arranja verticalmente.
          // Column tem várias propriedades para controlar tamanho e posição dos 'filhos'
          // Como por exemplo o mainAxisAlignment para controlar o posiciomanto do filhos no eixo vertical.

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child:
                  //Widget de layout para entrada de texto
                  TextField(
                //controla o valores inseridos no campo de texto.
                controller: calculadoraTextController,
                enabled: false,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Entre com o valor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                // Row é também um widget de layout. Ela possui uma lista de widgets 'filhos' e
                // e os arranja horizontalmente.
                // Row tem várias propriedades para controlar tamanho e posição dos 'filhos'
                // Como por exemplo o mainAxisAlignment para controlar o posiciomanto do filhos no eixo horizontal.

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Este Widget insere um botão no layout.
                  ElevatedButton(
                      //este método controla a ação ao pressionar o botão.
                      onPressed: () {
                        _clearValueCalculadora();
                      },
                      child: const Text('CE')),
                  ElevatedButton(
                      onPressed: () {
                        _deleteValueCalculadora();
                      },
                      child: const Text('DEL')),

                  ElevatedButton(
                      onPressed: () {
                        _setOperadorCalculadora('*');
                      },
                      child: const Text('*')),
                  ElevatedButton(
                      onPressed: () {
                        _setOperadorCalculadora('-');
                      },
                      child: const Text('-')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('7');
                      },
                      child: const Text('7')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('8');
                      },
                      child: const Text('8')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('9');
                      },
                      child: const Text('9')),
                  ElevatedButton(
                      onPressed: () {
                        _setOperadorCalculadora('+');
                      },
                      child: const Text('+')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('4');
                      },
                      child: const Text('4')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('5');
                      },
                      child: const Text('5')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('6');
                      },
                      child: const Text('6')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('.');
                      },
                      child: const Text('.')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('1');
                      },
                      child: const Text('1')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('2');
                      },
                      child: const Text('2')),
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('3');
                      },
                      child: const Text('3')),
                  ElevatedButton(
                      onPressed: () {
                        _setOperadorCalculadora('/');
                      },
                      child: const Text('/')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _setValueCalculadora('0');
                      },
                      child: const Text('0')),
                  ElevatedButton(
                      onPressed: () {
                        _setOperadorCalculadora('%');
                      },
                      child: const Text('%')),
                  ElevatedButton(
                      onPressed: () {
                        _calcular();
                      },
                      child: const Text('=')),
                ],
              ),
            ),
          ],
        ),
      ), // Essa vírgula à direita torna a formatação automática mais agradável para métodos de compilação.
    );
  }
}
