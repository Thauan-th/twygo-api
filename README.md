# Twygo API

Projeto destinado a criação de uma API para um sistema de cursos online.

## Índice
- [Como rodar](#como-rodar)
  - [Desenvolvimento](#desenvolvimento)
  - [make start](#make-start)
  - [make stop](#make-stop)
  - [make server](#make-server)
  - [make bash](#make-bash)
  - [make test](#make-test)
  - [make console](#make-console)
- [Requisitos](#requisitos)
  - [Obrigatórios](#obrigatórios)
  - [Opcionais](#opcionais)
- [Extras](#extras)
  - [Relatórios](#relatorios)
  - [Swagger](#swagger)

## Como rodar

### Desenvolvimento

Essa API conta com dados de desenvolvimento situados em `db/seeds`, então após subir o ambiente seguindo os passos abaixo, você pode rodar os seguintes comandos para popular o banco de dados.

**Exemplo:**

```bash
make console

rails db:seed
```

### `make start`

Inicia os containers em segundo plano utilizando o `docker-compose`. Este comando sobe todos os serviços definidos no `docker-compose.yml`.

**Exemplo:**

```bash
make start
```

### `make stop`

Para todos os containers em execução.

**Exemplo:**

```bash
make stop
```

### `make server`

Inicia o servidor da aplicação.

**Exemplo:**

```bash
make server
```


### `make bash`

Acessa o container da aplicação.

**Exemplo:**

```bash
make bash
```

### `make test`

Rodar os testes da aplicação.

**Exemplo:**

```bash
make test
```

### `make console`

Acessa o console da aplicação.

**Exemplo:**

```bash
make console
```

## Requisitos

### Obrigatórios

| Requisitos | Descrições
| -----------| -----------
| R.1 | A tela inicial deve exibir uma lista de cursos atuais.
| R.2 | Os cursos devem ser exibidos em um layout responsivo que funcione bem em dispositivos móveis.
| R.3 | Cada curso na lista deve incluir o título e a descrição do curso.
| R.4 | Os cursos devem ser filtrados com base na data de término, mostrando apenas cursos cuja data de término ainda não passou em relação à data atual.
| R.5 | Crie um formulário de cadastro de curso que inclua os campos da tabela.
| R.6 | Forneça uma maneira de editar e excluir cursos existentes.
| R.7 | Apresentação tamanho total ocupado pelos vídeos nos cursos.


### Opcionais

#### Abordados

- [x] A construção da aplicação pode ser monolito ou SPA, sendo SPA um diferencial  
- [x] Uso de Typescript  
- [x] Uso de React  
- [x] Uso de testes unitários  
- [x] Uso de Docker  

#### Não Abordados

- [ ] Uso de ChakraUI  


## Extras

### Relatórios

Um relatório de tamanho total ocupado pelos vídeos nos cursos foi adicionado. Para acessar o relatório, acesse a rota `/courses/$SLUG/reports` onde `$SLUG` é o slug do curso.

Um relatório em PDF foi construido com metricas simples porem importantes para o usuário. Gravados no banco de dados para controle de progresso.

[Exemplo de relatório](./report_example.pdf)


### Swagger

A documentação da API foi feita utilizando o Swagger. Para acessar a documentação, acesse a rota `/api-docs`. Todos os controllers e rotas estão documentados/testados.

[Swagger](./swagger-ui.png)
