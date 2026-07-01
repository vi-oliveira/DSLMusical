# DSL rEaLeJo

## Descrição Resumida da DSL

Esta é uma DSL inspirada em caixas de música, como um realejo. O realejo é um antigo instrumento musical que toca uma música predefinita em uma fita perfurada, onde os furos representam as notas. O objetivo da linguagem é poder criar músicas a partir de uma linguagem de programação, utilizando comandos ao invés de furos em uma fita.

Esta linguagem pode ajudar a criar algum tipo de ritmo rapidamente, sem a necessidade de abrir editores de áudio pesados.

A linguagem também permite que mais de uma pessoa colabore na criação de uma música de forma organizada, com auxílio de ferramentas como o git, por exemplo. Além disso, para ambientes como jogos, uma DSL como esta é capaz de gerar músicas de modo dinâmico, o que ajuda na imersão dos jogos.

## Slides

> Coloque aqui o link para o PDF da apresentação final.

## Sintaxe da Linguagem e Macros Scheme

O **rEaLeJo** foi implementado como uma **DSL Interna** (Internal DSL) hospedada na linguagem Guile Scheme. Em vez de usar um compilador externo com Lexer e Parser tradicionais, a sintaxe da linguagem é definida diretamente através do poderoso sistema de macros higiênicas do Scheme (`syntax-rules`).

A estrutura se inicia definindo o escopo musical através da macro `(music bpm ...)`. Dentro deste bloco, podemos encapsular arranjos nomeados usando a macro `(sample nome ...)`. Para definir o som, chamamos a função `som`, que requer três parâmetros no formato de listas encadeadas (Lisp):
```scheme
(som 'C4 0.5 0.8)
```

Uma descrição dos parâmetros do comando `som`:
- `nota`: Símbolo literal precedido por apóstrofo. Ex: `'A4`, `'Eb3`.
- `duracao`: Número real (em segundos ou fração de compasso, geralmente calculado por `bpm->dur`) indicando quanto tempo a nota soa.
- `volume`: Número real indicando a intensidade do som (0.0 a 1.0).

Para manipulação temporal, as macros capturam os blocos de código subsequentes e aplicam funções recursivas de deslocamento nas listas geradas:
- A macro `(atraso valor corpo...)` permite deslocar temporalmente todas as notas presentes no seu `corpo`.
- A macro `(repetir vezes atraso-val corpo...)` invoca chamadas recursivas clonando os blocos com o atraso temporal progressivo.

A execução é consolidada através da macro `(play nome bpm nota->freq)`, que automaticamente chama a função subjacente de compilação `(processar ...)`. Esta função achata a lista de todos os eventos musicais (que até então estariam em paralelo), unificando as intersecções temporais em uma única cronologia de acordes. Em seguida, aciona o motor de áudio para sintetizar as ondas no arquivo `saida.wav`.

**Exemplo de Sintaxe na Prática:**

```scheme
(add-to-load-path ".")
(use-modules (srfi srfi-1) (dsl) (audio) (notas))

(let ((dur (bpm->dur 120 4)))
  (music 120
    (sample sequencia1
      (som 'C4 dur 0.8)
      (som 'A1 (/ dur 2) 0.8)

      (atraso dur
        (som 'G4 (/ dur 4) 0.8)
        (som 'B1 (/ dur 2) 0.8)
        (repetir 3 (/ dur 4)
          (som 'A5 (/ dur 4) 0.8)))

      (atraso (* 2 dur)
        (som 'F4 (/ dur 4) 0.8)
        (som 'A1 (/ dur 2) 0.8)))

    (play sequencia1 40 nota->freq)))
```

Como não há um compilador léxico ou parser externo, o projeto elimina inteiramente a necessidade de um Lexer (Tokenizador) ou geradores como o ANTLR. A "gramática" segue as regras estritas e limpas das *S-expressions* baseadas em parênteses de Lisp.

## Notebook

[notebook](macros-abstraction.ipynb)

## Exemplos Selecionados

Durante o desenvolvimento, criamos e validamos diferentes exemplos musicais que demonstram a flexibilidade do rEaLeJo. Eles encontram-se na pasta `songs/`. Para executá-los via terminal e escutar o áudio gerado, basta rodar os scripts utilizando o Guile:

