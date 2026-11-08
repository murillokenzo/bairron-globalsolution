import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets.dart';

class DetalheOcorrenciaScreen extends StatefulWidget {
  final Ocorrencia ocorrencia; // recebida por parâmetro
  const DetalheOcorrenciaScreen({super.key, required this.ocorrencia});

  @override
  State<DetalheOcorrenciaScreen> createState() => _DetalheOcorrenciaScreenState();
}

class _DetalheOcorrenciaScreenState extends State<DetalheOcorrenciaScreen> {
  void _alternarApoio() {
    final o = widget.ocorrencia;
    setState(() {
      o.apoiado = !o.apoiado;
      o.apoiado ? o.apoios++ : o.apoios--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Cores.azul,
        content: Text(o.apoiado
            ? 'Você apoiou! Quanto mais apoios, mais rápido a prefeitura prioriza.'
            : 'Apoio removido.'),
      ),
    );
  }

  Widget _etapas(Ocorrencia o) {
    const nomes = ['Reportado', 'Em análise', 'Resolvido'];
    final atual = nomes.indexOf(o.status);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(nomes.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Container(
                height: 3,
                color: (i ~/ 2) < atual ? Cores.azul : Cores.borda,
              ),
            ),
          );
        }
        final idx = i ~/ 2;
        final ativa = idx <= atual;
        return Column(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: ativa ? Cores.azul : Cores.borda,
              child: Icon(
                ativa ? Icons.check : Icons.circle_outlined,
                size: 16,
                color: ativa ? Cores.amarelo : Cores.textoSuave,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              nomes[idx],
              style: TextStyle(
                fontSize: 11,
                fontWeight: ativa ? FontWeight.w700 : FontWeight.w400,
                color: ativa ? Cores.texto : Cores.textoSuave,
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.ocorrencia;

    return Scaffold(
      appBar: AppBar(title: Text(o.categoria.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Foto ilustrativa (mock). Se estiver sem internet, mostra um ícone.
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://picsum.photos/seed/bairroon${o.id}/800/400',
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, erro, stack) => Container(
                height: 190,
                color: o.categoria.cor.withOpacity(0.15),
                child: Icon(o.categoria.icone, size: 64, color: o.categoria.cor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(o.categoria.icone, color: o.categoria.cor, size: 18),
              const SizedBox(width: 6),
              Text(o.categoria.nome,
                  style: TextStyle(color: o.categoria.cor, fontWeight: FontWeight.w700)),
              const Spacer(),
              SeloStatus(o.status),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            o.titulo,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w900, height: 1.15, color: Cores.texto),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.place_outlined, size: 18, color: Cores.textoSuave),
              const SizedBox(width: 4),
              Expanded(
                child: Text('${o.rua} · ${o.tempo}',
                    style: const TextStyle(color: Cores.textoSuave)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(o.descricao, style: const TextStyle(fontSize: 16, height: 1.4)),
          const SizedBox(height: 24),
          const Text('Andamento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          _etapas(o),
          const SizedBox(height: 28),
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _alternarApoio,
              icon: Icon(o.apoiado ? Icons.thumb_up : Icons.thumb_up_alt_outlined),
              label: Text(
                o.apoiado ? 'Apoiado · ${o.apoios}' : 'Apoiar · ${o.apoios}',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: o.apoiado ? Cores.azul : Cores.amarelo,
                foregroundColor: o.apoiado ? Colors.white : Cores.azul,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
