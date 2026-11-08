import 'package:flutter/material.dart';
import '../theme.dart';
import 'welcome_screen.dart';

class PerfilScreen extends StatefulWidget {
  final String bairro;
  final int reportes;
  final int apoios;

  const PerfilScreen({
    super.key,
    required this.bairro,
    required this.reportes,
    required this.apoios,
  });

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool _alertaAlagamento = true;
  bool _alertaEventos = true;

  int get _pontos => widget.reportes * 10 + widget.apoios * 2;

  String get _nivel {
    if (_pontos < 20) return 'Vizinho Novato';
    if (_pontos < 60) return 'Vizinho Atento';
    return 'Guardião do Bairro';
  }

  Widget _numero(String valor, String rotulo) {
    return Expanded(
      child: Column(
        children: [
          Text(valor,
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w900, color: Cores.texto)),
          Text(rotulo, style: const TextStyle(color: Cores.textoSuave, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: Cores.amarelo,
                  child: Icon(Icons.person, size: 50, color: Cores.azul),
                ),
                const SizedBox(height: 12),
                const Text('Morador(a) do bairro',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                Text(widget.bairro, style: const TextStyle(color: Cores.textoSuave)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Cores.superficie,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Cores.borda),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Color(0xFFD99A00)),
                      const SizedBox(width: 8),
                      Text(_nivel,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (_pontos / 100).clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Cores.borda,
                      color: Cores.amarelo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$_pontos pontos de vizinhança',
                      style: const TextStyle(color: Cores.textoSuave)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _numero('${widget.reportes}', 'reportes'),
                      _numero('${widget.apoios}', 'apoios dados'),
                      _numero('$_pontos', 'pontos'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            activeColor: Cores.azul,
            title: const Text('Alertas de alagamento'),
            subtitle: const Text('Avisar quando chover forte perto de mim'),
            value: _alertaAlagamento,
            onChanged: (v) => setState(() => _alertaAlagamento = v),
          ),
          SwitchListTile(
            activeColor: Cores.azul,
            title: const Text('Novos eventos'),
            subtitle: const Text('Avisar sobre eventos no meu bairro'),
            value: _alertaEventos,
            onChanged: (v) => setState(() => _alertaEventos = v),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: Cores.azul),
            title: const Text('Trocar de bairro'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (rota) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
