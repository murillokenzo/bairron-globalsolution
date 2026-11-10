# BairroOn

> O que está acontecendo na sua rua? App mobile (Flutter/Dart) da Global Solution 2026/2 — CitizenTech.

## Integrantes
- Murillo Kenzo Loureiro Kacinvazaki - RM566948
- Kauan Prado Famelli - RM566990
- Cauã Rocha do Amaral - RM567593
- Gustavo Souza Nascimento - RM567134

## Solução
O BairroOn funciona como um "Waze do bairro": os moradores veem no mapa as ocorrências da vizinhança
(buracos, falta de iluminação, alagamentos, entulho, trânsito e segurança), apoiam os relatos dos
vizinhos para priorizar o que é mais urgente, reportam novos problemas e descobrem eventos que acontecem
perto de casa (feiras, mutirões, reuniões de moradores).

## Cidadão beneficiado
Moradores de bairros urbanos que hoje não têm um canal simples para relatar problemas locais, acompanhar
a resolução e se organizar com a vizinhança.

## ODS relacionados
- **ODS 11 – Cidades e comunidades sustentáveis:** participação cidadã e zeladoria colaborativa.
- **ODS 9 – Indústria, inovação e infraestrutura:** dados da comunidade ajudam a priorizar manutenção de infraestrutura.
- **ODS 13 – Ação contra a mudança global do clima:** alertas e registro de pontos de alagamento.

## Telas
1. Boas-vindas (escolha do bairro)
2. Home com abas: Mapa, Ocorrências e Eventos
3. Detalhe da ocorrência (recebe a ocorrência por parâmetro)
4. Detalhe do evento (recebe o evento por parâmetro)
5. Reportar problema (formulário com validação)
6. Perfil

## Como executar
```bash
flutter pub get
flutter run
```
Os dados são mockados (`lib/mock_data.dart`). Não há dependências externas além do Flutter.

## Declaração de uso de IA generativa
Ferramenta: Claude (Anthropic). Uso: geração da estrutura inicial do app, que foi revisada, testada e
adaptada pelo grupo. 

## Link do video no youtube

- https://youtu.be/qj1Pj3MmXfE