- **Bach (Prelúdio 1 em Dó Maior - BWV 846)** (`songs/bach.scm`):
  Neste exemplo, testamos o conceito de arpejos e a manipulação paralela de vozes. O script recebe uma lista de acordes e, usando a função `atraso`, distribui as 5 notas de cada acorde sequencialmente no tempo, simulando perfeitamente a partitura clássica do prelúdio de Bach.
  *Execução*: `guile -L . songs/bach.scm` (gera o arquivo `saida.wav`)

- **Sade - Like a Tattoo** (`songs/likeatattoo.scm`):
  Um exemplo da transcrição da melodia pop icônica ("Hungry for life, and thirsty for the distant river"). O código foi útil para validar a estruturação de ritmos sincopados e a sintaxe de durações baseadas no compasso e BPM, variando o tamanho e atrasos de forma não estrita.
  *Execução*: `guile -L . songs/likeatattoo.scm`

- **Cai Cai Balão (Estilo Realejo)** (`songs/caicai-realejo.scm`):
  Aqui colocamos o modelo principal à prova. Desenvolvemos uma batida acelerada acompanhada por acordes base (`oom-pah`), simulando um típico órgão de rua. A função `processar` teve que lidar com um volume elevado de notas assíncronas acontecendo e se cruzando, fundindo com sucesso a melodia veloz à repetição de acordes em Dó e Sol Maior.
  *Execução*: `guile -L . songs/caicai-realejo.scm`

## Discussão

A linguagem rEaLeJo teve sucesso no seu principal objetivo: abstrair o uso de ferramentas pesadas de áudio permitindo o sequenciamento musical lógico, puramente guiado por código. O uso do mecanismo declarativo com os comandos de `atraso` formam uma interface flexível para os desenvolvedores, reduzindo drasticamente a quantidade de trabalho que seria necessário em linguagens de baixo nível.

Um desafio enfrentado ao trabalhar apenas com código, em relação às ferramentas DAWs baseadas em visuais de *Piano Roll*, é a depuração no tempo. Quando as melodias ficam muito complexas e longas (como na transcrição de ritmos assíncronos), se torna exaustivo gerenciar manualmente o acúmulo das contagens temporais. Mesmo assim, o núcleo do sistema (focado em matemática de senóides e unificação por acordes) se mostrou incrivelmente eficiente, evitando sobrecargas de buffer e tratando as mixagens sem distorção abrupta por conta da normatização aplicada.

## Conclusão

O projeto concluiu a fundação de um motor de áudio versátil integrado com a robustez e higiene de macros do Scheme. As principais conclusões e aprendizados englobam:
- A abordagem funcional para compilar música no tempo revelou-se muito adequada, especialmente pela ausência da necessidade de se preocupar com estados globais; os eventos sonoros dependem apenas das marcações temporais relativas passadas para a lista.
- O maior desafio enfrentado pelo sistema e motor de ondas foi garantir a naturalidade das notas sem os estalos típicos de ondas cruas. O desenvolvimento de "envelopes lineares" amenizando as bordas das amplitudes para que iniciassem e terminassem de forma suave, em conjunto à normalização para não ultrapassar limites (*clipping*), demonstram pontos importantes sobre a fragilidade de manipular áudio puro.
- O projeto conseguiu alcançar e superar expectativas da criação de melodias, com potencial imenso para gerar trilhas incidentais ou procedural.

# Trabalhos Futuros

Pensando no futuro e no tempo estendido para o projeto, as principais melhorias planejadas seriam:
1. **Suporte Multi-Timbral:** O motor atual gera unicamente ondas senoidais puras (tom de apito/flauta). Adicionar novas funções geradoras de onda (quadrada, dente-de-serra, triângulo, ruído branco) permitiria construir sons ricos que imitam percussões, baixos sintéticos e pianos.
2. **Exportação e Leitura MIDI:** Desenvolver um *parser* para exportar ou importar dados MIDI expandiria muito as barreiras da linguagem para integrar aos VSTs industriais.
3. **Envelopes ADSR (Attack, Decay, Sustain, Release):** Aperfeiçoar como o som se sustenta e some, para emular instrumentos friccionados ou percutidos de forma mais realista.

# Referências Bibliográficas

[Instrumento Realejo](https://pt.wikipedia.org/wiki/Realejo)

[Linguagem Strudel](https://strudel.cc/)

[Informações sobre notas musicais](https://musica.ufma.br/bordini/ext/unidades/unidade_01a.html)

[Software de criação de músicas FL Studio](https://www.image-line.com/learn)

[Uma versão incrível de Bohemian Rhapsody, do Queen, no realejo](https://www.youtube.com/watch?v=JTnGI6Knw5Q)
