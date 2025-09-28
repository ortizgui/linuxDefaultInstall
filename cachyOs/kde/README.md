# Fix Cedilha on US Intl Keyboard (Linux/X11) + Post Install Tools

Este guia reúne duas partes:
1. Script para corrigir o uso do cedilha no layout **US International (dead keys)**.
2. Comandos de pós-instalação usados em sistemas baseados no Arch (CachyOS).

--------------------------------------------------------------------------------
📌 O problema do teclado

Por padrão, no layout **English (US, intl., with dead keys)**:
- ' + e → é (ok)
- ' + c → ć (errado para português)

Isso acontece porque o arquivo global de composição do X11 (/usr/share/X11/locale/.../Compose) segue regras internacionais (Polonês, Croata, etc.) e não mapeia ' + c para ç.

--------------------------------------------------------------------------------
✅ A solução com Python

O X11 permite sobrescrever apenas as combinações desejadas criando o arquivo ~/.XCompose no diretório do usuário.

O script em Python (`fix_compose.py`) automatiza:

1. Criação (ou substituição) do arquivo ~/.XCompose com as regras corretas:
   include "%L"

   <dead_acute> <c> : "ç" U00E7
   <dead_acute> <C> : "Ç" U00C7

2. Configuração da variável de ambiente XCOMPOSEFILE=$HOME/.XCompose nos arquivos de shell (~/.profile, ~/.bash_profile, ~/.zprofile, ~/.zshrc).

3. Backup do arquivo existente se já houver alterações manuais.

▶️ Uso do script:
   python3 fix_compose.py

Reinicie a sessão gráfica (logout/login ou reinicie o KDE/GNOME).

--------------------------------------------------------------------------------
🔧 Pós-instalação de pacotes úteis

Além da correção do teclado, os seguintes comandos foram usados:

1. `sudo pacman -S piper libratbag`
   - **piper**: interface gráfica para configurar mouses gamers Logitech e outros suportados.
   - **libratbag**: daemon que fornece suporte para configuração de periféricos (como DPI, macros e iluminação).

2. `paru -S openrgb-git`
   - **paru**: helper para o AUR (Arch User Repository).
   - **openrgb-git**: versão de desenvolvimento do OpenRGB, permite controlar a iluminação RGB de placas-mãe, memórias, water coolers, fans, etc.

3. `sudo pacman -Syu steam`
   - **-Syu**: sincroniza pacotes (-S), atualiza lista de repositórios (-y) e aplica atualizações (-u).
   - **steam**: instala o cliente da Steam para jogos no Linux.

--------------------------------------------------------------------------------
🔄 Reversão

Para desfazer o ajuste do teclado:
- Apague ~/.XCompose (ou restaure o backup .XCompose.bak).
- Remova a linha export XCOMPOSEFILE="$HOME/.XCompose" dos arquivos de shell.

Para remover pacotes instalados:
- `sudo pacman -Rns pacote` (remove pacote e dependências não usadas).
- `paru -Rns pacote` (caso o pacote venha do AUR).

--------------------------------------------------------------------------------
📝 Notas

- Os ajustes do teclado são locais ao usuário, não ao sistema todo.
- Os pacotes adicionais são opcionais, mas úteis para jogos e personalização.
- Em ambientes Wayland, o ajuste do XCompose continua funcionando para apps baseados em X11.

--------------------------------------------------------------------------------
🎯 Motivo do Script e dos Comandos

- O script existe para evitar ter que corrigir manualmente o cedilha após cada formatação.
- Os comandos de pós-instalação trazem suporte essencial para jogos (Steam), configuração de periféricos (Piper + libratbag) e personalização de iluminação RGB (OpenRGB).
