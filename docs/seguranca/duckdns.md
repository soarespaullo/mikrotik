---
layout: default
title: "🦆 DNS Dinâmico (DuckDNS)"
parent: "🔒 Segurança & Acesso"
nav_order: 11
last_modified_date: 2026-06-12 23:13
---

# 🦆 Guia: DNS Dinâmico com DuckDNS
{: .no_toc }

O **DuckDNS** é um serviço gratuito que permite associar um nome fixo ao seu IP dinâmico. Este script é robusto pois salva o status em um arquivo dentro da memória do MikroTik.

## 🛠️ 1. Preparação no Portal DuckDNS

1. Acesse o site oficial: [**duckdns.org**](https://www.duckdns.org/){: target="_blank" }.

2. Realize o Login: No topo da página, escolha o provedor de sua preferência para acessar o painel (você pode utilizar sua conta `Google`, `GitHub`, `Twitter/X`, `Reddit` ou `Persona`).

3. No campo `sub domain`, escolha um nome para identificar sua rede (ex: minha-empresa) e clique em `add domain`.

4. Localize e copie o seu Token (*um código alfanumérico único que aparece no topo da página*). ATENÇÃO: **Não compartilhe este código**, pois ele é a "*chave*" que permite ao `MikroTik` atualizar seu `IP`.

{: .note }
> O `DuckDNS` não utiliza usuário e senha comuns; ele usa o sistema de `OAuth`. Isso significa que você sempre entrará clicando no ícone da rede social que escolheu no primeiro acesso.

---

## 📜 2. Script de Atualização

Este script monitora o `IP` e atualiza o servidor apenas se houver mudança, registrando o sucesso ou erro no log.

**Passo a passo:**

1.  Vá em **System ➔ Scripts** e crie um novo chamado `atualizar-duckdns`.

2.  Em **Policies**, marque: `read, write, test, policy`.

3.  No campo **Source**, Obtenha o código fonte através dos botões abaixo e cole neste campo.

### 📥 Obtenção do Script e Implantação

Escolha a forma mais adequada para obter o código-fonte ou inspecionar o arquivo direto no repositório:

[**📥 Baixar Arquivo (.rsc)**](https://raw.githubusercontent.com/soarespaullo/mikrotik/main/scripts/Check-DuckDNS.rsc){: .btn .btn-blue target="_blank" }
[**👁️ Visualizar Código no GitHub**](https://github.com/soarespaullo/mikrotik/blob/main/scripts/Check-DuckDNS.rsc){: .btn .btn-outline target="_blank" }

---

## ⏰ 3. Agendamento (Scheduler)

Para automação total, crie o agendamento:

1.  Acesse **System ➔ Scheduler** e clique no **+**.

2.  **Name:** `Check-DuckDNS`.

3.  **Interval:** `00:05:00` (5 minutos).

4.  **On Event:** `atualizar-duckdns`.

{: .important }
> Na aba **Policy**, certifique-se de marcar **read, write, test e policy**. Sem isso, o agendador não terá permissão para ler o arquivo `ipstore.txt` ou usar o comando `fetch`.

---

## 🔍 Como testar?

Para garantir que o script está rodando e se comunicando com o `DuckDNS`, siga esta ordem:

1.  **Execute o Script:** Vá em **System ➔ Scripts**, selecione o `atualizar-duckdns` e clique no botão **Run Script**.
    
2.  **Verifique os Logs:** Acesse o menu **Log** na lateral esquerda.
    
    *   Se o IP for novo, você verá: `DuckDNS: Tentando atualizar...` seguido de `DuckDNS: Atualizado com sucesso!`.
        
3.  **Confira os Arquivos:** Vá no menu **Files**. Você deverá ver dois novos arquivos na lista:
    
    *   `ipstore.txt`: Contém o IP que o script salvou para comparação futura.
        
    *   `duckdns-result.txt`: Contém a resposta do site DuckDNS (deve estar escrito **OK** dentro dele).
        
4.  **Teste Externo:** Desconecte seu celular do Wi-Fi e tente acessar seu domínio (ex: `seu-subdominio.duckdns.org`) pelo navegador ou Winbox.

---

## 💡 Por que este script é diferenciado?

*   **Persistência:** Ao contrário de variáveis globais que somem ao reiniciar, este script usa o arquivo `ipstore.txt`. Se a energia cair, ao voltar, ele ainda saberá qual era o IP antigo.

*   **Feedback Real:** Ele lê o conteúdo retornado pelo site (`OK` ou `KO`) e avisa exatamente se a atualização funcionou no seu Log.