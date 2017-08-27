**Acompanhar remotamente via Slack**
-------------

Os ambientes operacionais exigem um maior cuidado e acompanhar os processos é fundamental, já utilizei notificações via SMS, mas nem todas as pessoas tem acesso a um gateway. Mas hoje podemos realizar o acompanhamento através de ferramentas que estão ao alcance das pessoas que desejam. Eu particularmente utilizo o SLACK, possui muitas vantagens, e iremos abordar a partir de agora de formar gradual.

Particularmente acredito que para evitar qualquer crise, é necessário controlar como se estivesse em crise, implementar um plano de ação pós crise, é sempre muito mais traumático. Coletar as informações ao longo do tempo poderá ajudar em tomadas de decisões futuras, e para isso é necessário conhecer bem o passado.

O objetivo do post, é apresentar uma das formas de utilização da ferramenta e sugerir como implementar e utilizar através de sistemas operacionais baseados em Linux com acesso a internet.

Se não tiver a conta acesse diretamente o link: *https://slack.com/*, e seguir todos os passos e responder:

#### **CRIAR CONTA**:

e-mail, nome, colaboradores e nome da empresa.
Uma vez criado, realizado a instalação dos clients *Mobile* e no *Notebook*, enfim... Vamos para o passo da configuração:

#### **OBTER WEBHOOK**:

Com o client, vá até o ícone de engrenagem, no topo e deslocado a direita, com o nome: "***Channel Setting***"

Encontrado vamos lá em: "***Add an App***", após este passo será exibida:

***"Make Slack even better."***
***"All the tools you use for work, in one place."***

No campo de pesquisa, será necessário digitar nesta pesquisa: *Webhooks*, serão apresentados o "***Incoming WebHooks***" e o "***Outgoing WebHooks***", iremos escolher o Incoming WebHooks que trocando em miúdos, significa que o Slack irá receber as notificações via API. Não vou me estender nessa explicação, essa informação pode ser obtida em uma simples pesquisa do Google.

Selecionado a nossa opção: "***Incoming WebHooks***" e após isso "***Add Configuration***", para adicionarmos a configuração.

Será exibida a opção para criarmos um novo canal, escolha a opção: "***create a new channel***", onde poderá ser público ou privado, a principal diferença entre eles é que o privado é necessário um convite para novos membros ingressarem no canal, ai você quem decide o que é melhor. O Slack é dividido por canais para facilitar a comunicação, dessa forma você poderá criar quantos canais forem necessários separados por assuntos, quanto mais canais será mais simples o acompanhamento, uma vez que você poderá ir direto ao ponto.

| Íten                  | - | Significado                               |
| :-------------------- |:-:| :-----------------------------------------|
| ***Name***            | - | Definir o nome do grupo                   |
| ***Purpose***         | - | Uma breve descrição                       | 
| ***Send invites to*** | - | Para enviar os convites aos participantes |


Após isso será apresentada a tela anterior e na listagem dos grupos escolher o que foi criado, escolher "Add Incoming WebHooks integration", feito. Grupo criado.

Anotar a URL do *WebHook*, a que eu utilizei para esta POC, possui este formato:

https://hooks.slack.com/services/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

Existem outras opções para personalizar, como:


| Íten                    | - | Significado                   |
| :-----------------------|:-:| :---------------------------- |
| ***Descriptive Labe"*** | - | Etiqueta de descritiva        |
| ***Customize Name***    | - | Nome Customizado              |
| ***Customize Icon***    | - | Troca Icone                   |
| ***Preview Message***   | - | Exemplo de como esta definido |

> Eu particularmente costumo trocar o ícone, e o nome para o mesmo nome da Descrição, mas fica a critério de cada um.

Feito, realizado a criação do Grupo e do *WebHook*.

```sequence
LINUX (MONITOR)-> SLACK: "Notificação formato JSON"
Note right of SLACK: "Texto contendo a Notificação"
SLACK--> LINUX (MONITOR): ok!
```

Agora é só obter o script sugerido: notificar_slack.sh e seguir as instruções:

#### **PARA UTILIZAR**:

```sh
./notificar_slack.sh \
https://hooks.slack.com/services/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 \
monitorar \
":loudspeaker: *Segue nova mensagem* :arrow_right: Exemplo do corpo de uma mensagem"
