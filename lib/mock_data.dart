import 'package:flutter/material.dart';
import 'models.dart';

const List<String> bairros = [
  'Vila Mariana',
  'Pinheiros',
  'Tatuapé',
  'Mooca',
  'Santo Amaro',
  'Butantã',
];

// Dados mockados (o enunciado permite). Funções criam cópias novas.
List<Ocorrencia> criarOcorrenciasMock() => [
      Ocorrencia(
        id: '1',
        titulo: 'Buraco enorme na Rua das Acácias',
        descricao:
            'Buraco com mais de 1 metro de largura em frente ao número 120. Já furou dois pneus esta semana e as motos desviam para a contramão.',
        rua: 'Rua das Acácias, 120',
        tempo: 'há 2 h',
        categoria: Categoria.buraco,
        x: -0.55,
        y: -0.3,
        apoios: 23,
        status: 'Em análise',
      ),
      Ocorrencia(
        id: '2',
        titulo: 'Poste apagado na praça central',
        descricao:
            'Três postes seguidos estão sem luz há uma semana. À noite a praça fica completamente escura.',
        rua: 'Praça Dom Pedro',
        tempo: 'há 5 h',
        categoria: Categoria.iluminacao,
        x: 0.1,
        y: -0.6,
        apoios: 41,
      ),
      Ocorrencia(
        id: '3',
        titulo: 'Ponto de alagamento após chuva',
        descricao:
            'Sempre que chove forte a água sobe quase 40 cm perto da galeria. Carros ficam presos.',
        rua: 'Av. do Córrego, esquina com Rua 7',
        tempo: 'ontem',
        categoria: Categoria.alagamento,
        x: 0.6,
        y: 0.35,
        apoios: 67,
        status: 'Em análise',
      ),
      Ocorrencia(
        id: '4',
        titulo: 'Entulho abandonado na calçada',
        descricao:
            'Sobras de obra ocupam toda a calçada e obrigam pedestres e cadeirantes a andar na rua.',
        rua: 'Rua dos Ipês, 340',
        tempo: 'há 2 dias',
        categoria: Categoria.lixo,
        x: -0.2,
        y: 0.5,
        apoios: 12,
      ),
      Ocorrencia(
        id: '5',
        titulo: 'Semáforo travado no vermelho',
        descricao:
            'O semáforo do cruzamento fica no vermelho por mais de 5 minutos no horário de pico.',
        rua: 'Av. Brasil com Rua das Flores',
        tempo: 'há 3 dias',
        categoria: Categoria.transito,
        x: 0.35,
        y: -0.1,
        apoios: 35,
        status: 'Resolvido',
      ),
      Ocorrencia(
        id: '6',
        titulo: 'Beco sem iluminação e com assaltos',
        descricao:
            'Moradores relatam assaltos no beco ao lado da escola, principalmente depois das 19h.',
        rua: 'Beco da Escola',
        tempo: 'há 4 dias',
        categoria: Categoria.seguranca,
        x: -0.7,
        y: 0.1,
        apoios: 52,
      ),
      Ocorrencia(
        id: '7',
        titulo: 'Bueiro entupido',
        descricao:
            'O bueiro está cheio de folhas e lixo. Com a próxima chuva a rua deve alagar de novo.',
        rua: 'Rua Jasmim, 55',
        tempo: 'há 1 semana',
        categoria: Categoria.alagamento,
        x: 0.0,
        y: 0.75,
        apoios: 18,
        status: 'Resolvido',
      ),
    ];

List<Evento> criarEventosMock() => [
      Evento(
        id: 'e1',
        titulo: 'Feira orgânica do bairro',
        descricao:
            'Produtores locais vendendo frutas, verduras e pães artesanais. Traga sua sacola retornável!',
        local: 'Praça Dom Pedro',
        data: 'Sáb, 14 nov',
        hora: '08:00',
        icone: Icons.local_grocery_store,
        cor: const Color(0xFF2F9E6B),
        x: 0.25,
        y: -0.5,
        confirmados: 48,
      ),
      Evento(
        id: 'e2',
        titulo: 'Mutirão de limpeza do córrego',
        descricao:
            'Vamos juntos limpar as margens do córrego. A prefeitura empresta luvas e sacos. Venha de tênis!',
        local: 'Av. do Córrego, 800',
        data: 'Dom, 15 nov',
        hora: '09:30',
        icone: Icons.cleaning_services,
        cor: const Color(0xFF1C7ED6),
        x: 0.7,
        y: 0.1,
        confirmados: 31,
      ),
      Evento(
        id: 'e3',
        titulo: 'Cinema na praça',
        descricao:
            'Sessão ao ar livre, gratuita e para toda a família. Leve cadeira ou esteira.',
        local: 'Praça das Flores',
        data: 'Sex, 20 nov',
        hora: '19:30',
        icone: Icons.movie_outlined,
        cor: const Color(0xFF7048E8),
        x: -0.4,
        y: -0.7,
        confirmados: 73,
      ),
      Evento(
        id: 'e4',
        titulo: 'Reunião de moradores',
        descricao:
            'Encontro aberto para discutir segurança e iluminação do bairro com representantes da subprefeitura.',
        local: 'Salão da Igreja São José',
        data: 'Qua, 18 nov',
        hora: '20:00',
        icone: Icons.groups,
        cor: const Color(0xFFE8590C),
        x: -0.1,
        y: 0.25,
        confirmados: 22,
      ),
    ];
