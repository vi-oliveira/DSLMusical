# DSL rEaLeJo

## Descrição Resumida da DSL

Esta é uma DSL inspirada em caixas de música, como um realejo. O realejo é um antigo instrumento musical que toca uma música predefinita em uma fita perfurada, onde os furos representam as notas. O objetivo da linguagem é poder criar músicas a partir de uma linguagem de programação, utilizando comandos ao invés de furos em uma fita.

Esta linguagem pode ajudar a criar algum tipo de ritmo rapidamente, sem a necessidade de abrir editores de áudio pesados.

A linguagem também permite que mais de uma pessoa colabore na criação de uma música de forma organizada, com auxílio de ferramentas como o git, por exemplo. Além disso, para ambientes como jogos, uma DSL como esta é capaz de gerar músicas de modo dinâmico, o que ajuda na imersão dos jogos.

## Slides

[https://docs.google.com/presentation/d/1jFzdaqY28vyw9d-001e_1V-5YtPxjPN9Q6TTht-eQa0/edit?usp=sharing](https://docs.google.com/presentation/d/13haP9X17PTaQvag1hF4eJKRT3X6LdRXWDMJfAUm7LNQ/edit?usp=sharing)

## Sintaxe da Linguagem na Forma de Tutorial

Todo código válido deve estar encapsulado dentro de um bloco `main`. No bloco `main` é definida a taxa de BPM da música (Batidas Por Minuto). A `main` é montada seguindo a forma:

```
main(120) {  
    Todo o código vai aqui 
}
```

O trecho acima executa a música desejada a 120 BPM.

Para organizar a música, as notas são agrupadas dentro de blocos chamados `sample`. É necessário dar um nome a esse bloco para poder chamá-lo depois. O `sample` é montado assim: 

```
sample nome_da_sequencia (duracao) { ... }
````

Dentro de um sample, as notas são adicionadas usando o comando `som`. Ele recebe três parâmetros obrigatórios, separados por vírgula, e devem sempre terminar com ponto e vírgula (`;`) da seguinte forma:

```
som(nota, duracao, volume);
```

Uma descrição mais precisa dos parâmetros é:
- `nota`: Escrita diretamente no código (sem aspas). Formada por uma letra de A a G seguida de um número indicando a oitava. Ex: C4, B1.

- `duracao`: Um número decimal indicando o tempo de duração da nota relativo ao BPM. Ex: 0.5, 1.0.

- `volume`: Um número decimal indicando a intensidade do som. Ex: 0.8, 1.0.


Além disso, no sample, podem ser usados os comandos `repetir`, para repetir um determinado bloco, no qual é especificado o número de repetições e o atraso entre as repetições.

```
repetir(vezes, atraso) {...}
```
- `vezes`: Um número inteiro.

- `atraso`: Um número decimal indicando o tempo de atraso entre cada repetição.


E também o comando `atraso`, para atrasar um determinado bloco.
```
atraso(atraso) {...}
```
- `atraso`: Um número decimal indicando o tempo de atraso antes de tocar a nota.


Depois de definidos, para tocar os samples é utilizado o comando `play`, que chama uma sequência pelo nome e define quantas vezes ela deve se repetir em loop. Cada comando `play` também deve terminar com ponto e vírgula (`;`), com a sintaxe:

```
play nome_da_sequencia(repeticoes);
```


## Gramática da Linguagem

### Lexer

```
COMMA : ',' ;
SEMICOLON : ';' ;
LPAREN : '(' ;
RPAREN : ')' ;
LCBRACES : '{' ;
RCBRACES : '}' ;

MAIN : 'main';
SAMPLE: 'sample';
FLOAT : [0-9]+'.'[0-9]+ ;
REPEAT : 'repetir';
WAIT : 'atraso';
SOM : 'som';
NOTA : [A-G][1-9];
PLAY : 'play';

INT : [0-9]+ ;
IDENT: [a-zA-Z_][a-zA-Z_0-9]* ;
WS: [ \t\n\r\f]+ -> skip ;
```


### Parser

```
parser grammar PL0Parser;

options { tokenVocab = PL0Lexer; }

program    : mainBlock EOF ;

mainBlock  : MAIN LPAREN INT RPAREN LCBRACES body RCBRACES ;

body       : sampleDecl* playStmt* ;

sampleDecl : SAMPLE IDENT LPAREN FLOAT RPAREN LCBRACES (repeatStmt | somStmt | waitStmt)* RCBRACES ;

repeatStmt : REPEAT LPAREN INT COMMA FLOAT RPAREN LCBRACES (repeatStmt | somStmt | waitStmt)* RCBRACES ;

waitStmt : WAIT LPAREN FLOAT RPAREN LCBRACES (repeatStmt | somStmt | waitStmt)* RCBRACES ;

somStmt    : SOM LPAREN NOTA COMMA FLOAT COMMA FLOAT RPAREN SEMICOLON ;

playStmt   : PLAY IDENT LPAREN INT RPAREN SEMICOLON ;
```

## Exemplos Selecionados

``` 
main(120) {
	sample sequencia1(0.2) {
		som (C4, 0.5, 0.8);
		som (A1, 0.2, 0.8);
		
		atraso (0.5) {
		
			som (G4, 0.1, 0.8);
			som (B1, 0.2, 0.8);
			
			repetir (3, 0.1) {
				som (A5, 0.1, 0.8);
			}
		}
	}

	play sequencia1(4);
}
 ```

# Referências Bibliográficas
[Instrumento Realejo](https://pt.wikipedia.org/wiki/Realejo)

[Linguagem Strudel](https://strudel.cc/)

[Informações sobre notas musicais](https://musica.ufma.br/bordini/ext/unidades/unidade_01a.html)

[Software de criação de músicas FL Studio](https://www.image-line.com/learn)

[Uma versão incrível de Bohemian Rhapsody, do Queen, no realejo](https://www.youtube.com/watch?v=JTnGI6Knw5Q)
