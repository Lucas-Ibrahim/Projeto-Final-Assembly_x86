TITLE PROJETO
.MODEL SMALL
.STACK 100H

PULALINHA MACRO
              PUSH AX       ; ax para a pilha para nao perder o valor
              PUSH DX       ; dx para a pilha para nao perder o valor
              MOV  AH,2     ; imprime um pula linha
              MOV  DL,10    ; move o caracter line-feed para dl
              INT  21H      ; imprime a nova linha
              POP  DX       ; ax sai da pilha
              POP  AX       ; dx sai da pilha
ENDM

.DATA

    MATRIZ DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")
           DB 20 DUP("#")

    
    MSG1   DB "Selecione coordenadas y (0 a 19) ou pressione backspace para sair do jogo: $."
    MSG2   DB "Selecione coordenadas x (0 a 19) ou pressione backspace para sair do jogo: $."
    MSG3   DB "Voce acertou!$."
    MSG4   DB "Voce errou!$."
    MSG5   DB "Fim jogo!$."

    
.CODE
MAIN PROC

                     MOV       AX,@DATA              ; acessa o .data
                     MOV       DS,AX                 ; move para ds
                     XOR       DI,DI                 ; 0 di (contador de barcos)

                     CALL      EMBARCACAO            ; procedimento embarcacao (monta o sorteio e os modelos da matriz)
                     CALL      IMPRIME               ; procedimento que imprime a matriz

    REPETE_JOGO:     
                     CMP       DI,19                 ; compara di com 19 que é a quantidade total de barcos
                     JE        FIM_DE_JOGO           ; se for quer dizer que o jogador ganhou, assim acaba o jogo
                     CALL      TIRO                  ; vai para o procedimento dos tiros
                     CALL      VERIFICACAO           ; vai para o procedimento de verificaca (se acertou ou errou)
                     JMP       REPETE_JOGO

    FIM_DE_JOGO:     
    

                     MOV       AH,4CH                ; finaliza o programa
                     INT       21H

MAIN ENDP
   
