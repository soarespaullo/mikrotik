---
layout: default
title: "🕵️ RoMON (Acesso Indireto)"
parent: "🛠️ Manutenção"
nav_order: 7
---

# 🕵️ Guia: Gerenciamento via RoMON

O RoMON cria uma rede de gerenciamento independente do protocolo IP. Com ele ativado, você consegue "enxergar" e acessar via Winbox qualquer MikroTik da sua rede que também tenha o RoMON ativo, mesmo que ele não tenha IP configurado ou esteja em outra sub-rede.

---

## 🪜 1. Ativando o RoMON

Você deve ativar o RoMON em **todos** os roteadores da sua rede que deseja gerenciar.

1.  No Winbox, vá em **Tools → RoMON**.

2.  Marque a caixa **Enabled**.

3.  (Opcional) **Secrets:** Clique em **+** e defina uma senha global para a rede RoMON. Isso evita que vizinhos ou pessoas não autorizadas vejam seus equipamentos.

4.  Clique em **OK**.

## 🔗 2. Acessando via RoMON

Para acessar um roteador remoto através de um roteador vizinho:

1.  Abra o **Winbox** (não precisa estar logado em nenhum roteador).

2.  Clique no botão **Connect To RoMON**.

3.  Na aba **Neighbors**, selecione o roteador que está fisicamente ligado ao seu PC e clique em **Connect**.

4.  Agora, o Winbox mudará para o modo RoMON. Clique na aba **RoMON Neighbors**.

5.  Você verá uma lista de todos os MikroTiks da rede. Selecione o que deseja e clique em **Connect**.

{: .note }
> O RoMON é o seu "`salvador`" quando você erra uma configuração de IP ou Firewall e perde o acesso ao roteador. Se o RoMON estiver ativo, você entra por um roteador vizinho e conserta o erro sem precisar de cabo serial ou reset físico.

---

## 🛡️ 3. Configurações de Segurança

Como o RoMON permite "saltar" de um roteador para outro, a segurança é essencial:

*   **Ports:** Na janela do RoMON, você pode definir em quais interfaces o protocolo vai rodar (Aba *Ports*). **Nunca** deixe o RoMON ativo na interface ligada ao modem da operadora (WAN).

*   **ID:** O MikroTik gera um ID baseado no MAC. Não é necessário mudar, mas é bom saber que ele identifica o rádio de forma única na rede.

---

## ❓ Por que usar o RoMON?

*   **Descoberta:** Encontra equipamentos sem IP na rede.

*   **Salto:** Acessa um rádio no topo de uma torre passando por vários outros roteadores no caminho.

*   **Agilidade:** Não precisa criar rotas ou túneis apenas para acessar a gerência de um dispositivo.