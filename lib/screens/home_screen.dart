import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('GastitosEC')),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Integrantes',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                'David Chasi',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                'Cristian Roblero',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/transacciones/lista');
                  },
                  child: Text(
                    'Transacciones',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/configuracion');
                  },
                  child: Text(
                    'Configurar monto inicial',
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
