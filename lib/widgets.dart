import 'package:flutter/material.dart';
import 'models.dart';
import 'theme.dart';

InputDecoration decoracaoCampo(String rotulo, IconData icone) {
  OutlineInputBorder borda(Color cor, [double largura = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cor, width: largura),
      );
  return InputDecoration(
    labelText: rotulo,
    prefixIcon: Icon(icone),
    filled: true,
    fillColor: Cores.superficie,
    border: borda(Cores.borda),
    enabledBorder: borda(Cores.borda),
    focusedBorder: borda(Cores.azul, 2),
    errorBorder: borda(Cores.erro),
    focusedErrorBorder: borda(Cores.erro, 2),
  );
}

Color corStatus(String status) => switch (status) {
      'Resolvido' => const Color(0xFF2F9E6B),
      'Em análise' => const Color(0xFFD99A00),
      _ => const Color(0xFFE8590C),
    };

class SeloStatus extends StatelessWidget {
  final String status;
  const SeloStatus(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final cor = corStatus(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: cor, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class FiltroCategorias extends StatelessWidget {
  final Categoria? selecionada;
  final ValueChanged<Categoria?> aoMudar;

  const FiltroCategorias({
    super.key,
    required this.selecionada,
    required this.aoMudar,
  });

  Widget _chip(String nome, IconData icone, Color cor, bool ativo, VoidCallback aoTocar) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        avatar: Icon(icone, size: 18, color: ativo ? Colors.white : cor),
        label: Text(nome),
        selected: ativo,
        showCheckmark: false,
        selectedColor: cor,
        backgroundColor: Cores.superficie,
        labelStyle: TextStyle(
          color: ativo ? Colors.white : Cores.texto,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: ativo ? cor : Cores.borda),
        onSelected: (_) => aoTocar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _chip('Todas', Icons.apps, Cores.azul, selecionada == null,
              () => aoMudar(null)),
          ...Categoria.values.map(
            (c) => _chip(c.nome, c.icone, c.cor, selecionada == c, () => aoMudar(c)),
          ),
        ],
      ),
    );
  }
}
