import 'package:flutter/material.dart';

enum Categoria { buraco, iluminacao, alagamento, lixo, transito, seguranca }

extension CategoriaInfo on Categoria {
  String get nome => switch (this) {
        Categoria.buraco => 'Buraco',
        Categoria.iluminacao => 'Iluminação',
        Categoria.alagamento => 'Alagamento',
        Categoria.lixo => 'Lixo/Entulho',
        Categoria.transito => 'Trânsito',
        Categoria.seguranca => 'Segurança',
      };

  IconData get icone => switch (this) {
        Categoria.buraco => Icons.construction,
        Categoria.iluminacao => Icons.lightbulb_outline,
        Categoria.alagamento => Icons.water_drop,
        Categoria.lixo => Icons.delete_outline,
        Categoria.transito => Icons.traffic,
        Categoria.seguranca => Icons.shield_outlined,
      };

  Color get cor => switch (this) {
        Categoria.buraco => const Color(0xFFE8590C),
        Categoria.iluminacao => const Color(0xFFD99A00),
        Categoria.alagamento => const Color(0xFF1C7ED6),
        Categoria.lixo => const Color(0xFF7048E8),
        Categoria.transito => const Color(0xFFE5484D),
        Categoria.seguranca => const Color(0xFF2F9E6B),
      };
}

class Ocorrencia {
  final String id;
  final String titulo;
  final String descricao;
  final String rua;
  final String tempo;
  final Categoria categoria;
  final double x; // posição no mapa (-1 a 1)
  final double y;
  String status; // Reportado, Em análise, Resolvido
  int apoios;
  bool apoiado;

  Ocorrencia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.rua,
    required this.tempo,
    required this.categoria,
    required this.x,
    required this.y,
    this.status = 'Reportado',
    this.apoios = 0,
    this.apoiado = false,
  });
}

class Evento {
  final String id;
  final String titulo;
  final String descricao;
  final String local;
  final String data;
  final String hora;
  final IconData icone;
  final Color cor;
  final double x;
  final double y;
  int confirmados;
  bool confirmado;

  Evento({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.data,
    required this.hora,
    required this.icone,
    required this.cor,
    required this.x,
    required this.y,
    this.confirmados = 0,
    this.confirmado = false,
  });
}
