# 🚢 Batalha Naval

Um jogo clássico de estratégia, onde o jogador enfrenta o computador tentando localizar e afundar suas embarcações escondidas em um tabuleiro 20x20.

## 📖 Descrição
O computador gera aleatoriamente a posição das embarcações em um tabuleiro 20x20, utilizando a função `INT 1AH` para capturar a hora do sistema e definir a matriz inicial.  

As embarcações disponíveis são:
- 1 encouraçado (4 posições em linha)
- 1 fragata (3 posições em linha)
- 2 submarinos (2 posições em linha)
- 2 hidroaviões (3 posições em coluna + 1 posição lateral)

O jogador deve informar coordenadas (Y de 0–19 e X de 0–19) para disparar.  
- **Acerto:** aparece `1` na matriz e mensagem de sucesso.  
- **Erro:** aparece `0` na matriz e mensagem de erro.  
- O jogo termina quando todas as embarcações forem destruídas ou se o jogador digitar **Backspace** para encerrar.  

## 🎮 Objetivo
Afundar todas as embarcações do computador antes que o tabuleiro seja totalmente revelado.

## 🛠️ Tecnologias Utilizadas
- Linguagem Assembly x86 (uso de interrupções do sistema `INT 1AH`)  
- Lógica de programação para jogos de tabuleiro  
- Máscara de matriz para ocultar posições dos barcos  

## ▶️ Como Executar
1. Clone este repositório:
   ```bash
   git clone https://github.com/seuusuario/batalha-naval.git
   cd batalha-naval

   📊 Status do Projeto

✔️ Concluído (versão acadêmica para disciplina de programação)
