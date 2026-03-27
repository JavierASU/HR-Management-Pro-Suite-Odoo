---
name: git-flow
description: Ayuda con el flujo git del proyecto (ramas, commits, PRs) según AGENTS.md
user_invocable: true
---

# Git Flow — HR Management Pro

Gestiona el flujo git siguiendo las convenciones de AGENTS.md.

## Instrucciones

### Formato de commits:
```
[hr_management_pro] TIPO: Resumen breve (#issue)
```

Tipos válidos:
- `FEAT` — Nueva funcionalidad
- `FIX` — Corrección de bug
- `REFACTOR` — Refactorización sin cambio funcional
- `STYLE` — Formato, lint, sin cambio de lógica
- `TEST` — Agregar o modificar tests
- `DOCS` — Documentación
- `SECURITY` — Cambios de seguridad/permisos
- `UI` — Cambios en vistas/CSS

### Flujo de ramas:
- `main` — Rama estable
- `feature/<nombre>` — Nueva funcionalidad
- `fix/<nombre>` — Corrección
- `refactor/<nombre>` — Refactorización

### Acciones disponibles:
1. Si el usuario pide crear una rama: `git checkout -b <tipo>/<nombre>`
2. Si pide hacer commit: seguir formato estricto
3. Si pide PR: usar `gh pr create` con template
4. Si pide revisar estado: `git status`, `git log --oneline -10`

Siempre confirmar con el usuario antes de push o acciones destructivas.
