---
layout: default
title: "🐕 Watchdog (Auto-Reboot)"
parent: "🛠️ Manutenção"
nav_order: 9
---

# 🐕 Guia: Watchdog (Auto-Reboot)

O **Watchdog** é um recurso de segurança que força a reinicialização do `MikroTik` se o processador travar ou se a RB perder a conexão com a internet. Ele garante que o dispositivo não fique "`congelado`" ou `inacessível`, sendo essencial para manter a disponibilidade da rede.

---

**Como configurar:**

1.  **Acessar o Menu:**

    *   No Winbox, vá em **System** → **Watchdog**.

2.  **Habilitar o Temporizador de Hardware:**

    *   Na aba **Watchdog**, certifique-se de que a opção **Watchdog Timer** esteja marcada.

    *   **Funcionamento:** Esta função monitora o processador. Se o software travar, o hardware forçará o reboot.

3.  **Configurar Monitoramento de Conectividade:**

    *   Clique na aba **Ping Watchdog**.

    *   No campo **Watch Address**, insira um IP externo estável (ex: `8.8.8.8`).

    *   **Funcionamento:** Se a RB parar de receber resposta de ping deste IP, ela reiniciará automaticamente.

4.  **Ajustar o Tempo de Espera Inicial:**

    *   Ainda na aba **Ping Watchdog**, defina o **Ping Start After Boot** (recomendado: `00:05:00`).