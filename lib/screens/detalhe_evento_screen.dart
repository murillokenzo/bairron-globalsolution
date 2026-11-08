import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

class DetalheEventoScreen extends StatefulWidget {
  final Evento evento; // recebido por parâmetro
  const DetalheEventoScreen({super.key, required this.evento});

  @override
  State<DetalheEventoScreen> createState() => _DetalheEventoScreenState();
}

class _DetalheEventoScreenState extends State<DetalheEventoScreen> {
  void _alternarPresenca() {
    final e = widget.evento;
    setState(() {
      e.confirmado = !e.confirmado;
      e.confirmado ? e.confirmados++ : e.confirmados--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Cores.azul,
        content: Text(e.confirmado ? 'Presença confirmada!' : 'Presença cancelada.'),
      ),
    );
  }

  Widget _info(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Cores.amarelo.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 20, color: Cores.azul),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(texto,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.evento;

    return Scaffold(
      appBar: AppBar(title: const Text('Evento')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [e.cor, Color.lerp(e.cor, Colors.black, 0.35)!],
              ),
            ),
            child: Center(child: Icon(e.icone, color: Colors.white, size: 72)),
          ),
          const SizedBox(height: 20),
          Text(
            e.titulo,
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w900, height: 1.15, color: Cores.texto),
          ),
          const SizedBox(height: 16),
          _info(Icons.calendar_today, e.data),
          _info(Icons.access_time, e.hora),
          _info(Icons.place_outlined, e.local),
          _info(Icons.people_outline, '${e.confirmados} vizinhos confirmados'),
          const SizedBox(height: 8),
          Text(e.descricao, style: const TextStyle(fontSize: 16, height: 1.4)),
          const SizedBox(height: 28),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _alternarPresenca,
              icon: Icon(e.confirmado ? Icons.check_circle : Icons.event_available),
              label: Text(
                e.confirmado ? 'Presença confirmada' : 'Confirmar presença',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: e.confirmado ? Cores.azul : Cores.amarelo,
                foregroundColor: e.confirmado ? Colors.white : Cores.azul,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
