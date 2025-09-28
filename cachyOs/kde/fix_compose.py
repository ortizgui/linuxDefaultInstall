#!/usr/bin/env python3
import os
from pathlib import Path

HOME = Path.home()
compose_path = HOME / ".XCompose"
backup_path = HOME / ".XCompose.bak"

compose_content = """include "%L"

<dead_acute> <c> : "ç" U00E7
<dead_acute> <C> : "Ç" U00C7
"""

shell_files = [
    HOME / ".profile",
    HOME / ".bash_profile",
    HOME / ".zprofile",
    HOME / ".zshrc",
]

export_line = 'export XCOMPOSEFILE="$HOME/.XCompose"'

def ensure_compose():
    if compose_path.exists():
        # Faz backup só se conteúdo for diferente
        try:
            existing = compose_path.read_text(encoding="utf-8")
        except Exception:
            existing = ""
        if existing.strip() != compose_content.strip():
            compose_path.replace(backup_path)
            print(f"[i] Backup criado: {backup_path}")
    compose_path.write_text(compose_content, encoding="utf-8")
    print(f"[✓] Escrevi {compose_path}")

def ensure_export():
    for f in shell_files:
        try:
            if f.exists():
                text = f.read_text(encoding="utf-8")
            else:
                text = ""
            if export_line not in text:
                with f.open("a", encoding="utf-8") as fh:
                    if text and not text.endswith("\n"):
                        fh.write("\n")
                    fh.write(export_line + "\n")
                print(f"[✓] Adicionado em {f}")
            else:
                print(f"[=] Já presente em {f}")
        except Exception as e:
            print(f"[!] Não consegui atualizar {f}: {e}")

def main():
    ensure_compose()
    ensure_export()
    print("\nPronto! Faça logout/login (ou reinicie o KDE) para aplicar.")

if __name__ == "__main__":
    main()
