---
layout: default
title: "📈 Graphing (Monitoramento Web)"
parent: "🛠️ Manutenção"
nav_order: 8
last_modified_date: 2026-06-10 19:55
---

# 📈 Guia: Graphing (Monitoramento Web)

O **Graphing** permite que você visualize o histórico de consumo de tráfego, CPU e Memória através de uma interface web simples, sem precisar de sistemas externos como o Zabbix.

* * * * *

**Como configurar:**

1.  **Habilitar Gráficos de Interface:**

    *   Vá em **Tools ➔ Graphing**.

    *   Na aba **Interface Rules**, clique no **+**.

    *   Em **Interface**, selecione a que deseja monitorar (ex: `ether1` ou `all`).

    *   Em **Allow Address**, você pode restringir quem vê os gráficos para um IP específico (ex: `10.220.0.100/32`) ou para uma faixa de rede (ex: `10.220.0.0/24`).
   
    *   **Store on Disks:** Marque apenas se desejar salvar os dados no armazenamento físico (`não recomendado para memórias Flash simples para evitar desgaste`).

2.  **Habilitar Gráficos de Recursos (CPU/RAM/Disco):**

    *   Na mesma janela, vá na aba **Resource Rules**.

    *   Clique no **+** e apenas dê **OK** (isso começará a monitorar CPU e Memória).

3.  **Como visualizar:**

    *   Abra o seu navegador e digite o `IP` da sua `RB` seguido de `/graphs` (Ex: `http://10.220.0.1/graphs`).

{: .important }
> Se você alterou a porta padrão do serviço **WWW** (em [**IP ➔ Services**](https://soarespaullo.github.io/mikrotik/docs/seguranca/bloqueio-servicos/){: target="_blank" }), você deve incluí-la no endereço de acesso.

*   **Porta padrão (80):** `http://10.220.0.1/graphs`

*   **Porta personalizada (ex: 8080):** `http://10.220.0.1:8080/graphs`

{: .note } 
> Certifique-se de que o serviço `WWW` está habilitado, caso contrário os gráficos não carregarão.
>
> Os gráficos são salvos na `RAM` por padrão. Se a `RB` reiniciar, o histórico é limpo. Se quiser salvar no disco, marque a opção **Store on Disks**.