EMBARCACAO PROC
    
                     PULALINHA                       ; macro pula linha
                     PULALINHA

                     MOV       AH,0                  ; zera o valor de ah
                     INT       1AH                   ; essa int serve para que o sistema pegue a data e horario e mova os ticks para diferentes registradores
                     MOV       AX,DX                 ; nesse caso ax ficou com horas e dx com minutos e decidimos usar os minutos
                     AND       AX,3                  ; ao dar o and ax,3 ele pega os 2 lsb e com o seu valor seleciona um dos modelos
                     CMP       AX,0                  ; se ax for 0 ira ao prim0eiro
                     JE        PRIMEIRO
                     CMP       AX,1                  ; se ax for 1 ira ao segundo
                     JE        SEGUNDO
                     CMP       AX,2                  ; se ax for 2 ira ao terceiro
                     JE        TERCEIRO
                     CMP       AX,3                  ; se ax for 3 ira ao quarto
                     JE        QUARTO

    PRIMEIRO:        
                     JMP       N0                    ; esse rotulo foi feito por conta que o outro nao suportava a quantidade de bits

    SEGUNDO:                                         ; esse rotulo foi feito por conta que o outro nao suportava a quantidade de bits
                     JMP       N1

    TERCEIRO:                                        ; esse rotulo foi feito por conta que o outro nao suportava a quantidade de bits
                     JMP       N2

    QUARTO:                                          ; esse rotulo foi feito por conta que o outro nao suportava a quantidade de bits
                     JMP       N3

    N0:              
                     XOR       SI,SI                 ; si aponta para a 1a coluna
                     XOR       BX,BX                 ; bx aponta para a 1a linha
                     MOV       CX,4                  ; move 4 para cx pois sao 4 casas o encourado

                     MOV       AL,'@'                ; @ seria os barcos
    ENC1:            

                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     INC       SI                    ; incrementa si pois o encouracado sao 4 casas na mesma linha uma seguida da outra
                     LOOP      ENC1                  ; repete 4 vezes

                     ADD       BX,20                 ; posiciona bx para a linha 20
                     ADD       SI,20                 ; posiciona si para a coluna 20
                     MOV       CX,3                  ; move 3 para o cx pois a fragata sao 3 casas

    FRA1:            
    
                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     INC       SI                    ; incrementa si poisa a fragata sao 3 casas na mesma linha uma seguida da outra
                     LOOP      FRA1                  ; repete 3 vezes
    
                     XOR       SI,SI                 ; zera si
                     ADD       BX,80                 ; bx vai para a 5a linha
                     ADD       SI,18                 ; si a 18a coluna
                     MOV       CX,2                  ; move 2 para cx pois o submarino sao 2 casas na mesma linha uma seguida da outra

    SUB1:            

                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     INC       SI                    ;  o submarino sao 2 casas na mesma linha uma seguida da outra
                     LOOP      SUB1                  ; repete 2 vezes

                     ADD       BX,100                ; bx vai para a 11a linha
                     XOR       SI,SI                 ; si para a 1a coluna
                     MOV       CX,2                  ; move 2 para cx pois o submarino sao 2 casas na mesma linha uma seguida da outra
                     ADD       SI,4                  ; si vai para a 4a coluna

    SUB2:            

                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     INC       SI                    ;  o submarino sao 2 casas na mesma linha
                     LOOP      SUB2                  ; repete 2 vezes

                     ADD       BX,60                 ; bx vai para a 14a linha
                     ADD       SI,4                  ; si para a 8a coluna
                     MOV       CX,3                  ; move 3 para cx pois o hidroaviao sao 3 casas seguidas na mesma coluna e na linha do meio duas seguidas

    HID1:            

                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     ADD       BX,20                 ; bx para a 15a linha
                     LOOP      HID1                  ; repete 3 vezes

                     SUB       BX,40                 ; bx volta 2 linhas
                     INC       SI                    ; bx vai para a proxima coluna
                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si

                     ADD       BX,20                 ; move bx para a proxima coluna
                     SUB       SI,9                  ; move 9 posicoes para tras na linha
                     MOV       CX,3                  ; move 3 para cx pois os hidroaviao tem 3 casas na vertical

    HID2:            

                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si
                     ADD       BX,20                 ; move bx para a proxima coluna
                     LOOP      HID2                  ; repete 3 vezes

                     SUB       BX,40                 ; bx volta 2 colunas
                     INC       SI                    ; si vai para a proxima casa da linha
                     MOV       MATRIZ[BX][SI],AL     ; move @ para a posicao desejada escolhida por bx e si

                     RET                             ; retorna
    
    N1:              
    ; esse é mais um modelo de jogo que segue a mesma logica de todos os outros

                     ADD       SI,6
                     XOR       BX,BX
                     MOV       CX,4

                     MOV       AL,'@'

    ENC2:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      ENC2

                     ADD       BX,20
                     ADD       SI,4
                     MOV       CX,3

    FRA2:            
    
                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      FRA2
    
                     XOR       SI,SI
                     ADD       BX,60
                     MOV       CX,2

    SUB3:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB3

                     ADD       BX,180
                     XOR       SI,SI
                     MOV       CX,2
                     ADD       SI,6

    SUB4:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB4

                     ADD       BX,60
                     ADD       SI,4
                     MOV       CX,3

    HID3:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID3

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL

                     SUB       SI,9
                     MOV       CX,3

    HID4:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID4

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL

                     RET

    N2:              
    ; esse é outro modelo que segue a mesma logica de todos
                   
                     XOR       BX,BX
                     ADD       SI,3
                     ADD       BX,240
                     MOV       CX,4

                     MOV       AL,'@'
    ENC3:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      ENC3

                     ADD       BX,20
                     ADD       SI,4
                     MOV       CX,3

    FRA3:            
    
                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      FRA3
    
                     XOR       SI,SI
                     XOR       BX,BX
                     MOV       CX,2

    SUB5:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB5

                     ADD       BX,40
                     ADD       SI,13
                     MOV       CX,2

    SUB6:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB6

                     ADD       BX,60
                     ADD       SI,4
                     MOV       CX,3

    HID5:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID5

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL

                     SUB       SI,9
                     MOV       CX,3


    HID6:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID6

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL


                     RET

   
    N3:              
    ; esse é outro modelo que segue a mesma logica de todos

                     XOR       BX,BX
                     ADD       SI,6
                     ADD       BX,260
                     MOV       CX,4

                     MOV       AL,'@'
    
    ENC4:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      ENC4

                     ADD       BX,60
                     ADD       SI,4
                     MOV       CX,3

    FRA4:            
    
                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      FRA4
    
                     ADD       SI,18
                     XOR       BX,BX
                     MOV       CX,2

    SUB7:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB7

                     ADD       BX,40
                     ADD       SI,13
                     MOV       CX,2

    SUB8:            

                     MOV       MATRIZ[BX][SI],AL
                     INC       SI
                     LOOP      SUB8

                     ADD       BX,60
                     ADD       SI,4
                     MOV       CX,3

    HID7:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID7

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL

                     SUB       SI,9
                     MOV       CX,3

    HID8:            

                     MOV       MATRIZ[BX][SI],AL
                     ADD       BX,20
                     LOOP      HID8

                     SUB       BX,40
                     INC       SI
                     MOV       MATRIZ[BX][SI],AL

                     RET

