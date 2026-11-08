import 'dart:math';
import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets.dart';

class ReportScreen extends StatefulWidget {
  final String bairro;
  const ReportScreen({super.key, required this.bairro});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _ruaCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  Categoria? _categoria;

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _ruaCtrl.dispose();
    _descricaoCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.erro,
          content: Text('Confira os campos destacados em vermelho'),
        ),
      );
      return;
    }

    // Posição aleatória no mapa (como os dados são mock, não usamos GPS)
    final sorteio = Random();
    final nova = Ocorrencia(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: _tituloCtrl.text.trim(),
      descricao: _descricaoCtrl.text.trim(),
      rua: _ruaCtrl.text.trim(),
      tempo: 'agora',
      categoria: _categoria!,
      x: sorteio.nextDouble() * 1.4 - 0.7,
      y: sorteio.nextDouble() * 1.4 - 0.7,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Color(0xFF2F9E6B), size: 48),
        title: const Text('Ocorrência enviada!'),
        content: Text(
          'Obrigado por ajudar o ${widget.bairro}. Seus vizinhos já podem ver e apoiar o seu relato.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // fecha o diálogo
              Navigator.pop(context, nova); // devolve a ocorrência para a Home
            },
            child: const Text('Ver no mapa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar problema')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'O que você viu em ${widget.bairro}?',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w900, color: Cores.texto),
            ),
            const SizedBox(height: 4),
            const Text('Quanto mais detalhes, mais rápido os vizinhos apoiam.',
                style: TextStyle(color: Cores.textoSuave)),
            const SizedBox(height: 20),
            DropdownButtonFormField<Categoria>(
              value: _categoria,
              decoration: decoracaoCampo('Tipo de problema', Icons.category_outlined),
              items: Categoria.values
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Row(
                          children: [
                            Icon(c.icone, color: c.cor, size: 20),
                            const SizedBox(width: 10),
                            Text(c.nome),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (c) => setState(() => _categoria = c),
              validator: (c) => c == null ? 'Escolha o tipo de problema' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tituloCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: decoracaoCampo('Título', Icons.title),
              validator: (v) {
                if (v == null || v.trim().length < 5) {
                  return 'O título precisa ter pelo menos 5 letras';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ruaCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: decoracaoCampo('Rua ou ponto de referência', Icons.place_outlined),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Informe onde fica o problema';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descricaoCtrl,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: decoracaoCampo('Descrição', Icons.notes),
              validator: (v) {
                if (v == null || v.trim().length < 15) {
                  return 'Descreva melhor (mínimo de 15 caracteres)';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _enviar,
                icon: const Icon(Icons.send),
                label: const Text('Publicar no bairro',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cores.amarelo,
                  foregroundColor: Cores.azul,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
