# DSL rEaLeJo

## Descrição Resumida da DSL

Esta é uma DSL inspirada em caixas de música, como um realejo. O realejo é um antigo instrumento musical que toca uma música predefinita em uma fita perfurada, onde os furos representam as notas. O objetivo da linguagem é poder criar músicas a partir de uma linguagem de programação, utilizando comandos ao invés de furos em uma fita.

Esta linguagem pode ajudar a criar algum tipo de ritmo rapidamente, sem a necessidade de abrir editores de áudio pesados.

A linguagem também permite que mais de uma pessoa colabore na criação de uma música de forma organizada, com auxílio de ferramentas como o git, por exemplo. Além disso, para ambientes como jogos, uma DSL como esta é capaz de gerar músicas de modo dinâmico, o que ajuda na imersão dos jogos.

## Slides

> Coloque aqui o link para o PDF da apresentação final.

## Sintaxe da Linguagem

A estrutura se inicia com a definição do ambiente musical, como o comando music(120) definir o BPM da música. Depois, se deve encapsular sequências de notas utilizando a estrutura sample, como em sample sequencia1(0.2) presente no código abaixo. Dentro desses blocos, é utilizado o comando som, que recebe três parâmetros: a nota musical desejada, a sua duração no tempo e o seu volume, da seguinte forma:
```som(C4, 0.5, 0.8)```.

Uma descrição mais precisa dos parâmetros é:
- `nota`: Escrita diretamente no código (sem aspas). Formada por uma letra de A a G.

- `duracao`: Um número decimal indicando o tempo de duração da nota relativo ao BPM. Ex: 0.5, 1.0.

- `volume`: Um número decimal indicando a intensidade do som. Ex: 0.8, 1.0.

Para manipular a disposição das notas no tempo e criar arranjos paralelos ou sequenciais, a linguagem fornece alguns comandos. O comando atraso(0.5) desloca o tempo de início das notas que o sucedem no bloco, permitindo espaçamento entre os sons. Já a função repetir(vezes, intervalo) atua como um laço de repetição, clonando um bloco de notas uma determinada quantidade de vezes com um atraso de tempo especificado entre cada repetição.

Antes da execução, o compilador da linguagem traduz toda essa sintaxe para listas contendo o início, o fim, a nota e o volume de cada som gerado. Por fim, para a execução, a linguagem utiliza o comando processar(sequencial) para calcular e mesclar as sobreposições de tempo (transformando o comportamento paralelo em um arranjo sequencial unificado) e o comando play sequencia1(4) para, de fato, reproduzir a sequência musical construída.

```
music(120)
sample sequencia1(0.2)
    som (C4, 0.5, 0.8)
    som (A1, 0.2, 0.8)

    atraso (0.5)
        som (G4, 0.1, 0.8)
        som (B1, 0.2, 0.8)
        repetir (3, 0.1)
            som (A5, 0.1, 0.8)

    atraso (0.8)
        som (F4, 0.1, 0.8)
        som (A1, 0.2, 0.8)

processar(sequencia1)
play sequencia1(4)
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

MUSIC : 'music';
SAMPLE: 'sample';
FLOAT : [0-9]+'.'[0-9]+ ;
INT : [0-9]+ ;
REPEAT : 'repetir';
WAIT : 'atraso';
SOM : 'som';
NOTA : [A-G][0-9]? ;
PROCESSAR : 'processar';
PLAY : 'play';

IDENT: [a-zA-Z_][a-zA-Z_0-9]* ;
WS: [ \t\n\r\f]+ -> skip ;
```

### Parser

```
parser grammar RealejoParser;

options { tokenVocab = RealejoLexer; }

program     : mainBlock EOF ;

mainBlock   : MUSIC LPAREN INT RPAREN LCBRACES body RCBRACES ;

body        : sampleDecl* processStmt? playStmt* ;

sampleDecl  : SAMPLE IDENT LPAREN FLOAT RPAREN LCBRACES stmt* RCBRACES ;

stmt        : repeatStmt | somStmt | waitStmt ;

repeatStmt  : REPEAT LPAREN INT COMMA FLOAT RPAREN LCBRACES stmt* RCBRACES ;

waitStmt    : WAIT LPAREN FLOAT RPAREN LCBRACES stmt* RCBRACES ;

somStmt     : SOM LPAREN NOTA COMMA FLOAT COMMA FLOAT RPAREN SEMICOLON ;

processStmt : PROCESSAR LPAREN IDENT RPAREN SEMICOLON ;

playStmt    : PLAY IDENT LPAREN INT RPAREN SEMICOLON ;
```

## Notebook

> Coloque aqui o link para o notebook que implementa a linguagem e links ou indicações para pastas contendo qualquer outro tipo de código.
>
> Exemplo: [notebook](macros-abstraction.ipynb)

## Exemplos Selecionados

> Coloque um conjunto de exemplos selecionados e os resultados alcançados.
>
> O ideal é que os exemplos sejam apresentados e possam ser executados diretamente no notebook. Se for usar outro mecanismo (diferente do notebook), indique como podemos rodar os exemplos.

## Discussão

> Discussão dos resultados. Relacionar os resultados com a proposta inicial apresentada na introdução.
>
> A discussão dos resultados também pode ser feita opcionalmente na seção de Resultados, na medida em que os resultados são apresentados. Aspectos importantes a serem discutidos: Por que seu modelo alcançou (ou não) um bom resultado? É possível tirar conclusões dos resultados? Quais? Há indicações de direções para estudo? São necessários trabalhos mais profundos?

## Conclusão

> Destacar as principais conclusões obtidas no desenvolvimento do projeto.
>
> Destacar os principais desafios enfrentados.
>
> Principais lições aprendidas.

# Trabalhos Futuros

> O que poderia ser melhorado se houvesse mais tempo?
>
> Quais possíveis desdobramentos este projeto pode ter?

# Referências Bibliográficas

[Instrumento Realejo](https://pt.wikipedia.org/wiki/Realejo)

[Linguagem Strudel](https://strudel.cc/)

[Informações sobre notas musicais](https://musica.ufma.br/bordini/ext/unidades/unidade_01a.html)

[Software de criação de músicas FL Studio](https://www.image-line.com/learn)

[Uma versão incrível de Bohemian Rhapsody, do Queen, no realejo](https://www.youtube.com/watch?v=JTnGI6Knw5Q)
