import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import 'detalhe_evento_screen.dart';

class EventosTab extends StatelessWidget {
  final List<Evento> eventos;
  final VoidCallback aoAtualizar;

  const EventosTab({super.key, required this.eventos, required this.aoAtualizar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acontecendo perto de você',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Cores.texto),
          ),
          const SizedBox(height: 4),
          const Text('Confirme presença e chame os vizinhos',
              style: TextStyle(color: Cores.textoSuave)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: eventos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, i) => _card(context, eventos[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, Evento e) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetalheEventoScreen(evento: e)),
        );
        aoAtualizar();
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [e.cor, Color.lerp(e.cor, Colors.black, 0.35)!],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(e.icone, color: Colors.white, size: 34),
            const Spacer(),
            Text('${e.data} · ${e.hora}',
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              e.titulo,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(e.confirmado ? Icons.check_circle : Icons.people_outline,
                    color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text('${e.confirmados} vão',
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
