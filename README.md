<p align="center">
  <a href="https://fabricadolivro.com.br/" target="blank">
    <img src="assets/fabricadolivro-logo.svg"/>
  </a>
</p>

![Fabricadolivro Logo](assets/fabricadolivro-logo.svg)

# Guia de Ambiente de Trabalho

## 1 - Windows + WSL2 + Docker Desktop

...

- configurando ssh para clone.

## Instalar o Ubuntu no WSL

...

> *OBS.: Execute todos os comandos a seguir no terminal do Ubuntu / WSL 2.*

### Clonando os Repositórios

Dentro do diretório home do usuário atual crie a pasta raiz dos repositórios. Executando:

```shell
cd ~ && mkdir fabricadolivro
```

Clone todos os repositórios para dentro da pasta raiz. Faça isso executando:

```shell
cd ~/fabricadolivro
git clone git@github.com:fabricadolivro/docker.git
#git clone git@github.com:fabricadolivro/administrative.git
#git clone git@github.com:fabricadolivro/admin-backend.git
#git clone git@github.com:fabricadolivro/admin-frontend.git
git clone git@github.com:fabricadolivro/ecommerce-backend.git
git clone git@github.com:fabricadolivro/ecommerce-frontend.git
git clone git@github.com:fabricadolivro/editor-backend-api.git
git clone git@github.com:fabricadolivro/editor-frontend.git
```

> Para clonar um repositório com SSH, é necessário configurar uma chave e publica-la em seu perfil do github ([Saiba mais aqui](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)).

### ?? Variáveis de Ambiente (.env)

- Acesse a pasta do projeto "docker" e copie o arquivo `.env.example` para `.env`:
```shell
cd ~/fabricadolivro/docker && \
cp .env.example .env
```

- Insira suas  credencias de banco de dados (Development e Production) no arquivo de ambiente `.env`.

### Configurando os Hosts no Windows

Edite o arquivo ```hosts``` presente na pasta de configurações de rede no Windows (por padrão ```C:\Windows\System32\drivers\etc```) e adicione no final do arquivo as linhas a seguir:

```text
127.0.0.1 admin-backend.fabricadolivro.lab
127.0.0.1 admin-frontend.fabricadolivro.lab
127.0.0.1 administrative.fabricadolivro.lab
127.0.0.1 ecommerce-backend.fabricadolivro.lab
127.0.0.1 ecommerce-frontend.fabricadolivro.lab
127.0.0.1 editor-backend-api.fabricadolivro.lab
127.0.0.1 editor-frontend.fabricadolivro.lab
```
## Docker 

### Construindo as imagens Docker

Estando dentro do projeto **docker** (```~/fabricadolivro/docker```), execute:
```shell
#docker compose -f docker-compose.yml build
make build
```
> Na primeira vez, esse processo pode levar alguns minutos a depender da velocidade de conexão.

Ao termino do processo, o docker terá baixado as imagens Docker genéricas
(node, php 7.2, php8.4, mysql 8.0, redis...) e processado as instruções para
construção das imagens customizadas para os serviços definidos; além de
configurar dependências, volumes e variáveis de ambiente. Este comando é 
essencial para preparar as imagens antes de executar os containers.

### Instalando as dependências
 