EMBARCACAO ENDP

IMPRIME PROC
                     PULALINHA                       ; macro pulalinha
                     PULALINHA                       ; macro pulalinha
                     PUSH      DX                    ; valor de  dx vai para o topo da pilha
                     XOR       BX,BX                 ; aciona bx
    REP2:            
                     MOV       CX, 30                ; move 30 para cx pois serao dados 30 espacos para centralizar a matriz
                     CALL      IMPRIME_ESPACOS       ; vai para o procedimento imprime_espacos
                    

                     MOV       AH,2                  ; exibe um caracter
                     MOV       CX,20                 ; move 20 para cx
                     XOR       SI,SI                 ; aciona si

    REP1:            
                     MOV       AL, MATRIZ[BX][SI]    ; move @ para a posicao desejada escolhida por bx e si
    
    
                     CMP       AL,'@'                ; compara al com @
                     JE        ESCONDER_BARCO        ; se for igual ele vai para esconder_barco
    
                     CMP       AL,"1"                ; compara al com 1
                     JE        MOSTRA_ACERTO         ; se for igual quer dizer que ele acertou
                     CMP       AL,"0"                ; comapara al com o
                     JE        MOSTRA_ERRO           ; se for igual quer dizer que ele errou

                     MOV       DL,AL                 ; valor de al vai para dl para imprimir
                     INT       21H
                     JMP       PROXIMO_ELEMENTO      ; pula para proximo elemento

    ESCONDER_BARCO:  
                     MOV       DL, '#'               ; aqui é onde substitui os @ por # para que ele nao seja visivel ao jogador mas ainda esteja presente na matriz
                     INT       21H

                     JMP       PROXIMO_ELEMENTO

    MOSTRA_ACERTO:   
                     MOV       DL,"1"                ; move 1 para dl para que imprima na matriz
                     INT       21H
                     JMP       PROXIMO_ELEMENTO

    MOSTRA_ERRO:     
                     MOV       DL,"0"                ; move 0 para dl para que imprima na matriz
                     INT       21H

    PROXIMO_ELEMENTO:
                     INC       SI                    ; incrementa si para ir ao proximo elemento
                     LOOP      REP1                  ; repete 20 vezes
    
                     PULALINHA                       ; macro pulalinha
    
                     ADD       BX,20                 ; bx aponta para a proxima linha
                     CMP       BX,400                ; compara bx com 400 para saber se ja percorreu a matriz inteira
                     JNE       REP2                  ; se nao ele repete o processo
                     POP       DX                    ; retorna o valor de dx
                     RET                             ; retorna para main
IMPRIME ENDP

IMPRIME_ESPACOS PROC
    
                     MOV       AH,2                  ;funcao para exibir
                     MOV       DL,' '                ; move o espaco para que imprima e coloque a matriz no centro da tela
    ESPACOS_LOOP:    
                     INT       21H
                     LOOP      ESPACOS_LOOP          ; repete 30 vezes
                     RET                             ; retorna
IMPRIME_ESPACOS ENDP
    
