---
name: odoo-lint
description: Ejecuta linters (flake8, black, isort) sobre el módulo y reporta errores de estilo
user_invocable: true
---

# Odoo Lint — Verificación de Calidad de Código

Ejecuta las herramientas de lint y formato configuradas para el módulo `hr_management_pro` según las pautas de AGENTS.md.

## Instrucciones

1. Ejecuta los siguientes comandos desde la raíz del módulo y captura su salida:
   ```bash
   cd /c/odoo-project/addons/hr_management_pro
   flake8 --max-line-length=120 --exclude=__pycache__,.git . 2>&1 || true
   black --check --diff . 2>&1 || true
   isort --check-only --diff . 2>&1 || true
   ```

2. Analiza los resultados y presenta un resumen con:
   - Número total de errores/warnings por herramienta
   - Los problemas más críticos agrupados por tipo
   - Sugerencias de corrección para los más frecuentes

3. Si el usuario pide que corrijas los errores, ejecuta:
   ```bash
   black .
   isort .
   ```
   Y luego vuelve a correr flake8 para mostrar lo que queda pendiente.

4. Sigue las convenciones de AGENTS.md:
   - 4 espacios de indentación
   - snake_case para métodos/campos
   - CamelCase para clases
   - Imports ordenados: estándar > terceros > odoo > locales
