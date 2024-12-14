import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? endereco = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Detalhes do Endereço'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: endereco == null
              ? Text('Nenhuma informação foi passada para esta página.')
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Logradouro: ${endereco['logradouro'] ?? 'Não informado'}'),
              Text('Bairro: ${endereco['bairro'] ?? 'Não informado'}'),
              Text('Cidade: ${endereco['localidade'] ?? 'Não informado'}'),
              Text('Estado: ${endereco['uf'] ?? 'Não informado'}'),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
