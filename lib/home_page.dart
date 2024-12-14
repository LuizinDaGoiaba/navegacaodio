import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String respostaFinal = '';
  final dio = Dio();
  Map<String, dynamic>? endereco;
  final TextEditingController _cepController = TextEditingController(); // Controller para capturar o CEP

  Future<Map<String, dynamic>> getHttp(String cep) async {
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      print(response);
      return response.data;
    } catch (e) {
      return {
        'erro': 'Não foi possível buscar o endereço. Verifique o CEP informado.'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Consumo de API usando Dio'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Digite o CEP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  String cep = _cepController.text.trim();

                  if (cep.isEmpty || cep.length != 8) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, insira um CEP válido com 8 dígitos.')),
                    );
                    return;
                  }

                  Map<String, dynamic> enderecoAuxiliar = await getHttp(cep);

                  if (enderecoAuxiliar.containsKey('erro')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('CEP inválido ou não encontrado.')),
                    );
                  } else {
                    setState(() {
                      endereco = enderecoAuxiliar;
                    });
                  }
                },
                child: Text('Consultar'),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (endereco != null && endereco!['erro'] == null) {
                    Navigator.pushNamed(
                      context,
                      '/homePage2',
                      arguments: endereco,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Realize a consulta de um CEP válido primeiro!')),
                    );
                  }
                },
                child: Text('Ir para a próxima página'),
              ),
              SizedBox(height: 25),
              Text('${endereco?['logradouro'] ?? ''}'),
              Text('${endereco?['bairro'] ?? ''}'),
              Text('${endereco?['localidade'] ?? ''}'),
              Text('${endereco?['uf'] ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}