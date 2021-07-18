# 🕹 Navigator 🕹

Esse projeto foi desenvolvido seguindo as especificações do teste de [back-end da Credere](https://github.com/meucredere/backend).

O objetivo é criar um sistema onde é possível controlar uma sonda exploradora da NASA que pousou em Marte, sendo que o pouso aconteceu em uma área retangular e a posição da sonda é representado pelo seu eixo X e Y.

### Desenvolvimento

Para executar em ambiente de desenvolvimento é necessário ter um banco Postgres executando, é possível criar um através do docker com o comando:

```
docker-compose up -d
```

Com isso o banco de dados será criado com as configurações esperadas pela aplicação.

Após o banco de dados estar disponível podemos iniciar a aplicação com os comandos:

```
mix setup
mix phx.server
```

Através do comando `mix setup` será instalado as dependerias necessárias e a execução das migrações, e com o comando `mix phx.server` iniciamos a aplicação, permitindo realizar requisições para `http://localhost:4000/api`.

Por padrão a configuração da área em que a sonda pode se movimentar é de `5x5`, mas é possível alterar essas dimensões no arquivo de configuração `config/config.exs` na opção de `:max_dimensions`.

### Deploy

Atualmente a aplicação encontrasse disponível em `https://navigator.gigalixirapp.com/api`, tento o [Gigalixir](https://www.gigalixir.com/) como seu provedor.

O deploy acontece de forma automática através do **Github Actions**, onde em cada atualização realizada a branch `Main` é realizado um novo deploy.

### Testes

Para execução dos testes é possível rodar o comando:

```
mix test --cover
```

Caso seja necessário verificar a cobertura dos testes de uma forma mais visual é possível executar o comando:

```
mix coveralls.html
```

Onde é gerado o arquivo `cover/excoveralls.html` que pode ser acessado de qualquer browser para visualização.

## Documentação
### Criar sonda

Para realizar a movimentação da sonda é primeiramente necessário lançar uma, essa ação pode ser feita através da seguinte rota:

- **Caminho:** /probes
- **Método:** POST
- **Corpo da Requisição**: application/json
```json
{
  "name": "New Horizons"
}
```
- **Resposta:** application/json
```json
{
  "message": "Probe created!",
  "probe": {
    "direction": "D",
    "id": "c344d094-85fb-4060-ac56-1553226cdf96",
    "inserted_at": "2021-07-18T21:01:40Z",
    "name": "New Horizons",
    "updated_at": "2021-07-18T21:01:40Z",
    "x": 0,
    "y": 0
  }
}
```

### Mover sonda

Após a criação da sonda podemos utilizar seu `id` para alterar sua localização através de comandos.

Os comandos disponíveis sao:

- **GE:** girar 90 graus à esquerda
- **GD:** girar 90 graus à direta
- **M:** movimentar. Para cada comando M a sonda se move uma posição na direção à qual sua face está apontada.

A execução dos comando é feito pela rota:

- **Caminho:** /probes/`probe-id`/move
- **Método:** POST
- **Corpo da Requisição**: application/json
```json
{
  "movements": ["GE", "M", "M", "M", "GD", "M", "M"]
}
```
- **Resposta:** application/json
```json
{
  "message": "Probe moved!",
  "position": {
    "direction": "D",
    "x": 2,
    "y": 3
  }
}
```

### Reiniciar posição da sonda

Caso seja necessário reiniciar a sonda para a posição inicial podemos executar o comando pela rota:

- **Caminho:** /probes/`probe-id`/reset
- **Método:** POST
- **Resposta:** application/json
```json
{
  "message": "Probe position reset!",
  "probe": {
    "direction": "D",
    "x": 0,
    "y": 0
  }
}
```

### Recuperar informações da sonda

Para recuperar as informações da sonda bem como sua posição atual é possível realizar uma requisição para rota:

- **Caminho:** /probes/`probe-id`
- **Método:** GET
- **Resposta:** application/json
```json
{
  "probe": {
    "direction": "D",
    "id": "c344d094-85fb-4060-ac56-1553226cdf96",
    "inserted_at": "2021-07-18T21:01:40Z",
    "name": "New Horizons",
    "updated_at": "2021-07-18T21:13:41Z",
    "x": 2,
    "y": 3
  }
}
```