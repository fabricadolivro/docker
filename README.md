<p align="center">
  <a href="https://fabricadolivro.com.br/" target="blank"><img src="assets/fabricadolivro-logo.svg"/></a>
</p>

# Guia de Ambiente de Trabalho

<details open>
  <summary>
    <strong>WSL</strong>
  </summary>

- [O que � WSL 2?](#o-que-�-wsl-2)
- [Requisitos m�nimos](#requisitos-m�nimos)
- [Instala��o do WSL 2 (Windows 10/11)](#instala��o-do-wsl-2-windows-1011)
    - [Windows Update](#windows-update)
    - [Terminal do Windows](#terminal-do-windows)
    - [Instale o Ubuntu](#instale-o-ubuntu)
    - [Integra��o com VSCode (opcional)](#integra��o-com-vscode-opcional)
</details>

<details open>
  <summary>
    <strong>Docker</strong>
  </summary>

- [O que � o Docker](#o-que-�-docker)
    - [Vantagens & Desvantagens](#vantagens--desvantagens)
- [Docker no Windows](#docker-no-windows)
- [Instala��o do Docker Desktop (com WSL 2)](#instala��o-do-docker-desktop-com-wsl-2)
     - [Ativar o Docker na distribui��o Linux](#ativar-o-docker-na-distribui��o-linux)
     - [Otimizar recursos do Docker Desktop](#otimizar-recursos-do-docker-desktop)
     - [Aplicar autoMemoryReclaim no WSL 2](#aplicar-automemoryreclaim-no-wsl-2)
</details>

<details>
  <summary>
    <strong>Ambiente de Desenvolvimento

</strong>
  </summary>

- [Limitar recursos usados pelo WSL 2](#limitar-recursos-usados-pelo-wsl-2)
- [Systemd](#systemd)
- [O que � WSLg](#o-que-�-wslg)
</details>

## O que � WSL 2

O WSL 2 ou ***Windows Subsystem for Linux***, � uma camada de compatibilidade que permite executar distribui��es Linux nativamente no Windows, utilizando uma arquitetura baseada em um kernel completo Linux completo integrado ao sistema. 

Ele oferece melhor desempenho, compatibilidade total com chamadas do sistema Linux e suporte a ferramentas de desenvolvimento como Docker e Kubernetes, facilitando a cria��o e o uso de ambientes de desenvolvimento h�bridos diretamente no Windows.

> Com WSL 2 � poss�vel executar Docker e outras ferramentas que dependem do Kernel do Linux usando o Windows 10/11.

## Requisitos m�nimos

* **Windows 10 Home ou Professional**
    - Vers�o 2004 ou superior (Build 19041 ou superior).
    - Vers�es mais antigas requerem a instala��o manual do WSL 2. <a href="https://learn.microsoft.com/en-us/windows/wsl/install-manual/" target="_blank">Ver tutorial</a>.
* **Windows 11 Home ou Professional**
    - Vers�o 22000 ou superior (qualquer Windows 11).
* Uma m�quina compat�vel com virtualiza��o. Se sua m�quina for mais antiga pode ser necess�ria habilita-la na BIOS).
* Pelo menos 4GB de mem�ria RAM (Recomendado 8GB).

## Instala��o do WSL 2 (Windows 10/11)

### Windows Update

� essencial manter o Windows atualizado, pois o **WSL 2 depende de uma vers�o atualizada do Hyper-V**. Verifique o Windows Update.
Com a vers�o 2004 do Windows 10 ou Windows 11, o <span style="color:#ffff00">WSL j� estar� presente em sua m�quina</span>, execute o comando para ver a vers�o do WSL:

```bash
wsl --version
```

A vers�o 2 normalmente � a default, mas a vers�o 1 do WSL pode estar como default, execute o comando abaixo para definir como default a vers�o 2:

```bash
wsl --set-default-version 2
```

### Terminal do Windows

Recomendamos o uso do <a href="https://docs.microsoft.com/pt-br/windows/terminal/get-started/" target="_blank">Windows Terminal</a> como terminal padr�o para desenvolvimento no Windows.

Por padr�o, ele identificar� e agregar� o shell do Ubuntu e os principais shells instalados no Windows, como PowerShell, CMD e WSL em uma �nica janela, al�m de permitir personaliza��o de cores, temas, atalhos e muito mais.
A experi�ncia de usar o Windows Terminal � muito melhor que o terminal padr�o do Windows, use ele para desenvolver no Windows e tamb�m para acessar o WSL 2.

Instale-o pelo **Windows Store**. Veja mais op��es de configura��o dele em <a href="https://docs.microsoft.com/pt-br/windows/terminal/get-started/" target="_blank">Mais sobre o Windows Terminal</a>.

> Para uma experi�ncia de shell mais moderna e eficiente, recomendamos o uso do **Oh My Zsh**. Consulte o arquivo [Extras.md](Extras.md#oh-my-zsh) para instru��es de instala��o.

### Instale o Ubuntu

Existem duas maneiras de instalar: pelos **comandos do WSL** ou pela **Windows Store**. Independente do meio, recomendamos o Ubuntu (sem vers�o) por ser uma distribui��o popular e que j� vem com v�rias ferramentas �teis para desenvolvimento instaladas por padr�o.

- **Op��o 1 - Instala��o via comandos**

Execute o comando a seguir para instalar o `Ubuntu` (sem vers�o) como o Linux padr�o:

```bash
wsl --install
```

Se voc� quiser instalar uma vers�o diferente do Ubuntu, execute o comando `wsl -l -o` para listar as distribui��es dispon�veis. Instale a vers�o escolhida com o comando `wsl --install -d nome-da-distribuicao`.

> Para instalar a distribui��o numa pasta ou dispositivo espec�fico, baixe a
> distribui��o da Microsoft Store, importe a distribui��o com o commando 
> `wsl --import <nome-da-distro> <caminho-da-pasta-de-instalacao> <caminho-do-arquivo-rootfs>` (), 
> defina a distribui��o padr�o `wsl --set-default <nome-da-distro>` e abra com `wsl -d <nome-da-distro>`.

Voc� dever� criar um **nome de usu�rio** que poder� ser o mesmo da sua m�quina.
Crie um nome de usu�rio sem espa�o e caracteres especiais) e uma **senha** (defina uma senha forte). Esta senha ser� usada para instalar pacotes e realizar opera��es de superusu�rio.

Com �xito na opera��o, h� uma boa chance de precisar reiniciar o seu sistema para que as altera��es tenham efeito.

> Para abrir uma nova janela do Ubuntu, basta digitar `Ubuntu` no menu Iniciar e clicar no �cone do Ubuntu.

Parab�ns, seu WSL 2 j� est� funcionando!

![WSL2 working!](assets/img/wsl2-working.png)

- **Op��o 2 - Instala��o via Windows Store**

Basta acessar o Windows Store e procurar pelo nome da distribui��o Linux desejada e clicar em instalar.

![Linux distros](assets/img/linux-distros.png)

Ap�s a instala��o, clique em "Abrir" para acessar o terminal e criar a conta de usu�rio UNIX padr�o.

![Crie conta de usu�rio UNIX padr�o](assets/img/create-default-unix-user-account.png)

### Integra��o com VSCode

O Visual Studio Code tem uma extens�o chamada **WSL** que permite acessar o WSL 2 diretamente do VSCode. Com esta extens�o, voc� pode editar seus arquivos diretamente no WSL 2, rodar comandos, instalar extens�es e muito mais.

Veja mais sobre esta extens�o em <a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl" target="_blank">WSL</a>.

Ao abrir um projeto que est� dentro do Linux, � importante que o modo WSL do VSCode esteja ativado. No canto inferior esquerdo do VSCode, clique no bot�o `><` e selecione `Connect to WSL`. Isto ir� conectar o VSCode ao WSL 2 e ent�o poder� abrir o projeto que est� dentro do Linux. Voc� ver� que o bot�o `><` mudar� para `WSL: Ubuntu`.

![Conectar ao WSL 2 no VSCode](assets/img/vscode-remote-wsl.png)

Se o VSCode n�o estiver desta forma ao abrir projetos dentro do Linux, ent�o o modo WSL n�o estar� ativado e voc� perder� performance ao editar arquivos dentro do Linux, al�m de n�o ter suporte para algumas extens�es.

> Com a extens�o tamb�m ser� poss�vel abrir o projeto no modo WSL diretamente pelo terminal. 
> Acesse a pasta do projeto no terminal do WSL e digite `code .`. Isto abrir� o VSCode no modo WSL. 
> Para que o atalho funcione, voc� deve iniciar uma nova se��o do terminal do WSL ap�s instala��o da extens�o. 

# Docker 

## O que � o Docker

O Docker � uma plataforma open source de containers que permite empacotar aplicativos e suas depend�ncias em um ambiente isolado e port�til.

### Vantagens & Desvantagens

O Docker � ideal para desenvolvimento, CI/CD e implanta��o em escala por ser mais eficiente que VMS, ambientes em nuvem e locais nativos.

Vantagens:

1. **Leveza**: Containers compartilham o kernel do sistema operacional, consumindo menos recursos comparado a uma VM que precisa de um sistema operacional completo.
2. **Velocidade**: Inicializam em segundos, enquanto VMs e Clouds podem levar minutos.
3. **Portabilidade**: Os containers funcionam da mesma forma em qualquer ambiente que suporte Docker.
4. **Gerenciamento Simples**: Menor overhead para criar, destruir ou replicar ambientes.
5. **Melhor Utiliza��o de Recursos**: Mais containers podem rodar no mesmo host, otimizando hardware se comparados com outras op��es.

Desvantagens:

1. Desempenho: Containers podem ter overhead em compara��o a processos nativos.
2. Compatibilidade: Nem todos os aplicativos ou servi�os suportam execu��o em containers.
3. Seguran�a: N�o indicado para ambiente production. Menos isolamento que VMs, pois compartilham o kernel do host.
4. Curva de aprendizado: Configurar e gerenciar containers pode ser complexo para iniciantes.

## Docker no Windows

H� ao menos 4 modos de usar o Docker no Windows, no entanto iremos optar pelo **Docker Desktop com WSL 2**.

> - **Docker Toolbox** - o desempenho do Toolbox pode ser muito ruim. Recomendado para vers�es antigas do Windows (Xp, Vista, 7, 8 e 8.1);
> - **Docker Desktop com Hyper-V** - Necessita da vers�o **PRO** do Windows 10/11, portanto � necess�rio compra-la.
> - **Docker Engine** (Docker Nativo) - diretamente instalado no WSL 2 � vi�vel, todavia a manuten��o e seguran�a pode ser um desafiante para usu�rios iniciantes.

Docker Desktop com WSL 2 tem um grande desempenho e consome menos recursos quando comparado ao Docker Toolbox ou Docker Desktop com Hyper-V.

## Instala��o do Docker Desktop (com WSL 2)

Baixe neste link: <a href="https://www.docker.com/products/docker-desktop/" target="_blank">https://www.docker.com/products/docker-desktop/</a> e instale o Docker Desktop.

> Se ao executar o instalador aparecer uma janela com erro `Erro - Este Aplicativo N�o Pode ser executado em seu computador`, 
> provavelmente voc� baixou uma vers�o incompativel com seu pc.
> 
> No Windows, verifique a arquitetura do sistema acessando **Configura��es** &rarr; **Sistema** &rarr; **Sobre**: 
> - 64-bit Operating System, x64-based processor &rarr; Docker AMD64.
> - 64-bit Operating System, ARM-based processor &rarr; Docker ARM64.

Importante - Durante a instala��o mantenha a op��o de suar o WSL 2 habilitada:

![Use WSL 2 instead of Hyper-V (recommended)](assets/img/use-wsl2-instead-of-hyper-v.png)

Logo ap�s a instala��o, ser� pedido para logar com sua conta do Docker. Fa�a o login (crie uma conta se n�o tiver) e siga as instru��es.

Ao final da instala��o, o Docker Desktop estar� instalado e rodando. Voc� pode ver o �cone do Docker perto do rel�gio do Windows. Ele ficar� rodando em segundo plano. A interface do Docker Desktop dever� ficar assim:

![Docker Desktop instalado](assets/img/installing-docker-desktop.png)

Podemos ver agora que h� 2 distribui��es Linux rodando no WSL 2, uma � a distribui��o padr�o do Ubuntu (ou a que voc� instalou) e a outra � a distribui��o do Docker Desktop. Rode o comando `wsl -l -v` para ver as distribui��es Linux instaladas e seu status atual.

![Distribui��es Linux rodando no WSL 2](assets/img/wsl-docker-desktop-running.png)

### Ativar o Docker na distribui��o Linux

Para o Docker funcionar na sua distribui��o Linux, voc� precisa ativa-lo no painel do Docker Desktop. Abra a interface do Docker Desktop, clique no �cone de engrenagem no canto superior direito, v� em `Resources` &rarr; `WSL Integration` e habilite a distribui��o Linux que voc� deseja usar o Docker, e clique em `Apply & Restart`, conforme a imagem abaixo:

![Ativar Docker na distribui��o Linux](assets/img/docker-desktop-wsl-integration.png)

### Otimizar recursos do Docker Desktop

Existe um recurso no Docker Desktop chamado **Resource Save Mode** que otimiza o uso de recursos da m�quina. Ele diminui o uso de mem�ria RAM e CPU quando o Docker Desktop n�o est� sendo usado.

De tempos em tempos, o Docker Desktop vai analisar se h� containers rodando e se n�o houver, ele vai diminuir o uso de recursos da m�quina.

Ative-o, clicando no �cone de engrenagem no canto superior direito, v� em `Resources` &rarr; `Advanced` e habilite a op��o `Resource Save Mode`, conforme a imagem abaixo:

![Ativar Resource Save Mode no Docker Desktop](assets/img/resource-saver.png)

Voc� pode escolher de quanto em quanto tempo o Docker Desktop vai analisar se h� containers rodando e diminuir o uso de recursos da m�quina. O padr�o � 5 min.

### Aplicar autoMemoryReclaim no WSL 2

Com o passar do tempo, o WSL pode consumir mem�ria RAM e n�o liberar, � feito cache de mem�ria para melhorar o desempenho, mas podemos liberar esta mem�ria depois de um tempo. Esta op��o � chamada de `autoMemoryReclaim`, ela libera a mem�ria RAM que n�o est� sendo usada atrav�s de uma das 2 op��es:

* gradual: Libera a mem�ria RAM de forma gradual de 5 em 5 minutos.
* dropcache: Libera a mem�ria RAM de forma imediata.

Para ativar o `autoMemoryReclaim`, edite o arquivo `.wslconfig` presente na pasta de usu�rio do Windows (`%USERPROFILE%`):

```conf
[experimental]
autoMemoryReclaim=gradual
```

> O `.wslconfig` n�o existir� caso ainda n�o tenha alterado a configura��o padr�o do WSL antes, se for o caso, crie um arquivo no Bloco de Notas e salve como `.wslconfig`.

Esta op��o s� funcionar� ap�s reiniciar o WSL. Pare o WSL rodando o comando `wsl --shutdown`. Se o Docker Desktop estiver ativo, imediatamente notar� que WSL caiu, apenas clique em "Reiniciar" para subir uma nova inst�ncia do WSL.

<span style="color:#ffffff;background-color:#3d444c;width:100%;display:block;padding:.8rem 1rem">
A partir deste ponto, execute todos os comandos a partir daqui no terminal do <b>Ubuntu</b>.
Para acess�-lo abrar um nova aba do Terminal do Windows (recomendado) ou digite `wsl` no PowerShell.
</span>


# Git & GitHub

**Git** � um sistema de controle de vers�o distribu�do que permite rastrear altera��es no c�digo, colaborar com outros desenvolvedores e reverter mudan�as, garantindo hist�rico e organiza��o no desenvolvimento de software.

J� o **GitHub** � uma plataforma baseada na nuvem que hospeda reposit�rios Git, adicionando ferramentas para colabora��o, gerenciamento de projetos, revis�o de c�digo e integra��o com outros servi�os.

> Resumindo: Git � a ferramenta de controle de vers�es de c�digo; GitHub � o servi�o que facilita o uso do Git em equipe.

A distribui��o Ubuntu instalada com WSL 2 j� vem com git. Voc� deve ser capaz de verificar a vers�o instalada executando:

```bash
git -v
```

### Conta no GitHub

Se voc� ainda n�o possui uma conta pessoal no GitHub, interrompa a leitura deste guia e crie sua conta no <a href="https://github.com/" target="_blank">site oficial do GitHub</a>.

### Configura��o global

Para configurar um usu�rio global no Git, execute:

```bash
git config --global user.name "Seu Nome ou username"
git config --global user.email "seuemaildogithub@exemplo.com"
```

> Recomendo utilizar o seu `username` e `email` do GitHub como seu `name` e `email` globais.

Para verificar se os valores foram definidos corretamente:

```bash
git config --global --list
```

### Comunica��o entre Git e GitHub com SSH

O Git e o GitHub podem se comunicar de forma segura usando chaves SSH. Isso elimina a necessidade de inserir credenciais repetidamente (via HTTPS), automatizando e protegendo a autentica��o.

Como Funciona:

- Chave SSH Privada e P�blica:
  - A chave privada permanece no computador e � usada para autenticar conex�es.
  - A chave p�blica � adicionada � conta do GitHub e valida a chave privada.
- Configura��o do GitHub:
  - Com a chave p�blica cadastrada no GitHub, comandos Git, como `git push` e `git pull`, s�o autorizados automaticamente.

## Criando e Configurando Chaves SSH no GitHub (Linux)

### 1. Gere uma chave SSH local:

```bash
cd ~ 
ssh-keygen -t rsa -b 4096 -C "seuemaildogithub@example.com"
```

Quando for solicitado a inserir um arquivo para salvar a chave, pressione `Enter` para aceitar o local padr�o do arquivo (`~/.ssh`). 

```bash
> Enter a file in which to save the key (/home/YOU/.ssh/id_ALGORITHM):[Press enter]
```

> Observe que, se voc� criou chaves SSH anteriormente, ssh-keygen pode pedir que voc� reescreva outra chave. Nesse caso, recomendamos criar uma chave SSH personalizada. Para fazer isso, digite o local do arquivo padr�o e substitua id_ALGORITHM pelo nome da chave personalizada.

Em seguida, digite (e confirme) uma frase secreta segura. Para saber mais, confira <a href="https://docs.github.com/pt/enterprise-server@3.10/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases" target="_blank">Trabalhar com frase secreta da chave SSH</a>.

```bash
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```

### 2. Adicione a chave SSH ao ssh-agent

Inicie o ssh-agent em segundo plano.

```bash
eval "$(ssh-agent -s)"
# Agent pid 2245
```

Adicione sua chave SSH privada ao ssh-agent.

```bash
ssh-add ~/.ssh/id_rsa
```

### 3. <a href="https://docs.github.com/pt/enterprise-server@3.10/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account" target="_blank">Adicione a chave SSH p�blica � sua conta do GitHub</a>.

#### 3.1. Copie a chave p�blica SSH para a sua �rea de transfer�ncia.

```bash
clip.exe < ~/.ssh/id_rsa.pub
# Copia o conte�do do arquivo id_rsa.pub para o clipboard
```

Nas vers�es mais recentes do Windows que usam o Windows Terminal ou em qualquer outro lugar que use a linha de comando do PowerShell, voc� poder� receber um ParseError indicando que The '&lt;' operator is reserved for future use.. Nesse caso, o seguinte comando alternativo clip deve ser usado: `cat ~/.ssh/id_ed25519.pub | clip`

#### 3.2. Adicione a chave copiada o GitHub.

- No canto superior direito de qualquer p�gina do GitHub, clique sua foto de perfil e, em seguida, clique em **?? Configura��es** (`Settings`).
- Na se��o "Acesso" da barra lateral, clique em **? Chaves SSH e GPG** (`SSH and GPG keys`).
- Clique em **Nova chave SSH** (`New SSH Key`) ou **Adicionar chave SSH**.
- No campo "T�tulo" (`Title`), adicione uma etiqueta descritiva para a nova chave. Por exemplo, se estiver usando um laptop pessoal, voc� poder� chamar essa chave de "Notebook do trabalho".
- Selecione o tipo de chave (`Key type`) "**autentica��o**". Para saber mais sobre a "assinatura" de commit, confira <a href="https://docs.github.com/pt/enterprise-server@3.10/authentication/managing-commit-signature-verification/about-commit-signature-verification" target="_blank">Sobre a verifica��o de assinatura de commit</a>.
- No campo "Chave" (`Key`), cole sua chave p�blica.
- Clique em **Adicionar chave SSH** (`Add SSH Key`).

> Se solicitado, fa�a a autentica��o de dois fatores (2FA) para finalizar a adi��o.

#### 3.3. Teste a chave SSH configurada no GitHub

Tentar autenticar sua chave SSH com o servidor do GitHub executando o comando:

```bash
ssh -T git@github.com
```

> Se for a primeira vez que voc� est� se conectando a esse servidor, a chave p�blica dele n�o est� armazenada no arquivo `~/.ssh/known_hosts` do seu sistema.
> Digite `yes` para continuar. Isso adicionar� a chave do GitHub as redes conhecidas e n�o ser� perguntado novamente. 

Se a configura��o estiver correta, voc� ver� uma mensagem como:

```bash
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

# Ambiente de Desenvolvimento

## Reposit�rios e Hosts

### Clonando os Reposit�rios

Dentro do diret�rio home do usu�rio atual crie a pasta raiz dos reposit�rios. Executando:

```shell
cd ~ && mkdir fabricadolivro
```

Clone todos os reposit�rios para dentro da pasta raiz. Fa�a isso executando:

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

> Para clonar um reposit�rio com SSH, � necess�rio configurar uma chave e public�-la no seu perfil do github. <a href="https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent" target="_blank">Saiba mais aqui</a>.

### Vari�veis de Ambiente (.env)

- Acesse a pasta do projeto "docker" e copie o arquivo `.env.example` para `.env`:
```shell
cd ~/fabricadolivro/docker && \
cp .env.example .env
```

- Insira suas  credencias de banco de dados (Development e Production) no arquivo de ambiente `.env`.

### Configurando os Hosts no Windows

Edite o arquivo ```hosts``` presente na pasta de configura��es de rede no Windows (por padr�o ```C:\Windows\System32\drivers\etc```) e adicione no final do arquivo as linhas a seguir:

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

> Na primeira vez, esse processo pode levar alguns minutos a depender da velocidade de conex�o.

Ao termino do processo, o docker ter� baixado as imagens Docker gen�ricas
(node, php 7.2, php8.4, mysql 8.0, redis...) e processado as instru��es para
constru��o das imagens customizadas para os servi�os definidos; al�m de
configurar depend�ncias, volumes e vari�veis de ambiente. Este comando � 
essencial para preparar as imagens antes de executar os containers.

### Instalando as depend�ncias

...

> <span style="color:#ffff00">Pronto!</span> Seu ambiente de desenvolvimento est� pronto!

# Extras

Para recursos avan�ados verifique o arquivo [Extras.md](Extras.md): 

- **WSL2** - como limita recursos
- **Systemd** - para recursos avan�ados
- **WSLg** - abra apps do Ubuntu no Windows
- **Zsh** e **Oh My Zsh** - shell moderno
- **NVM** - gerenciamento de vers�es Node.js