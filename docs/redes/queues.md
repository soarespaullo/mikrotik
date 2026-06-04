---
layout: default
title: 🚦 Controle de Banda (Queues)
parent: 📡 Redes & Links
nav_order: 4
---

# 🚦 Guia: Controle de Banda (Queues)
{: .no_toc }

Existem duas formas principais de controlar a velocidade: as **Simple Queues** (para limites fixos por IP) e o **PCQ** (para dividir a internet de forma automática e inteligente entre todos).

---

## 📍 1. Simple Queues (Limite por Dispositivo)

Use este método quando quiser definir um teto máximo de velocidade para um dispositivo específico (ex: uma TV ou um PC de download).

1. No Winbox, vá em **Queues** e na aba **Simple Queues**, clique em **+**.
2. Na aba **General**:
    * **Name:** Nome do dispositivo (ex: `PC-Visitante`).
    * **Target:** O endereço IP do dispositivo (ex: `10.220.0.150`).
3. Em **Max Limit**:
    * **Upload:** Defina o limite de subida (ex: `5M`).
    * **Download:** Defina o limite de descida (ex: `10M`).
4. Clique em **OK**.

---

## ⚖️ 2. PCQ: Divisão Igualitária Automática

O **PCQ** (Per Connection Queuing) é a melhor forma de gerenciar redes com muitos usuários. Ele divide o link total igualmente entre todos que estão tentando navegar ao mesmo tempo.

### Passo 1: Criar os tipos de fila PCQ
1. Vá na aba **Queue Types** e clique em **+**.
2. **Type Name:** `PCQ_Download` **Kind:** `pcq`.
    * Em **Settings**, marque apenas a caixa **Dst. Address**.
3. Clique em **+** novamente.
4. **Type Name:** `PCQ_Upload` **Kind:** `pcq`.
    * Em **Settings**, marque apenas a caixa **Src. Address**.

### Passo 2: Aplicar na Rede Local
1. Volte na aba **Simple Queues** e clique em **+**.
2. **Name:** `Controle-Geral-Rede`.
3. **Target:** Digite a sua rede inteira: `10.220.0.0/24`.
4. Na aba **Advanced**:
    * **Queue Type Upload:** Selecione `PCQ_Upload`.
    * **Queue Type Download:** Selecione `PCQ_Download`.
5. Clique em **OK**.

---

## 🚀 3. Priorização de Tráfego (Limit At)

Se você tem um serviço que não pode travar (**como câmeras de segurança ou um servidor**), você pode usar o campo **Limit At** dentro de uma Simple Queue.

* **Max Limit:** É o máximo que ele atinge se o link estiver sobrando.
* **Limit At (Garantia):** É a velocidade que o MikroTik vai "reservar" para aquele IP, mesmo que todos os outros estejam baixando arquivos pesados.

---

## 📊 4. Monitorando o Consumo

Na janela de Simple Queues, observe as cores das ícones:
   * 🟢 **Verde:** Uso de banda baixo (0-50%).
   * 🟡 **Amarelo:** Uso de banda moderado (50-75%).
   * 🔴 **Vermelho:** O usuário atingiu o limite máximo definido (75-100%).

---

{: .important }
> **Atenção à Ordem:** O MikroTik processa as Simple Queues de cima para baixo. Se você tem uma regra para a rede toda (`10.220.0.0/24`), as regras de IPs individuais devem ficar **acima** dela para funcionarem corretamente.