TIRO PROC

                     PULALINHA                       ; macro pulalinha

                     PUSH      DX                    ; valor de dx vai para o topo da pilha
                     MOV       AH,9                  ; funcao para exibir a string
                     LEA       DX,MSG1               ; seleciona a msg1
                     INT       21H                   ; imprime a msg1
                     POP       DX                    ; valor do topo da pilha volta para dx

                     PULALINHA                       ; macro pulalinha

                     XOR       BX,BX                 ; aciona bx

    Y1:              
                     MOV       AH,1                  ; funcao para que o usuario digite
                     INT       21H
                     CMP       AL,13                 ; compara o que foi digitado com enter
                     JE        SAIDAY                ; se for igual ele sai
                     CMP       AL,8                  ; compara valor digitado com o backspace
                     JE        BACK_SPACE            ; se for igual ele sai
                     AND       AX,000FH              ; valor dos 4 bits menos significativos em ax
                     PUSH      AX                    ; valor de ax vai para o topo da pilha
                     MOV       AX,10                 ; move 10 para ax para fazer uma multiplicacao
                     MUL       BX                    ; multiplica bx por ax
                     POP       BX                    ; valor de ax anterior vai para bx
                     ADD       BX,AX                 ; adiciona ax em bx
                     JMP       Y1                    ; repete o processo

    SAIDAY:          
                     
                     MOV       CX,BX                 ; move o valor de bx para cx
                     PUSH      DX                    ; valor de dx vai para o topo da pilha
                     MOV       AH,9                  ; funcao para exibir string
                     LEA       DX,MSG2               ; seleciona a msg2
                     INT       21H                   ; exibe a msg2
                     POP       DX                    ; valor volta do topo da pilha

                     PULALINHA                       ; macro pulalinha
                     XOR       BX,BX                 ; aciona bx

    X1:              
                     MOV       AH,1                  ; funcao para que o usuario digite
                     INT       21H
                     CMP       AL,13                 ; compara o que foi digitado com enter
                     JE        SAIDAX                ; se for igual ele sai
                     CMP       AL,8                  ; compara o que foi digitado com backspace
                     JE        BACK_SPACE            ; se for igual ele sai
                     AND       AX,000FH              ; valor dos 4 bits menos significativos em ax
                     PUSH      AX                    ; vaor de ax vai para o topo da pilha
                     MOV       AX,10                 ; move 10 para ax
                     MUL       BX                    ; multiplica bx por ax
                     POP       BX                    ; valo do ax anterior vai para bx
                     ADD       BX,AX                 ; adiciona bx em ax
                     JMP       X1                    ; repete o processo

    SAIDAX:          
                     MOV       SI,BX                 ; bx para si
                     MOV       BX,CX                 ; volta o valor de bx
                     MOV       AX,20                 ; move 20 para ax
                     MUL       BX                    ; multiplica bx por ax
                     MOV       BX,AX                 ; move ax para bx


    
                     RET                             ; retorna
    BACK_SPACE:      
                     JMP       FIM_DE_JOGO           ; se o usuario digitar o backspace o jogo termina

TIRO ENDP

VERIFICACAO PROC
    
                     MOV       AH,9                  ; funcao para exibir string
                     MOV       DL,MATRIZ[BX][SI]     ; valor da matriz vai para dl
                     CMP       DL,'@'                ; se for @ quer dizer que acertou
                     JE        ACERTA                ; vai para acerta
                     MOV       MATRIZ[BX][SI],"0"    ; se nao acertou vai mover 0 para dl para que imprima 0 na matriz
                     JMP       SAIDAV                ; sai da verificacao

    ACERTA:          
                     MOV       DH,1                  ; move 1 para dh que é o contador de acertos
                     MOV       MATRIZ[BX][SI],"1"    ; move 1 para cx que é simbolo de acerto que esta sendo usado
                     INC       DI                    ; incrementa di que é o contador de barcos que tem
                     PULALINHA                       ; macro pulalinha

    SAIDAV:          
                     CALL      IMPRIME               ; vai para o procedimento da impressao da matriz
                     CMP       DH,1                  ; compara dh com 1
                     MOV       AH,9
                     JE        IMPRIME_ACERTA        ; se for 1 ele vai para imprimir a msg de acerto
                     PUSH      DX                    ; valor de dx vai para o topo da pilha
                     LEA       DX,MSG4               ; seleciona a msg de erro
                     INT       21H                   ; imprime a msg de erro
                     POP       DX                    ; valor de dx volta do topo da pilha
                     PULALINHA                       ; macro pulalinha
                     JMP       SAIDAV2

    IMPRIME_ACERTA:  
                     PUSH      DX                    ; valor de dx vai ao topo da pilha
                     LEA       DX,MSG3               ; seleciona a msg de acerto
                     INT       21H                   ; imprime a msg de acerto
                     POP       DX                    ; valor de dx volta do topo da pilha
                     PULALINHA                       ; macro pulalinha

    SAIDAV2:         
                     RET                             ; retorna

VERIFICACAO ENDP



END MAIN