<p align="center">
  <a href="https://fabricadolivro.com.br/" target="blank"><img src="assets/fabricadolivro-logo.svg"/></a>
</p>

# Ferramentas Extras

> Todo conte�do desta se��o � opcional e n�o mandat�rio para o desenvolvimento.

<details open>
  <summary>
    <strong>WSL</strong>
  </summary>

- [Limitar recursos usados pelo WSL 2](#limitar-recursos-usados-pelo-wsl-2)
- [Systemd](#systemd)
- [O que � WSLg](#o-que-�-wslg)
     - [Arquitetura do WSLg](#arquitetura-do-wslg)
     - [Como ativar o WSLg](#como-ativar-o-wslg)
</details>

<details>
  <summary>
    <strong>ZSH</strong>
  </summary>

- [Vantagens do ZSH sobre o Bash](#Vantagens do ZSH sobre o Bash)
- [Instale o ZSH](#instale-o-zsh)
- [Configurando o ZSH no Ubuntu Linux](#configurando-o-zsh-no-ubuntu-linux)
- [Reverter para o antigo Bash Shell](#reverter-para-o-antigo-bash-shell)
</details>

<details>
  <summary>
    <strong>Oh My Zsh</strong>
  </summary>

- [Requisitos](#requisitos)
- [Instala��o OH-MY-ZSH](#instala��o-oh-my-zsh)
- [Temas OH-MY-ZSH](#temas-oh-my-zsh)
- [Plugins OH-MY-ZSH](#plugins-oh-my-zsh)
- [Atualiza��o autom�tica](#atualiza��o-autom�tica)
- [Removendo do Ubuntu Linux](#removendo-do-ubuntu-linux)
</details>

<details>
  <summary>
    <strong>NVM</strong>
  </summary>

- [Conhe�a o NVM!](#conheca-o-nvm)
- [Instala��o do NVM](#instalacao-do-nvm)
- [Comandos B�sicos](#comandos-basicos)
- [Migra��o de pacotes globais](#migra��o-de-pacotes-globais)
- [Defini��o de vers�o por projeto](#defini��o-de-vers�o-por-projeto)
</details>

# WSL

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

Aperte a letra `i` ou `insert` (para entrar no modo de inser��o de conte�do) e cole o conte�do:

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

# ZSH

O ZSH (Z Shell) � um shell poderoso e personaliz�vel para sistemas UNIX, como Linux e macOS. Ele � uma alternativa ao Bash (Bourne Again Shell), oferecendo recursos avan�ados que tornam o uso do terminal mais eficiente e produtivo.

## Vantagens do ZSH sobre o Bash:

- **Autocompletar Inteligente**: Sugest�es autom�ticas para comandos e op��es.
- **Temas e Plugins**: Personalize a apar�ncia do terminal e adicione funcionalidades extras facilmente.
- **Corre��o de Comandos**: Identifica e corrige erros de digita��o em comandos.
- **Hist�rico Aprimorado**: Pesquisa r�pida e eficiente no hist�rico de comandos.
- **Glob Patterns Avan�ados**: Melhor manipula��o de arquivos e diret�rios.

Combinado com ferramentas como **Oh My Zsh**, o ZSH proporciona uma experi�ncia mais moderna e produtiva no terminal.

## Instale o ZSH

Use o **gerenciador de pacotes apt** para instalar o **ZSH** no **Ubuntu**.

```bash
sudo apt install zsh
```

> O apt instalar� a vers�o mais recente do **ZSH**. Para ver digite: `zsh --version`

Instalar o **ZSH** n�o ir� modific�-lo e defini-lo como o shell padr�o. Temos que modificar as configura��es para tornar o ZSH nosso shell padr�o.
Use o comando `chsh` com flag `-s` para alternar o shell padr�o para o usu�rio.

```bash
echo $SHELL
chsh -s $(which zsh) 
# ou
chsh -s /usr/bin/zsh
```
 
![Set Zsh Shell in Ubuntu](assets/img/set_zsh_shell_in_ubuntu.png)

Agora, saia do terminal e fa�a login novamente.

### Configurando o ZSH no Ubuntu Linux

Comparado a outros shells como BASH , o ZSH requer alguma configura��o inicial para ser mantido. Quando voc� inicia o ZSH **pela primeira vez**, ele lhe dar� algumas op��es para configurar.

Selecionando a op��o �**1**� na primeira p�gina, nos levar� ao menu principal para configurar manualmente cada op��o.
Podemos escolher a op��o "**2**" que preencher� o arquivo `.zshrc` com a configura��o padr�o. Podemos alterar os par�metros diretamente no arquivo `.zshrc`.

![Zsh Default Parameters](Zsh-Default-Parameters.png)

### Reverter para o antigo Bash Shell

Execute:

```bash
sudo apt --purge remove zsh 
chsh -s $(which "SHELL NAME")
```

Agora abra uma nova sess�o para ver as altera��es que ser�o efetivadas.

# Oh My ZSH

[**OH-MY-ZSH**](https://ohmyz.sh/) � um framework de c�digo aberto para gerenciar a configura��o do **ZSH** e � conduzido pela comunidade. Ele vem com toneladas de fun��es �teis, plugins, ajudantes, temas e algumas coisas que o tornar�o melhor no terminal. Atualmente, h� mais de **275** plugins e **150** temas suportados.

### Requisitos
- O Zsh deve ser instalado (v4.3.9 ou mais recente serviria, mas preferimos 5.0.8 e mais recentes).
- Curl ou Wget devem ser instalados.
- O Git deve ser instalado (recomenda-se v2.4.11 ou superior).

## Instala��o OH-MY-ZSH

```bash
sudo apt instalar curl wget git
```

Em seguida, [instale o **Oh My Zsh** via linha de comando com **curl** ou **wget**](https://ohmyz.sh/#install).

![Install Oh My Zsh](assets/img/install-Oh-My-Zsh.png)

Depois que voc� instalar o **OH-MY-ZSH**, ele far� um backup do seu arquivo `.zhrc` existente.
Ent�o, um novo `.zshrc` ser� criado com as configura��es. Ent�o, sempre que voc� decidir remover o **OH-MY-ZSH** usando o desinstalador, o arquivo `.zshrc` ser� revertido automaticamente.

> Todas as configura��es s�o colocadas no arquivo `.zshrc`. � aqui que voc� vai alterar os par�metros ou habilitar novos plugins ou alterar temas com base nas necessidades.

## Temas OH-MY-ZSH

Os temas melhoram visualmente a apar�ncia e o comportamento do terminal. Os temas s�o instalados em �`~/.oh-my-zsh/themes/`�.

```bash
ls -la ~/.oh-my-zsh/themes/
```

Para que as altera��es tenham efeito, execute:

```bash
source ~/.zshrc
```

## Plugins OH-MY-ZSH

H� toneladas de plugins que s�o suportados pelo **OH-MY-ZSH**. Configurar um plugin � bem f�cil.
Tudo o que voc� precisa fazer � obter o pacote do plugin e adicionar o nome do plugin no par�metro plugins no arquivo `.zshrc`.
Por padr�o, o **git** � o �nico plugin que � habilitado ap�s a instala��o.

Adicione dois plugins `ZSH-autosuggestions` e `ZSH-Syntax-highlighting` clonando os pacotes.

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

Para tornar os plugins eficazes, editar o arquivo `.zhsrc` e adicione os nomes dos plugins em `plugins=()` com um espa�o entre cada nome.

![Plugins OH-MY-ZSH](assets/img/plugins-zsh.png)

```text
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Crie o arquivo source (`source ~/.zshrc`) para que as altera��es sejam efetivas. 
Agora voc� pode ver na captura de tela que o recurso de autossugest�o est� habilitado e ele lembra o comando que usei anteriormente e sugere com base nele.

![Autocomplete](assets/img/Autocomplete.png)

## Atualiza��o autom�tica

O **OH-MY-ZSH** verifica automaticamente se h� atualiza��es quinzenalmente. Para desativ�-lo, defina o par�metro `DISABLE_AUTO_UPDATE=�true�`.
Voc� tamb�m pode controlar o n�mero de dias em que a atualiza��o deve ser executada definindo `export UPDATE_ZSH_DAYS=<NUMBER OF DAYS>`.

## Removendo do Ubuntu Linux

Execute o comando:

```bash
uninstall oh_my_zsh
```

Ele remover� todos os arquivos e pastas necess�rios que fazem parte do **OH-MY-ZSH** e reverter� para o estado anterior. **Reinicie seu terminal para que as altera��es sejam efetivadas**.

# NVM

### O que � o NVM?

O **NVM (Node Version Manager)** � uma ferramenta que permite gerenciar m�ltiplas vers�es do Node.js no mesmo ambiente. Com ele, � poss�vel instalar, alternar e utilizar diferentes vers�es do Node.js de forma simples e eficiente, garantindo compatibilidade com projetos que dependem de vers�es espec�ficas.
Isso � especialmente �til para desenvolvedores que trabalham com aplica��es variadas em diferentes ambientes.

### Instala��o do NVM

> � recomendado desinstalar qualquer vers�o do Node.js presente em sua m�quina antes de instalar o NVM para evitar colis�es.

Para instalar o NVM basta usar o curl ou Wget. Execute no terminal:

```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# ou
$ wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

Isso vai executar um script que vai clonar o reposit�rio do NVM e jogar em um diret�rio chamado `~/.nvm`, que � onde ser�o instaladas as v�rias vers�es do Node.js que quisermos.

> Ap�s instalar, pode ser necess�rio reiniciar o seu terminal.

### Comandos B�sicos

Os comandos s�o bem simples.

Para ver as vers�es que est�o instaladas em sua m�quina:

| Comando       |                                   Descri��o                                   |
|:--------------|:-----------------------------------------------------------------------------|
| ```nvm ls```  |                           Listar vers�es instaladas                           |
| ```nvm ls-remote```  |                  Listar vers�es dispon�veis para instala��o                   |
| ```nvm install vX.X.X```  |                              Instalar uma vers�o                              |
| ```nvm uninstall vX.X.X```  |                            Desinstalar uma vers�o                             |
| ```nvm use vX.X.X```  |                          Usar uma vers�o do Node.js                           |
| ```nvm use node```  |                     Usar a vers�o mais recente do Node.js                     |
| ```nvm alias meunome vX.X.X```  |                         Definir nome para uma vers�o                          |
| ```nvm use meunome```  |                        Usar vers�o pelo nome definido                         |
| ```nvm unalias meunome```  |                           Remover um nome de vers�o                           |
| ```nvm alias default vX.X.X```  |                           Definir uma vers�o padr�o                           |
| ```nvm alias default node```  |                    Definir vers�o mais recente como padr�o                    |
| ```nvm  current```  |                           Indica��o da vers�o atual                           |

### Migra��o de pacotes globais


Quando voc� altera a vers�o do Node.js em uso, a vers�o do NPM tamb�m muda. Isso significa que os pacotes instalados globalmente em uma vers�o n�o estar�o dispon�veis ao utilizar outra.
Para evitar o trabalho de reinstalar cada pacote global ao mudar de vers�o do Node.js, voc� pode usar a op��o `--reinstall-packages-from`.

Por exemplo, ao instalar a **vers�o 6** do Node.js, voc� pode usar esse comando para transferir automaticamente os pacotes globais instalados na **vers�o 5**, simplificando a transi��o entre vers�es.

```bash
nvm install 6 --reinstall-packages-from=5
```

Como mencionado, `node` � um atalho para indicar a vers�o mais recente. Caso queira instalar a vers�o mais recente dispon�vel e j� migrar os pacotes globais da vers�o mais recente que est� instalada na sua m�quina, basta executar:

```bash
nvm install node --reinstall-packages-from=node
```

> Execute o nvm dentro do WSL. No momento esta funcionalidade ainda n�o est� dispon�vel para o nvm-windows, sendo necess�ria a instala��o manual dos pacotes globais sempre que instalar uma nova vers�o do Node.js.

### Defini��o de vers�o por projeto

O objetivo de usar o **NVM** � gerenciar diferentes vers�es do Node.js para cada projeto. No entanto, pode ser dif�cil lembrar qual vers�o foi usada em cada um.
Para resolver isso, basta criar um arquivo chamado `.nvmrc` na raiz do projeto e inserir a vers�o do Node.js usada nesse projeto. Por exemplo:

```text
v12.4.0
```

Assim, ao abrir o terminal dentro do projeto e executar o comando `nvm use`, o NVM localizar� automaticamente o arquivo `.nvmrc` e utilizar� a vers�o indicada, garantindo consist�ncia no ambiente.


# Fontes

- [Site Oh My Zsh](https://ohmyz.sh/)
- [Como instalar o OH-MY-ZSH no Ubuntu 20.04](https://www.tecmint.com/install-oh-my-zsh-in-ubuntu/)
- [Projeto NVM no GitHub](https://github.com/nvm-sh)
