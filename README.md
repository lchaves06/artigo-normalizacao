# Da Planilha ao Modelo Relacional: 1FN, 2FN, 3FN, BCNF, 4FN e 5FN

Este repositório contém o artigo técnico e os scripts SQL desenvolvidos para a disciplina de Modelagem de Banco de Dados, sob orientação da Profª Andréa Ono Sakai (Braz Cubas).

- **URL da Página Publicada:** [Inserir o link do GitHub Pages aqui]
- **SGBD Utilizado:** PostgreSQL 16

## Integrantes do Grupo
- **Marcelo Ludin** ([GitHub](https://github.com/MarceloLudin) | [LinkedIn](https://www.linkedin.com/in/marcelo-ludin-050a9a340))
- **Carina Tutihashi** ([GitHub](https://github.com/carinatut14-wq) | [LinkedIn](https://www.linkedin.com/in/carina-tutihashi-96b3a33a4))
- **Rafael Azevedo** ([GitHub](https://github.com/Rafael1708) | [LinkedIn](https://www.linkedin.com/in/rafael-azevedo-7856302a3))
- **Ana Clara Macedo** ([GitHub](https://github.com/AnaClaraMaced) | [LinkedIn](https://www.linkedin.com/in/ana-clara-macedo-4b327337b))
- **Murilo dos Santos** ([GitHub](https://github.com/MuriloSantos111) | [LinkedIn](https://www.linkedin.com/in/murilo-dos-santos-80a3b7424))
- **Lucas Rodrigues** ([GitHub](https://github.com/lchaves06))
- **Pablo Gonçalves** ([GitHub](https://github.com/PabloFDSNTS))

## Estrutura de Arquivos
- `/` — Código-fonte da página web (`index.html`, `style.css`).
- `/sql` — Scripts de banco de dados em PostgreSQL 16:
  - `01_cafe_plano.sql`: Tabela plana inicial da Casa do Café e teste de anomalia.
  - `02_cafe_3fn.sql`: Esquema normalizado até a 3FN e rotina de migração.
  - `03_bcnf.sql`: Cenário da Escola de Idiomas com trigger de validação.
  - `04_4fn.sql`: Caso prático de dependências multivaloradas (Cursos, Livros e Docentes).
  - `05_5fn.sql`: Exemplo de dependências de junção (Representantes, Empresas e Produtos).

## Instruções de Execução dos Scripts
1. Instale e inicie uma instância do **PostgreSQL 16**.
2. Crie uma nova base de dados limpa:
   ```sql
   CREATE DATABASE db_normalizacao;
3. Execute os arquivos da pasta `/sql` em ordem numérica. 
   - Nota: Os scripts `01` e `02` devem ser executados na mesma base.
   - Nota 2: No script `03_bcnf.sql`, a última instrução de `INSERT` foi comentada pois foi desenhada para falhar de propósito, demonstrando o bloqueio da trigger de validação.
