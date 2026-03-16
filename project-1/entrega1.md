# DSL rEaLeJo

## Descrição Resumida da DSL

> Esta é uma DSL inspirada em caixas de música, como um realejo. O realejo é um antigo instrumento musical que toca uma música predefinita em uma fita perfurada, onde os furos representam as notas. O objetivo da linguagem é poder criar músicas a partir de uma linguagem de programação, utilizando comandos ao invés de furos em uma fita.
>
> Esta linguagem pode ajudar a criar algum tipo de ritmo rapidamente, sem a necessidade de abrir editores de áudio pesados.
> A linguagem também permite que mais de uma pessoa colabore na criação de uma música de forma organizada, com auxílio de ferramentas como o git, por exemplo
> Além disso, para ambientes como jogos, uma DSL como esta é capaz de gerar músicas de modo dinâmico, o que ajuda na imersão dos jogos.

## Slides

> Coloque aqui o link para o PDF da apresentação.

## Sintaxe da Linguagem na Forma de Tutorial

> O Todo código válido deve estar encapsulado dentro de um bloco main. No bloco main é definido o BPM da música (Batidas Por Minuto).
> A main é montada seguindo a forma: main(120) {  Todo o código vai aqui }
>
> Para organizar a música, as notas são agrupadas dentro de blocos chamados sample. É necessário dar um nome a esse bloco para poder chamá-lo depois.
> O sample é montado assim: sample nome_da_sequencia { ... }
>
> Dentro de um sample, as notas são adicionadas usando o comando som. Ele recebe três parâmetros obrigatórios, separados por vírgula, e devem sempre terminar com ponto e vírgula (;). Da seguinte forma: 
> som(Nota, Duração, Volume);
> Uma descrição mais precisa dos parâmetros é:
> **Nota:** Escrita diretamente no código (sem aspas). Formada por uma letra de A a G seguida de um número indicando a oitava. Ex: C4, B1.
> **Duração:** Um número decimal indicando o tempo de duração da nota relativo ao BPM. Ex: 0.5, 1.0.
> **Volume:** Um número decimal indicando a intensidade do som. Ex: 0.8, 1.0.
>
> Depois de definitos, para tocar os sambples,é utilizado o comando play, que chama uma sequência pelo nome e define quantas vezes ela deve se repetir em loop. Cada comando play também deve terminar com ponto e vírgula (;). Com a sintaxe> play nome_da_sequencia(Repeticoes);


## Gramática da Linguagem

> parser grammar PL0Parser;
> 
> options { tokenVocab = PL0Lexer; }
> 
> program    : mainBlock EOF ;
> 
> mainBlock  : MAIN LPAREN INT RPAREN LCBRACES body RCBRACES ;
> 
> body       : sampleDecl* playStmt* ;
> 
> sampleDecl : SAMPLE IDENT LCBRACES somStmt* RCBRACES ;
> 
> somStmt    : SOM LPAREN NOTA COMMA FLOAT COMMA FLOAT RPAREN SEMICOLON ;
> 
> playStmt   : PLAY IDENT LPAREN INT RPAREN SEMICOLON ;

## Exemplos Selecionados

``` 
main(120){
     sample sequencia1 {
         som (C4, 0.8, 0.5);
         som (B1, 1.0, 0.2);
     }
 
     sample sequencia2 {
         som (B1, 0.2, 1.0);
         som (B1, 0.2, 1.0);
     }
 
     play sequencia1(4);
     play sequencia2(3);
     play sequencia1(2);
 }
 ```

# Referências Bibliográficas
[Instrumento Realejo](https://pt.wikipedia.org/wiki/Realejo)
[Linguagem Strudel](https://strudel.cc/)
[Informações sobre notas musicais](https://musica.ufma.br/bordini/ext/unidades/unidade_01a.html)
[Software de criação de músicas FL Studio](https://www.image-line.com/learn)