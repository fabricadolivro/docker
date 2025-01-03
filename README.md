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
    - [Instale o Ubuntu](#instale-o-ubuntu)
    - [Terminal do Windows](#terminal-do-windows)
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

<details>
  <summary>
    <strong>Extras</strong>
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
    - Vers�es mais antigas requerem a instala��o manual do WSL 2. Ver tutorial [https://learn.microsoft.com/en-us/windows/wsl/install-manual](https://learn.microsoft.com/en-us/windows/wsl/install-manual).
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

### Instale o Ubuntu

Execute o comando a seguir para instalar o `Ubuntu` (sem vers�o) como subsistema:

```bash
wsl --install
```

> A Ubuntu (sem vers�o) j� vem com v�rias ferramentas �teis para desenvolvimento instaladas por padr�o.
Se voc� quiser instalar uma vers�o diferente do Ubuntu, execute o comando `wsl -l -o` para listar as distribui��es dispon�veis.

> Tamb�m � poss�vel instalar distribui��es Linux pelo **Windows Store**. Basta acessar o Windows Store e procurar pelo nome da distribui��o Linux desejada e clicar em instalar.

Com �xito na opera��o, h� uma boa chance de precisar reiniciar o seu sistema para que as altera��es tenham efeito.
Ap�s, voc� dever� criar um **nome de usu�rio** que poder� ser o mesmo da sua m�quina.
Crie um nome de usu�rio sem espa�o e caracteres especiais) e uma **senha** (defina uma senha forte). Esta senha ser� usada para instalar pacotes e realizar opera��es de superusu�rio.

> Para abrir uma nova janela do Ubuntu, basta digitar `Ubuntu` no menu Iniciar e clicar no �cone do Ubuntu.

Parab�ns, seu WSL 2 j� est� funcionando!

### Terminal do Windows

Recomendamos o uso do [Windows Terminal](https://docs.microsoft.com/pt-br/windows/terminal/get-started) como terminal padr�o para desenvolvimento no Windows.

Por padr�o, ele identificar� e agregar� o shell do Ubuntu e os principais shells instalados no Windows, como PowerShell, CMD e WSL em uma �nica janela, al�m de permitir personaliza��o de cores, temas, atalhos e muito mais.
A experi�ncia de usar o Windows Terminal � muito melhor que o terminal padr�o do Windows, use ele para desenvolver no Windows e tamb�m para acessar o WSL 2.

Instale-o pelo **Windows Store**. Veja mais op��es de configura��o dele em [Mais sobre o Windows Terminal](https://docs.microsoft.com/pt-br/windows/terminal/get-started).

### Integra��o com VSCode

O Visual Studio Code tem uma extens�o chamada **WSL** que permite acessar o WSL 2 diretamente do VSCode. Com esta extens�o, voc� pode editar seus arquivos diretamente no WSL 2, rodar comandos, instalar extens�es e muito mais.

Veja mais sobre esta extens�o em [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl).

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

Baixe neste link: [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/) e instale o Docker Desktop.

> Se ao executar o instalador aparecer uma janela com erro `Erro - Este Aplicativo N�o Pode ser executado em seu computador`, 
> provavelmente voc� baixou uma vers�o incompativel com seu pc.
> 
> No Windows, verifique a arquitetura do sistema acessando **Configura��es** ? **Sistema** ? **Sobre**: 
> - 64-bit Operating System, x64-based processor ? Docker AMD64.
> - 64-bit Operating System, ARM-based processor ? Docker ARM64.

Importante - Durante a instala��o mantenha a op��o de suar o WSL 2 habilitada:

![Use WSL 2 instead of Hyper-V (recommended)](assets/img/use-wsl2-instead-of-hyper-v.png)

Logo ap�s a instala��o, ser� pedido para logar com sua conta do Docker. Fa�a o login (crie uma conta se n�o tiver) e siga as instru��es.

Ao final da instala��o, o Docker Desktop estar� instalado e rodando. Voc� pode ver o �cone do Docker perto do rel�gio do Windows. Ele ficar� rodando em segundo plano. A interface do Docker Desktop dever� ficar assim:

![Docker Desktop instalado](assets/img/installing-docker-desktop.png)

Podemos ver agora que h� 2 distribui��es Linux rodando no WSL 2, uma � a distribui��o padr�o do Ubuntu (ou a que voc� instalou) e a outra � a distribui��o do Docker Desktop. Rode o comando `wsl -l -v` para ver as distribui��es Linux instaladas e seu status atual.

![Distribui��es Linux rodando no WSL 2](assets/img/wsl-docker-desktop-running.png)

### Ativar o Docker na distribui��o Linux

Para o Docker funcionar na sua distribui��o Linux, voc� precisa ativa-lo no painel do Docker Desktop. Abra a interface do Docker Desktop, clique no �cone de engrenagem no canto superior direito, v� em `Resources -> WSL Integration` e habilite a distribui��o Linux que voc� deseja usar o Docker, e clique em `Apply & Restart`, conforme a imagem abaixo:

![Ativar Docker na distribui��o Linux](assets/img/docker-desktop-wsl-integration.png)

### Otimizar recursos do Docker Desktop

Existe um recurso no Docker Desktop chamado **Resource Save Mode** que otimiza o uso de recursos da m�quina. Ele diminui o uso de mem�ria RAM e CPU quando o Docker Desktop n�o est� sendo usado.

De tempos em tempos, o Docker Desktop vai analisar j� h� containers rodando e se n�o houver, ele vai diminuir o uso de recursos da m�quina.

Ative-o, clicando no �cone de engrenagem no canto superior direito, v� em `Resources -> Advanced` e habilite a op��o `Resource Save Mode`, conforme a imagem abaixo:

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

> O `.wslconfig` n�o existir� caso ainda n�o tenha alterado a configura��o padr�o do WSL antes, se for o caso, crie um arquivo no Bloco de Notas e salva como `.wslconfig`.

Esta op��o s� funcionar� ap�s reiniciar o WSL. Pare o WSL rodando o comando `wsl --shutdown`. Se o Docker Desktop estiver ativo, imediatamente notar� que WSL caiu, apenas clique em "Reiniciar" para subir uma nova inst�ncia do WSL.

# Ambiente de Desenvolvimento

Execute todos os comandos a partir daqui no terminal do **Ubuntu**.

> Para acess�-lo abrar um nova aba do Terminal do Windows (recomendado) ou digite `wsl` no PowerShell.

## Git & GitHub

**Git** � um sistema de controle de vers�o distribu�do que permite rastrear altera��es no c�digo, colaborar com outros desenvolvedores e reverter mudan�as, garantindo hist�rico e organiza��o no desenvolvimento de software.

J� o **GitHub** � uma plataforma baseada na nuvem que hospeda reposit�rios Git, adicionando ferramentas para colabora��o, gerenciamento de projetos, revis�o de c�digo e integra��o com outros servi�os.

> Resumindo: Git � a ferramenta de controle de vers�es de c�digo; GitHub � o servi�o que facilita o uso do Git em equipe. ?

A distribui��o Ubuntu instalada com WSL 2 j� vem com git. Voc� deve ser capaz de verificar a vers�o instalada executando:

```bash
git -v
```

### Comunica��o entre Git e GitHub com SSH

O Git e o GitHub podem se comunicar de forma segura usando chaves SSH. Isso elimina a necessidade de inserir credenciais repetidamente, automatizando e protegendo a autentica��o.

Como Funciona:

- Chave SSH Privada e P�blica:
  - A chave privada permanece no computador e � usada para autenticar conex�es.
  - A chave p�blica � adicionada � conta do GitHub e valida a chave privada.
- Configura��o do GitHub:
  - Com a chave p�blica cadastrada no GitHub, comandos Git, como `git push` e `git pull`, s�o autorizados automaticamente.

### Criando e Configurando Chaves SSH


### Configurando ssh para clone.

...


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

> Para clonar um reposit�rio com SSH, � necess�rio configurar uma chave e publica-la em seu perfil do github ([Saiba mais aqui](https://docs.github.com/pt/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)).

### ?? Vari�veis de Ambiente (.env)

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
 

# Extras

## Limitar recursos usados pelo WSL 2

Podemos dizer que o WSL 2 tem acesso quase que total ao recursos de sua m�quina. Ele tem acesso por padr�o:

* A 1TB de disco r�gido. � criado um disco virtual de 1TB para armazenar os arquivos do Linux (este limite pode ser expandido, ver a �rea de dicas e truques).
* A usar completamente os recursos de processamento.
* A usar 50% da mem�ria RAM dispon�vel.
* A usar 25% da mem�ria dispon�vel para SWAP (mem�ria virtual).

Se voc� quiser personalizar estes limites, crie um arquivo chamado `.wslconfig` na raiz da sua pasta de usu�rio `(C:\Users\<seu_usuario>)` e defina estas configura��es:

```conf
[wsl2]
memory=8GB
processors=4
```

Estes s�o limites de exemplo e as configura��es mais b�sicas a serem utilizadas, configure-os �s suas disponibilidades.

Para mais detalhes veja esta documenta��o da Microsoft: [https://learn.microsoft.com/pt-br/windows/wsl/wsl-config#configuration-setting-for-wslconfig](https://learn.microsoft.com/pt-br/windows/wsl/wsl-config#configuration-setting-for-wslconfig). Existem outras configura��es que podem ser feitas, como configura��es de rede, VPN, libera��o de mem�ria, etc.

> Para aplicar estas configura��es � necess�rio reiniciar as distribui��es Linux. Execute o comando: `wsl --shutdown` (Este comando vai desligar todas as inst�ncias WSL 2 ativas, basta abrir o terminal novamente para usa-las j� com as novas configura��es).

Este arquivo `.wslconfig` � um arquivo de configura��o global, ou seja, ele afetar� todas as distribui��es Linux que voc� tiver instalado no WSL 2, porque voc� pode ter mais de uma distribui��o Linux instalada no WSL 2, como um Ubuntu, um Debian, um Fedora, etc.

## Systemd

O WSL � compat�vel com o `systemd`. O `systemd` � um sistema de inicializa��o e gerenciamento de servi�os que � amplamente utilizado em distribui��es Linux modernas. Ela permitir� que voc� use ferramentas mais complexas no Linux como snapd, LXD, etc.

N�o � obrigat�rio ativa-lo e a qualquer momento ele pode ser desativado e reativado. Mas, recomendamos que o mantenha ativado, porque ele melhorar� a compatibilidade com as distribui��es Linux, permitindo que voc� use mais ferramentas e servi�os, como Kubernetes, etc (Ele n�o � necess�rio para rodar o Docker).

Para ativa-lo, edite o arquivo `/etc/wsl.conf`:

Rode o comando para editar:

```conf
sudo vim /etc/wsl.conf
```

Aperte a letra `i` (para entrar no modo de inser��o de conte�do) e cole o conte�do:

```conf
[boot]
systemd = true
```

Quando terminar a edi��o, pressione `Esc`, em seguida tecle `:` para entrar com o comando `wq` (salvar e sair) e pressione `enter`.

Toda vez que esta mudan�a for realizada � necess�rio reiniciar o WSL com o comando `wsl --shutdown` no DOS ou PowerShell.

## O que � WSLg

O WSLg � uma extens�o do WSL 2 que permite rodar aplica��es gr�ficas do Linux no Windows. Ele � uma extens�o do WSL 2 e n�o � necess�rio instalar nada adicional, basta ter o WSL 2 instalado e atualizado.

Com ele � poss�vel rodar aplica��es como Chrome, Firefox, Gedit, IDEs (VSCode, JetBrains) e at� aplica��es gr�ficas feitas em Java, Python e etc.

### Arquitetura do WSLg

O WSLg � composto pelos componentes: Wayland, Weston, PulseAudio e CBL-Mariner.

Basicamente teremos o Wayland como servidor gr�fico, o Weston como compositor, o PulseAudio para �udio e o CBL-Mariner como distribui��o Linux para rodar as aplica��es gr�ficas.

![Arquitetura do WSLg](assets/img/WSLg_ArchitectureOverview.png)

### Como ativar o WSLg

Para ativar o WSLg, basta ter o WSL 2 instalado e atualizado. N�o � necess�rio instalar nada adicional.

Quando instalar algum aplicativo que dependente de interface gr�fica, o WSLg ser� ativado automaticamente. Vamos a um exemplo:

```bash
sudo apt-get update

sudo apt-get install gedit
```

Abra o Gedit no terminal do WSL 2 digitando `gedit` e ele ser� aberto no Windows.

Portanto basta instalar o aplicativo e lan�a-lo no terminal do WSL 2 para que ele seja aberto no Windows.

