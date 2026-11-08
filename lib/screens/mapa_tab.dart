import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets.dart';
import 'detalhe_evento_screen.dart';
import 'detalhe_ocorrencia_screen.dart';

class MapaTab extends StatefulWidget {
  final List<Ocorrencia> ocorrencias;
  final List<Evento> eventos;
  final VoidCallback aoAtualizar;

  const MapaTab({
    super.key,
    required this.ocorrencias,
    required this.eventos,
    required this.aoAtualizar,
  });

  @override
  State<MapaTab> createState() => _MapaTabState();
}

class _MapaTabState extends State<MapaTab> {
  Categoria? _filtro;
  bool _mostrarEventos = true;
  Object? _selecionado; // pode ser Ocorrencia ou Evento

  Widget _stat(IconData icone, String valor, String rotulo, Color cor) {
    return Expanded(
      child: Card(
        color: Cores.superficie,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Cores.borda),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icone, color: cor),
              const SizedBox(height: 8),
              Text(valor,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900, color: Cores.texto)),
              Text(rotulo,
                  style: const TextStyle(fontSize: 12, color: Cores.textoSuave)),
            ],
          ),
        ),
      ),
    );
  }

  // Rua do mapa: faixa branca horizontal ou vertical
  Widget _rua(bool horizontal, double pos) {
    return Align(
      alignment: horizontal ? Alignment(0, pos) : Alignment(pos, 0),
      child: Container(
        width: horizontal ? double.infinity : 18,
        height: horizontal ? 18 : double.infinity,
        color: Cores.mapaRua,
      ),
    );
  }

  Widget _pino(Alignment pos, Color cor, IconData icone, bool ativo, VoidCallback aoTocar) {
    final tamanho = ativo ? 48.0 : 36.0;
    return Align(
      alignment: pos,
      child: GestureDetector(
        onTap: aoTocar,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: tamanho,
          height: tamanho,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: ativo ? 3 : 2),
            boxShadow: [
              BoxShadow(
                color: cor.withOpacity(0.5),
                blurRadius: ativo ? 14 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icone, color: Colors.white, size: ativo ? 26 : 18),
        ),
      ),
    );
  }

  Widget _mapa(List<Ocorrencia> visiveis) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 330,
        color: Cores.mapaFundo,
        child: Stack(
          children: [
            _rua(true, -0.6),
            _rua(true, 0.1),
            _rua(true, 0.78),
            _rua(false, -0.6),
            _rua(false, 0.0),
            _rua(false, 0.62),
            // Praça/parque
            Align(
              alignment: const Alignment(0.85, -0.9),
              child: Container(
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                  color: Cores.mapaParque,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.park, color: Color(0xFF2F9E6B)),
              ),
            ),
            // Você está aqui
            const Align(
              alignment: Alignment(0.0, 0.1),
              child: Icon(Icons.my_location, color: Cores.azul, size: 22),
            ),
            ...visiveis.map(
              (o) => _pino(
                Alignment(o.x, o.y),
                o.categoria.cor,
                o.categoria.icone,
                _selecionado == o,
                () => setState(() => _selecionado = o),
              ),
            ),
            if (_mostrarEventos)
              ...widget.eventos.map(
                (e) => _pino(
                  Alignment(e.x, e.y),
                  Cores.azul,
                  Icons.star,
                  _selecionado == e,
                  () => setState(() => _selecionado = e),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoSelecionado() {
    final s = _selecionado;
    Widget conteudo;

    if (s is Ocorrencia) {
      conteudo = ListTile(
        key: ValueKey(s.id),
        leading: CircleAvatar(
          backgroundColor: s.categoria.cor.withOpacity(0.15),
          child: Icon(s.categoria.icone, color: s.categoria.cor),
        ),
        title: Text(s.titulo, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('${s.rua} · ${s.apoios} apoios'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetalheOcorrenciaScreen(ocorrencia: s)),
          );
          widget.aoAtualizar();
        },
      );
    } else if (s is Evento) {
      conteudo = ListTile(
        key: ValueKey(s.id),
        leading: CircleAvatar(
          backgroundColor: Cores.azul,
          child: Icon(s.icone, color: Cores.amarelo),
        ),
        title: Text(s.titulo, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('${s.data} às ${s.hora} · ${s.local}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetalheEventoScreen(evento: s)),
          );
          widget.aoAtualizar();
        },
      );
    } else {
      conteudo = const ListTile(
        key: ValueKey('vazio'),
        leading: Icon(Icons.touch_app_outlined, color: Cores.textoSuave),
        title: Text('Toque em um pino para ver os detalhes'),
        subtitle: Text('Estrelas são eventos, os outros ícones são ocorrências'),
      );
    }

    return Card(
      color: Cores.superficie,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Cores.borda),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: conteudo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visiveis = widget.ocorrencias
        .where((o) => _filtro == null || o.categoria == _filtro)
        .toList();
    final abertas = widget.ocorrencias.where((o) => o.status != 'Resolvido').length;
    final resolvidas = widget.ocorrencias.length - abertas;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      children: [
        Row(
          children: [
            _stat(Icons.warning_amber_rounded, '$abertas', 'em aberto', const Color(0xFFE8590C)),
            const SizedBox(width: 8),
            _stat(Icons.check_circle_outline, '$resolvidas', 'resolvidas', const Color(0xFF2F9E6B)),
            const SizedBox(width: 8),
            _stat(Icons.event, '${widget.eventos.length}', 'eventos', Cores.azul),
          ],
        ),
        const SizedBox(height: 16),
        FiltroCategorias(
          selecionada: _filtro,
          aoMudar: (c) => setState(() {
            _filtro = c;
            _selecionado = null;
          }),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          activeColor: Cores.azul,
          title: const Text('Mostrar eventos no mapa',
              style: TextStyle(fontWeight: FontWeight.w600)),
          value: _mostrarEventos,
          onChanged: (v) => setState(() {
            _mostrarEventos = v;
            _selecionado = null;
          }),
        ),
        _mapa(visiveis),
        const SizedBox(height: 12),
        _cartaoSelecionado(),
      ],
    );
  }
}
