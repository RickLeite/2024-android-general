import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;
  int maxCapacity = 20;
  final TextEditingController _capacityController = TextEditingController();
  List<String> movementHistory = [];

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      contador = prefs.getInt('contador') ?? 0;
      maxCapacity = prefs.getInt('maxCapacity') ?? 20;
    });
  }

  void onDecrement() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      contador = (prefs.getInt('contador') ?? 0) - 1;
      prefs.setInt('contador', contador);
    });
    addMovementToHistory("Carro $contador saiu");
  }

  void onIncrement() async {
    final prefs = await SharedPreferences.getInstance();
    if (contador < maxCapacity) {
      setState(() {
        contador = (prefs.getInt('contador') ?? 0) + 1;
        prefs.setInt('contador', contador);
      });
      addMovementToHistory("Carro $contador entrou");
    }
  }

  Future<void> _updateMaxCapacity() async {
    final prefs = await SharedPreferences.getInstance();
    final int? newCapacity = int.tryParse(_capacityController.text);

    if (newCapacity != null && newCapacity >= 0) {
      if (contador <= newCapacity) {
        setState(() {
          maxCapacity = newCapacity;
          if (contador > maxCapacity) {
            contador = maxCapacity;
            prefs.setInt('contador', contador);
          }
          prefs.setInt('maxCapacity', maxCapacity);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Capacidade Maxima Atualizada para $maxCapacity")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Carros precisam sair para acomodar nova capacidade")));
      }
    }
  }

  void addMovementToHistory(String movement) {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    final formatted = formatter.format(now);

    setState(() {
      movementHistory.insert(0, "$formatted: $movement");
      if (movementHistory.length > 5) {
        movementHistory.removeLast();
      }
    });
  }

  bool get estaVazio => contador == 0;
  bool get estaCheio => contador == maxCapacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Text(
                estaCheio
                    ? "Estacionamento cheio!"
                    : estaVazio
                        ? "Estacionamento vazio!"
                        : "Vagas disponíveis!",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  "$contador/$maxCapacity",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: estaVazio
                          ? Colors.white.withOpacity(0.4)
                          : Colors.white,
                      foregroundColor: Colors.black,
                      fixedSize: Size(100, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: estaVazio ? null : onDecrement,
                  child: Text(
                    estaVazio ? "Vazio" : "Carro saiu",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: estaCheio
                          ? Colors.red.withOpacity(0.4)
                          : Colors.white,
                      foregroundColor: Colors.black,
                      fixedSize: Size(100, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: estaCheio ? null : onIncrement,
                  child: Text(
                    estaCheio ? "Cheio" : "Carro entrou",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
            for (var movement in movementHistory)
              Container(
                color: Colors.black,
                child: Text(
                  movement,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Capacidade Máxima',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _updateMaxCapacity,
                    child: Text('Definir capacidade'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
