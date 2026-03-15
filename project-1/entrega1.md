# DSL `Realengo`

## Descrição Resumida da DSL

> Esta é uma DSL inspirada em caixas de música. O objetivo da linguagem é poder criar músicas a partir de uma linguagem de programação.
>
> Esta linguagem pode ajudar a criar algum tipo de ritmo rapidamente, sem a necessidade de abrir editores de áudio pesados.
> A linguagem também permite que mais de uma pessoa colabore na criação de uma música de forma organizada, com auxílio de ferramentas como o git, por exemplo
> Além disso, para ambientes como jogos, uma DSL como esta é capaz de gerar músicas de modo dinâmico, o que ajuda na imersão dos jogos.

## Slides

> Coloque aqui o link para o PDF da apresentação.

## Sintaxe da Linguagem na Forma de Tutorial

> Apresente um guia de sintaxe da linguagem na forma explicativa.

## Gramática da Linguagem

> Apresente a gramática da linguagem.

## Exemplos Selecionados

main(120){

    sample sequencia1 {

        som ("C4", 0.8, 0.5);

        som ("B1", 1.0, 0.2);

    }

    sample sequencia2 {

        som ("B1", 0.2, 1.0);

        som ("B1", 0.2, 1.0);

    }

    play sequencia1(4);

    play sequencia2(3);

    play sequencia1(2);

}

# Referências Bibliográficas

> Lista de artigos, links e referências bibliográficas.
>
> Fiquem à vontade para escolher o padrão de referenciamento preferido pelo grupo.