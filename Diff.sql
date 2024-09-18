-----------------------------------Tabelas---------------------------------------
--Banco 1
USE [Nome_Do_Seu_Banco1]; --Faz a mudança de conexão para o primeiro banco
GO --E então ele deverá:
SELECT --Realizar a busca de:
    t.name AS TableName, --Nome da tabela
    c.name AS ColumnName, --Nome da coluna
    ty.name AS DataType, --Tipo do dado (int, varchar, etc...)
    c.max_length AS MaxLength, -- Tamanho Máximo
    c.precision AS Precision, --Precisão 
    c.scale AS Scale --Escala
  
INTO #TempTablesDB1 --Realiza a inserção dentro de uma tabela temporária (Caso não queira, apenas comente essa linha)
  
FROM --E esses dados foram retirados de:
    sys.tables t --Tabelas do banco como "t"
JOIN 
    sys.columns c ON t.object_id = c.object_id --Colunas do banco como "c" (join)
JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id --Tipo do usuário do banco como "ty"
ORDER BY 
    t.name, c.column_id; --Ordenando pelo nome da tabela e coluna

-- Contar tabelas
SELECT COUNT(DISTINCT t.name) AS TableCount --Essa parte serve para "ignorar" todo o conteúdo acima e apresentar na saída apenas o número exato de tabelas do DB
FROM sys.tables t; --Caso não queria ver a quantia, mas apenas as tabelas e colunas, comente essas duas linhas do COUNT (nesse caso, 24 e 25)

--Banco 2
USE [Nome_Do_Seu_Banco2]; --Basta repetir o mesmo para validar o segundo banco (Esse processo pode ser feito com mais de dois, porém, como o processo apenas se repete, o exemplo será limitado a dois bancos diferentes)
GO
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLength,
    c.precision AS Precision,
    c.scale AS Scale
  
INTO #TempTablesDB2
  
FROM 
    sys.tables t
JOIN 
    sys.columns c ON t.object_id = c.object_id
JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY 
    t.name, c.column_id;

-- Contar tabelas
SELECT COUNT(DISTINCT t.name) AS TableCount
FROM sys.tables t;

----------------------------------------------

--Agora, caso você queira identificar quais são as tabelas "diferença" entre os bancos, veja o trecho abaixo:
--Primeiro Banco
SELECT TableName --Seleção do nome das tabelas
FROM #TempTablesDB1 --Da tabela temporária1 que criamos anteriormente
EXCEPT --Faz a verificação de quais são as exceções de um DB para outro
SELECT TableName --Seleciona o nome das tabelas
FROM #TempTablesDB2; --Da tabela temporária2 que criamos anteriormente.

--Agora, realize o mesmo procedimento para verificar se existem tabelas no banco2 que não estão presentes no banco1:
--Segundo Banco
SELECT TableName
FROM #TempTablesDB2
EXCEPT
SELECT TableName
FROM #TempTablesDB1;

----------------------------------------------

--Não se esqueça de dropar essas tabelas temporárias quando não for mais utilizar ou quiser refazer a consulta:
DROP TABLE #TempTablesDB1;
DROP TABLE #TempTablesDB2;

--E caso a gente queira ver o que tem dentro dessas tabelas, utilizamos o seguinte trecho:
SELECT * FROM Nome_Da_Tabela; --Seleciona tudo da table
EXEC sp_spaceused Nome_Da_Tabela; --Apresenta os valores do name, rows, reserved, data, index_size e unused da tabela em questão.

-----------------------------------VIEWS---------------------------------------
--A mesma lógica se aplica as views, por exemplo:
-- Contar views no banco 1
USE [Nome_Do_Seu_Banco1];
GO
SELECT 
    v.name AS ViewName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLength,
    c.precision AS Precision,
    c.scale AS Scale
    
INTO #TempViewsDB1
    
FROM 
    sys.views v
JOIN 
    sys.columns c ON v.object_id = c.object_id
JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY 
    v.name, c.column_id;

-- Contar views
SELECT COUNT(DISTINCT v.name) AS ViewCount
FROM sys.views v;

-- Contar views no banco 2
USE [Nome_Do_Seu_Banco2];
GO
SELECT 
    v.name AS ViewName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLength,
    c.precision AS Precision,
    c.scale AS Scale
    
INTO #TempViewsDB2
    
FROM 
    sys.views v
JOIN 
    sys.columns c ON v.object_id = c.object_id
JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY 
    v.name, c.column_id;

-- Contar views
SELECT COUNT(DISTINCT v.name) AS ViewCount
FROM sys.views v;

----------------------------------------------

-- Encontrar views presentes apenas no primeiro banco de dados
SELECT ViewName
FROM #TempViewsDB1
EXCEPT
SELECT ViewName
FROM #TempViewsDB2;

-- Encontrar views presentes apenas no segundo banco de dados
SELECT ViewName
FROM #TempViewsDB2
EXCEPT
SELECT ViewName
FROM #TempViewsDB1;

----------------------------------------------

--- Drop tables Temp
DROP TABLE #TempViewsDB1;
DROP TABLE #TempViewsDB2;
