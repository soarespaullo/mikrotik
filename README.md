# 🛰️ Wiki Técnica MikroTik

[![GitHub Pages](https://img.shields.io/badge/Docs-Live-green?style=flat-square)](https://soarespaullo.github.io/MikroTik)
[![RouterOS](https://img.shields.io/badge/RouterOS-v7.x-blue?style=flat-square)](https://mikrotik.com)
[![License](https://img.shields.io/badge/License-MIT-orange?style=flat-square)](LICENSE)


Este repositório centraliza a documentação, rotinas de automação e scripts para dispositivos MikroTik (**RouterOS v7**). Todo o conteúdo deste repositório é compilado automaticamente em uma Wiki interativa utilizando **Jekyll** e o tema **Just the Docs**.

🌐 **Acesse a Wiki Oficial:** [https://soarespaullo.github.io/MikroTik](https://soarespaullo.github.io/MikroTik)

---

## 📂 Estrutura do Projeto

O repositório está estruturado como um projeto Jekyll pronto para deploy no GitHub Pages:

* `docs/` — Contém todas as páginas de documentação técnica organizadas por categorias (Conectividade, Segurança, Manutenção).
* `assets/` — Imagens, logotipos e arquivos estáticos da Wiki.
* `_config.yml` — Arquivo principal de configuração do layout, identidade e comportamento do tema.
* `.github/workflows/` — Automação de CI/CD (GitHub Actions) que compila e publica o site automaticamente a cada `git push`.

---

## 🛠️ Conteúdos em Destaque (Na Wiki)

Acesse os guias formatados com sumários táteis, blocos de notas e destaque de código diretamente na Wiki:

* 🔒 **Segurança & Acesso:** Configurações de Firewall Básico, proteção de gerenciamento com Port Knocking, VPN WireGuard e controle de Neighbor Discovery.
* 🛠️ **Manutenção do Sistema:** Scripts de Backup (`.rsc` e `.backup`), análise de logs, monitoramento com Netwatch/Watchdog e sincronização de hora (NTP).
* 🤖 **Automação & Alertas:** Integração com a API do Telegram para notificações de queda/restabelecimento de links PPPoE em tempo real.

---

## 💻 Como Rodar este Projeto Localmente

Se você quiser clonar este repositório para testar modificações no layout ou adicionar documentações no seu ambiente local (Arch Linux ou similar), siga o procedimento:

1. **Requisitos Prévios:** Certifique-se de ter o Ruby e o Bundler instalados no sistema.
2. **Instalar Dependências:**
   ```bash
   bundle install
