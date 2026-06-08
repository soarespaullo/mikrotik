---
layout: default
title: ⚖️ Load Balance
parent: 📡 Redes & Links
nav_order: 3
---

# ⚖️ Guia: Load Balance PCC (Soma de Links)
{: .no_toc }

Este tutorial foca em um cenário com 2 Links de internet. O objetivo é distribuir as conexões de forma que a carga seja dividida igualmente entre os dois gateways.

---

## 🛠️ 1. Marcação de Conexões (Mangle)

O segredo do PCC está no Mangle. Precisamos identificar o que entra por cada link para que a resposta saia pelo mesmo link.

### Passo 1: Aceitar tráfego local
Antes de balancear, precisamos dizer ao roteador para não balancear o que é rede interna.
1. Vá em **IP** → **Firewall** → **Mangle**.
2. Clique em **+**.
3. **Chain:** `prerouting` **Dst. Address:** `10.220.0.0/24` (Sua rede local).
4. **Action:** `accept`.

### Passo 2: Marcar conexões de entrada (Input)
Isso garante que, se você acessar o roteador por fora via Link 1, ele responda pelo Link 1.
1. Clique em **+**.
2. **Chain:** `input` **In. Interface:** `ether1-link1`.
3. **Action:** `mark connection` **New Connection Mark:** `Link1_Conn`.
4. **Repita para o Link 2:**
   * **Chain:** `input` **In. Interface:** `ether2-link2`.
   * **Action:** `mark connection` **New Connection Mark:** `Link2_Conn`.

### Passo 3: Classificador PCC (O coração do balanceamento)
Aqui dividimos o tráfego em duas partes (conforme o número de links).
1. Clique em **+**.
2. **Chain:** `prerouting` **In. Interface:** `bridge-local` (sua LAN).
3. **Advanced** → **Per Connection Classifier:** `both addresses and ports` `2` `0`.
4. **Action:** `mark connection` **New Connection Mark:** `Link1_Conn`.
5. **Clique em + para a segunda parte:**
   * **Chain:** `prerouting` **In. Interface:** `bridge-local`.
   * **Advanced** → **Per Connection Classifier:** `both addresses and ports` `2` `1`.
   * **Action:** `mark connection`  **New Connection Mark:** `Link2_Conn`.

### Passo 4: Marcar as Rotas (Routing Mark)
Para cada conexão marcada (`Link1_Conn` e `Link2_Conn`), crie uma regra de **Action: mark routing**.
* **New Routing Mark:** `Para_Link1` (e `Para_Link2` no segundo).
* **Passthrough:** Marcado.

---

## 🧭 2. Configurando as Rotas (Routes)

Agora que os pacotes estão "etiquetados", vamos dizer para onde eles devem ir.
1. Vá em **IP** → **Routes** e clique em **+**.
2. **Gateway:** IP ou Interface do Link 1.
3. **Routing Mark:** `Para_Link1`.
4. **Clique em + para o Link 2:**
   * **Gateway:** IP ou Interface do Link 2.
   * **Routing Mark:** `Para_Link2`.

{: .important }
> **Importante:** Você também deve manter as rotas padrão (sem Routing Mark) com distâncias diferentes para servir de failover caso o PCC falhe.

---

## 📈 3. Visualizando o Funcionamento

Para verificar se está funcionando:
1. Vá em **IP** → **Firewall** → **Mangle**.
2. Observe a coluna **Bytes** e **Packets**. Se ambas as regras de PCC (2/0 e 2/1) estiverem contando tráfego simultaneamente, o balanceamento está ativo.

---

## ⚠️ Observações Cruciais

{: .warning }
> **Bancos e Sites Seguros:** Alguns sites caem se você mudar de IP no meio da sessão. O PCC com `both addresses and ports` é o mais equilibrado, mas se tiver problemas com bancos, mude o classificador para `src-address`.

{: .note }
> **Velocidades Diferentes:** Se o Link 1 tem 100MB e o Link 2 tem 50MB, você deve criar 3 marcações (3/0, 3/1 para o Link 1 e 3/2 para o Link 2). Isso cria uma proporção de 2:1.

{: .important }
> **NAT:** Não esqueça de ter as regras de **masquerade** para ambas as interfaces WAN em **IP** → **Firewall** → **NAT**.

{: .tip }
> O **Load Balance** PCC não "soma" um único download (como um vídeo no YouTube), mas permite que um usuário baixe um vídeo pelo Link 1 enquanto outro usuário joga pelo Link 2, otimizando o uso total da banda.
