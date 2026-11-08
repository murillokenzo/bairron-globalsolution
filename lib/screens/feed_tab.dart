import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets.dart';
import 'detalhe_ocorrencia_screen.dart';

class FeedTab extends StatefulWidget {
  final List<Ocorrencia> ocorrencias;
  final VoidCallback aoAtualizar;

  const FeedTab({super.key, required this.ocorrencias, required this.aoAtualizar});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  Categoria? _filtro;

  @override
  Widget build(BuildContext context) {
    final lista = widget.ocorrencias
        .where((o) => _filtro == null || o.categoria == _filtro)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: FiltroCategorias(
            selecionada: _filtro,
            aoMudar: (c) => setState(() => _filtro = c),
          ),
        ),
        Expanded(
          child: lista.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Nenhuma ocorrência nessa categoria.\nToque em "Reportar" se você viu algo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Cores.textoSuave),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                  itemCount: lista.length,
                  itemBuilder: (context, i) => _item(lista[i]),
                ),
        ),
      ],
    );
  }

  Widget _item(Ocorrencia o) {
    return Card(
      color: Cores.superficie,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Cores.borda),
      ),
      child: InkWell(
        onTap: () async {
          // Passa a ocorrência por parâmetro e atualiza a lista quando voltar
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetalheOcorrenciaScreen(ocorrencia: o)),
          );
          widget.aoAtualizar();
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: o.categoria.cor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(o.categoria.icone, color: o.categoria.cor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      o.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Cores.texto,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${o.rua} · ${o.tempo}',
                        style: const TextStyle(color: Cores.textoSuave, fontSize: 13)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SeloStatus(o.status),
                        const Spacer(),
                        Icon(
                          o.apoiado ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                          size: 16,
                          color: o.apoiado ? Cores.azul : Cores.textoSuave,
                        ),
                        const SizedBox(width: 4),
                        Text('${o.apoios}',
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
