# Pet Vida API

## Descrição do Projeto

A **Pet Vida API** é uma solução RESTful criada para gerenciar uma clínica veterinária completa, com recursos para tutores, animais, consulta médica, pagamentos e relatórios financeiros. O backend é implementado em **Node.js** utilizando o framework **Express**, enquanto o armazenamento de dados é realizado em **MySQL**.

Esta API suporta operações padrão de CRUD para as principais entidades do sistema e foi projetada para ser escalável e fácil de integrar com frontends ou aplicativos móveis. O projeto também utiliza a **Licença MIT**, garantindo que o código seja livre para uso e contribuição, e conta com um arquivo `.gitignore` para proteger informações sensíveis como `node_modules` e o arquivo `.env`.

## Tecnologias Utilizadas

- **Node.js**
- **Express**
- **MySQL**

## Instruções de Instalação e Execução

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/pet-vida.git
cd pet-vida

# 2. Instale as dependências
npm install

# 3. Crie o arquivo de variáveis de ambiente
copy .env.example .env

# 4. Configure as variáveis no .env
# Exemplo:
# DB_HOST=localhost
# DB_USER=root
# DB_PASSWORD=senha
# DB_NAME=pet_vida
# PORT=3000

# 5. Inicie a aplicação
npm start
```

> O `.gitignore` protege arquivos sensíveis como `node_modules` e o `.env`, mantendo o repositório seguro.

## Tabela de Endpoints da API

| Método | Endpoint | Descrição | Status Code de Sucesso |
| --- | --- | --- | --- |
| GET | `/api/tutores` | Lista todos os tutores | `200` |
| POST | `/api/tutores` | Cria um novo tutor | `201` |
| PUT | `/api/tutores/:id` | Atualiza os dados de um tutor | `200` |
| DELETE | `/api/tutores/:id` | Remove um tutor | `204` |
| GET | `/api/animais` | Lista todos os animais | `200` |
| POST | `/api/animais` | Cadastra um novo animal | `201` |
| GET | `/api/consultas` | Lista consultas agendadas | `200` |
| POST | `/api/consultas` | Agenda uma nova consulta | `201` |

## Estrutura de Pastas

```
Pet_vida/
├── LICENSE
├── .gitignore
├── package.json
├── package-lock.json
├── server.js
├── README.md
├── .env
├── backups/
│   └── petvida_2026-06-16.sql
├── database/
│   └── backup.sh
├── db_pet_vida/
│   ├── schema.sql
│   ├── seed.sql
│   ├── procedure.sql
│   ├── triggers.sql
│   ├── view.sql
│   └── functions.sql
├── docs/
│   └── README.md
└── src/


## Front-end

A interface do usuário está na pasta `Front-end/`.

- Para testar localmente, abra o arquivo `Front-end/index.html` diretamente no navegador.
- Para servir como um site estático (recomendado), use um servidor simples. Exemplos:

```bash
# com http-server
npx http-server Front-end -p 8080

# ou com serve
npx serve Front-end
```

Depois, acesse `http://localhost:8080` (ou a porta escolhida).

Observação: o front-end consome a API em `http://localhost:3000` por padrão. Se a API estiver rodando em outra porta ou host, atualize a URL em `Front-end/script.js`.

    ├── config/
    │   └── database.js
    └── routes/
        ├── app.js
        ├── animais.js
        ├── consultas.js
        ├── especies.js
        ├── pagamentos.js
        ├── relatorios.js
        ├── tutores.js
        └── veterinarios.js
```

## Licença

Este projeto está licenciado sob a **Licença MIT**. 

## Contato

- Juliana Evangelista Simão dos Santos
- LinkedIn: [https://www.linkedin.com/in/juliana-santos-52bb49275]
