import 'package:flutter/material.dart';
import '../mock_data.dart';
import '../theme.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _bairro;

  void _entrar() {
    if (_bairro == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.erro,
          content: Text('Escolha o seu bairro para continuar'),
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen(bairro: _bairro!)),
    );
  }

  Widget _vantagem(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icone, color: Cores.amarelo, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(texto,
                style: const TextStyle(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.azul,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // "Placa de rua" com o logo
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: Cores.amarelo,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.location_on, color: Cores.azul, size: 34),
                    SizedBox(width: 8),
                    Text(
                      'BairroOn',
                      style: TextStyle(
                        color: Cores.azul,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'O que está\nacontecendo na\nsua rua?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              _vantagem(Icons.map_outlined, 'Veja problemas e obras no mapa do bairro'),
              _vantagem(Icons.campaign_outlined, 'Reporte e apoie quem mora perto de você'),
              _vantagem(Icons.event_available, 'Descubra eventos que acontecem na vizinhança'),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: DropdownButton<String>(
                  value: _bairro,
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text('Escolha o seu bairro'),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: bairros
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (valor) => setState(() => _bairro = valor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _entrar,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Entrar no bairro',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cores.amarelo,
                    foregroundColor: Cores.azul,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
