import 'package:flutter/material.dart';
import '../mock_data.dart';
import '../models.dart';
import '../theme.dart';
import 'eventos_tab.dart';
import 'feed_tab.dart';
import 'mapa_tab.dart';
import 'perfil_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  final String bairro;
  const HomeScreen({super.key, required this.bairro});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _aba = 0;
  int _meusReportes = 0;
  late List<Ocorrencia> _ocorrencias;
  late List<Evento> _eventos;

  @override
  void initState() {
    super.initState();
    _ocorrencias = criarOcorrenciasMock();
    _eventos = criarEventosMock();
  }

  void _atualizar() => setState(() {});

  int get _abertas => _ocorrencias.where((o) => o.status != 'Resolvido').length;

  Future<void> _reportar() async {
    // A tela de report devolve a nova ocorrência ao fechar (pop com resultado)
    final nova = await Navigator.push<Ocorrencia>(
      context,
      MaterialPageRoute(builder: (_) => ReportScreen(bairro: widget.bairro)),
    );
    if (nova == null || !mounted) return;
    setState(() {
      _ocorrencias.insert(0, nova);
      _meusReportes++;
      _aba = 0; // volta pro mapa pra ver o pino novo
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Cores.azul,
        content: Text('Ocorrência publicada no mapa do bairro!'),
      ),
    );
  }

  void _abrirPerfil() {
    final apoiosDados = _ocorrencias.where((o) => o.apoiado).length;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PerfilScreen(
          bairro: widget.bairro,
          reportes: _meusReportes,
          apoios: apoiosDados,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final abas = [
      MapaTab(ocorrencias: _ocorrencias, eventos: _eventos, aoAtualizar: _atualizar),
      FeedTab(ocorrencias: _ocorrencias, aoAtualizar: _atualizar),
      EventosTab(eventos: _eventos, aoAtualizar: _atualizar),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BairroOn',
              style: TextStyle(
                fontSize: 12,
                color: Cores.amarelo,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              widget.bairro,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$_abertas'),
              child: const Icon(Icons.notifications_none),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Há $_abertas ocorrências abertas no seu bairro')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: _abrirPerfil,
          ),
        ],
      ),
      body: IndexedStack(index: _aba, children: abas),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _reportar,
        backgroundColor: Cores.amarelo,
        foregroundColor: Cores.azul,
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Reportar', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aba,
        backgroundColor: Cores.superficie,
        indicatorColor: Cores.amarelo,
        onDestinationSelected: (i) => setState(() => _aba = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Mapa'),
          NavigationDestination(
              icon: Icon(Icons.list_alt), selectedIcon: Icon(Icons.list_alt), label: 'Ocorrências'),
          NavigationDestination(
              icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Eventos'),
        ],
      ),
    );
  }
}
