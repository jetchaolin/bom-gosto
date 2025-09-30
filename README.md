# Projeto SQL

<div align="left">
  <img src="https://img.shields.io/badge/Status-Concluido-verde" alt="Status">
  <img src="https://img.shields.io/badge/Postgres-v17.5-yellow" alt="Java">
</div>

## **Curso Mais Prati - Exercício 08 - Modelando, Construindo e Pesquisando**

## **Pré-requisitos**

- [`Postgres`](#modo-de-instalação)

### Exercício

A cafeteria BomGosto deseja controlar as suas vendas de café. A BomGosto controla suas vendas a partir de uma comanda. Uma comanda tem um código único, data, o número da mesa do cliente e o nome do cliente registrados. Nos itens da comanda é possível relacionar vários cafés listados no cardápio que foram vendidos. Cada item da comanda possui o código do cardápio e a quantidade requisitada deste e, não é possível inserir o mesmo código de cardápio mais de uma vez na mesma comanda. No cardápio é apresentado o nome único do café, a descrição da sua composição e o preço unitário.

Desenvolva os scripts SQL para atender cada uma das questões abaixo:

1) Faça uma listagem do cardápio ordenada por nome;

2) Apresente todas as comandas (código, data, mesa e nome do cliente) e os itens da comanda (código comanda, nome do café, descricão, quantidade, preço unitário e preço total do café) destas ordenados data e código da comanda e, também o nome do café;

3) Liste todas as comandas (código, data, mesa e nome do cliente) mais uma coluna com o valor total da comanda. Ordene por data esta listagem;

4) Faça a mesma listagem das comandas da questão anterior (6), mas traga apenas as comandas que possuem mais do que um tipo de café na comanda;

5) Qual o total de faturamento por data? ordene por data esta consulta.

## **MODO DE INSTALAÇÃO**

### Instale o `Postgres` na sua máquina.

Você pode baixar o `Postgres` no [link](https://www.postgresql.org/download/) e instalar na sua máquina.

### **Baixe o repositório com os exercícios**

```sh
# Clona o repositório para sua máquina

git clone https://github.com/jetchaolin/bom-gosto.git # Https

git clone git@github.com:jetchaolin/bom-gosto.git # Ssh

# Navegue até a pasta do exercício
cd bom-gosto/
```

## Criando o Database e rodando o script SQL no Postgres

```sh
psql -U postgres # Logue no banco

CREATE DATABASE bom_gosto; # Crie o database
```

Você pode rodar o script SQL diretamente no PgAdmin ou pode rodar o script SQL no seu terminal para popular o banco.

```sh
psql -U postgres -d bom_gosto -f ./bom-gosto/bom_gosto.sql
```

## Querys

Agora que o banco foi populado, você contrará as querys no arquivo `querys.sql` dentro da pasta `bom-gosto`.

```sh
ls bom-gosto
# bom_gosto.sql  querys.sql  README.md
```
