import 'dart:ffi';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';

const List<Widget> maae = <Widget>[
  Text('Sim'),
  Text('Não')
];

void main() {
  runApp(MaterialApp(
    home: Home(), //stateful widget para podermos interagir
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<bool> _selectedMae = <bool>[true, true];

  String _familia = "";
  TextEditingController auxControlle = TextEditingController();
  double _tamanhoTextoCampoDeTexto = 25.0;
  double _tamanhoFonteTextoInfo = 30.0;
  double _tamanhoFonteBotao = 20.0;
  double _paddingBotao = 30.0;
  double _paddingScrollView = 30.0;

  String _textoInfo = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get filho => 1;
  get salario => 1212;

  void _resetFields(){
    _formKey = GlobalKey<FormState>();
    setState(() {
      _textoInfo = "Informe seus dados"
          ""
          "caso seja mãe tem direito à +600 reais";
    });
  }

  void _calcular(){
    setState(() {
      var familiaController;
      double salario = double.parse(familiaController.text) / 100.0; //por 100 pois a altura precisa ser em metros

      double ren = (auxControlle = (salario * salario) as TextEditingController) as double;
      double fil = (auxControlle = (filho * filho) as TextEditingController) as double;

      //alterando o info
      if (ren < 2424 || fil <= 2) {
        _textoInfo = "1,5 salário mínimo";
      } else if (ren < 1212 || fil <= 2) {
        _textoInfo = "2,5 salários mínimos";
      } else if (fil > 3) {
        _textoInfo = "3 salários mínimos";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Meu auxílio"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Novo auxílio', //ao segurar o butão
                onPressed: _resetFields
            ),
          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_paddingScrollView, 0.0, _paddingScrollView, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //esticar para preencher

            children: <Widget>[
              Icon(Icons.family_restroom, size: 80, color: Colors.black),

              DropdownButton(items: const
              [
                DropdownMenuItem(child: Text("Salário"), value: ""),
                DropdownMenuItem(child: Text("Até dois salários mínimos"), value: "Até dois salários mínimos"),
                DropdownMenuItem(child: Text("Até um salário mínimo"), value: "Até um salário mínimo"),
              ],
                  value: _familia,
                  onChanged: (String? value){
                    if (value is String){
                      setState(() {
                        _familia = value;
                      });
                    }
                  }),
              ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.check),
                    Icon(Icons.cancel_outlined),
                  ],
                  isSelected: _selectedMae,
                  onPressed: (int index) {
                    setState(() {
                      maae[index] = maae[index];
                    });
                  }
              ),


              TextFormField(
                keyboardType: TextInputType.number, //aciona o teclado numérico
                decoration: InputDecoration(
                  //rotulo do campo de texto
                  labelText: "Filhos",
                  labelStyle: TextStyle(
                      color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                controller: auxControlle,
                validator: (value){
                  if(value.toString().isEmpty) {
                    return "Informe a quantidade de filhos";
                  }if(filho > 2) {
                    return "Direito a 3 salários mínimos";
                  }if(filho <= 2){
                    return "Até 1 salário recebe 1,5 salários"
                        "Até 2 salário recebe 2,5 salários";
                  }
                }, //validator
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingBotao, bottom: _paddingBotao),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Calcular',
                        style: TextStyle(fontSize: _tamanhoFonteBotao)),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){ //se meu formulário estiver validado
                        _calcular();
                      }
                    },
                  ),
                ),
              ),
              Text(
                "$_textoInfo",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: _tamanhoFonteTextoInfo,
                ),
                textAlign: TextAlign.center,
              ),
              //Testar dps
              /*IconButton(
                icon: Icon(Icons.filter_drama),
                onPressed: () {},
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}