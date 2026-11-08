import 'package:flutter/material.dart';

class Cores {
  static const fundo = Color(0xFFEEF3F8);
  static const superficie = Colors.white;
  static const azul = Color(0xFF0E2A47);
  static const amarelo = Color(0xFFFFC93C);
  static const texto = Color(0xFF14213D);
  static const textoSuave = Color(0xFF5F7084);
  static const erro = Color(0xFFE5484D);
  static const borda = Color(0xFFD9E2EC);
  static const mapaFundo = Color(0xFFE3EBF3);
  static const mapaRua = Colors.white;
  static const mapaParque = Color(0xFFCDE9D3);
}

ThemeData criarTema() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Cores.fundo,
    colorScheme: const ColorScheme.light(
      primary: Cores.azul,
      secondary: Cores.amarelo,
      surface: Cores.superficie,
      error: Cores.erro,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Cores.azul,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
  );
}
