import 'dart:math';
import 'package:flutter/material.dart';
import 'botoes.dart';
import 'text.dart';
 
void main() {
  runApp(const MainApp());
}
 
class MainApp extends StatelessWidget {
  const MainApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: sistemaJuros(), debugShowCheckedModeBanner: false,);
  }
}
 
  class sistemaJuros extends StatefulWidget{
    @override
    State<sistemaJuros> createState() => _sistemaJurosState();
  }
 
  class _sistemaJurosState extends State<sistemaJuros>{
    final valorInicialController = TextEditingController(text:"1000");
    final aporteMensalController = TextEditingController(text:"500");
    final taxaJurosController = TextEditingController(text:"1.2");
    final quantidadeMesesController = TextEditingController(text:"24");
    final metaFinanceiraController = TextEditingController(text:"30000");
 
    String resultado = "";
    String meta = "";
    String perfil = "";
    double montante = 0;
    double investimento = 0;
    double lucro = 0;
    double juros = 0;
 
 
    void calcular(){
      double valorInicial = double.tryParse(valorInicialController.text) ?? 0;
      double aporteMensal = double.tryParse(aporteMensalController.text) ?? 0;
      double taxaJuros = double.tryParse(taxaJurosController.text) ?? 0;
      double quantidadeMeses = double.tryParse(quantidadeMesesController.text) ?? 0;
      double metaFinanceira = double.tryParse(metaFinanceiraController.text) ?? 0;
 
      double juros = taxaJuros/100;
 
      setState(() {
        montante = valorInicial *(1 + juros)*quantidadeMeses;
        investimento = valorInicial + (aporteMensal*quantidadeMeses);
        lucro = montante - investimento;
 
      if(montante >= metaFinanceira){
          meta = "Meta alcançada";
      }
      else{
        double metaFaltante = metaFinanceira - montante;
          meta = "Para bater a meta, falta: ${metaFaltante.toStringAsFixed(2)}";
      }
 
      if(taxaJuros<0.5){
          perfil = "Seu perfil é conservador";
      }
      if(taxaJuros>=0.5 && taxaJuros<=1.5){
          perfil = "Seu perfil é moderado";
      }
      if(taxaJuros>1.5){
          perfil = "Seu perfil é agressivo";
      }
      mostrarToast("Simulação realizada com sucesso");
      }
      );  
    }
 
    void limpar(){
      valorInicialController.clear();
      aporteMensalController.clear();
      taxaJurosController.clear();
      quantidadeMesesController.clear();
      metaFinanceiraController.clear();
      mostrarToast("Dados removidos com sucesso");
      setState(() {
        montante = 0;
        investimento = 0;
        meta="";
        lucro = 0;
        perfil="";
      });
    }
 
    void exemplo(){
      valorInicialController.text = "1000";
      aporteMensalController.text = "500";
      taxaJurosController.text = "1.2";
      quantidadeMesesController.text = "24";
      metaFinanceiraController.text = "30000";
      mostrarToast("Dados de exemplos carregados");
    }
 
    void mostrarAlert(){
      showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('O que deseja?'),
          content: Text(""),
          actions: [
            TextButton(
              onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
            ),
 
            TextButton(
              onPressed: () {
              limpar();
              Navigator.pop(context);
            },
            child: const Text('Limpar tudo')),
 
            TextButton(
              onPressed: () {
              exemplo();
              Navigator.pop(context);
            },
            child: const Text('Carregar exemplo'))
          ],
        );
      }
      );
    }
 
    void mostrarToast(String mensagem){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagem),
          duration: const Duration(seconds: 3),
          )
      );
    }
 
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // cor de fundo
        title: const Text(
          "Cálculos financeiros",
          style: TextStyle(
            color: Colors.white, // cor do texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          campoTexto(label: "Valor Inicial", controller: valorInicialController),
 
          campoTexto(label: "Aporte Mensal", controller: aporteMensalController,tipo: TextInputType.number),
 
          campoTexto(label: "Taxa de Juros", controller: taxaJurosController,tipo: TextInputType.number),
 
          campoTexto(label: "Meses", controller: quantidadeMesesController,tipo: TextInputType.number),
 
          campoTexto(label: "Meta financeira", controller: metaFinanceiraController,tipo: TextInputType.number),
 
          Row(
            children: [
              botao(texto: "Limpar", onPressed: mostrarAlert, cor: Colors.red),
              botao(texto: "Calcular", onPressed: calcular, cor: Colors.blue),
            ],
          ),
          Text("Montante final: ${montante.toStringAsFixed(2)}"),
          Text("Total investido: ${investimento.toStringAsFixed(2)}"),
          Text("Lucro: ${lucro.toStringAsFixed(2)}"),
          Text("Meta: ${meta}"),
          Text("Perfil financeiro: ${perfil}"),
        ],
      ),
    );
  }
  }
