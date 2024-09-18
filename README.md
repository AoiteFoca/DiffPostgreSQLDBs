# DiffPostgreSQLDBs

## Motivo da criação
É muito comum acabar em uma situação em que você precisa fazer uma migração de bancos ou simplesmente um upgrade em seu desempenho e, infelizmente, o solicitante não possui todas as informações necessárias, sendo a principal, qual dos bancos em questão deverá ser o principal? Qual a diferença entre os outros? Qual a diferença de tamanho entre eles? 
E foi pensando assim que decidi fazer esse simples *script* para SSMS (Sql Server Management Studio) voltado à essa finalidade. 

## Para que serve?
O *script* analisa as tabelas de um banco, cria uma *table* temporaria e armazena as informações nessa tabela. Após isso, será feito um COUNT para identificar diretamente quantas tabelas estão disponíveis no banco. Além disso, é possível comentar as linhas do COUNT para que a saída apresente as tabelas em si, ao invés da soma de todas como COUNT. Fora as tabelas, o *script* contará com a mesma funcionalidade para Views e Índices, porém, caso queira aplicar de outra maneira, basta substituir no *script* (os comentários explicam o que as linhas estão fazendo). Também serve para visualizar as tabelas de "diferença" entre os bancos e, posteriormente, visualizar seu conteúdo. O *script* também conta com uma verificação rápida de tamanho do banco (saída em MB).

## Como utilizar?
Para utilizar este *script* basta possuir um ambiente [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) e baixar ou copiar o código presente no arquivo [Diff.sql](https://github.com/AoiteFoca/DiffSQLServerDBs/blob/main/Diff.sql).

**IMPORTANTE** Lembre-se de substituir *Nome_Do_Seu_Banco1* e *Nome_Do_Seu_Banco2* pelo valor real do seu banco! E lembre-se também de apagar as tabelas temporárias caso queira utilizá-las novamente (ou apenas renomeie-as).

<div align="center">
<h3 align="center">Autor</h3>
<table>
  <tr>
    <td align="center"><a href="https://github.com/AoiteFoca"><img loading="lazy" src="https://avatars.githubusercontent.com/u/141975272?v=4" width="115"><br><sub>Nathan Cielusinski</sub></a></td>
  </tr>
</table>
