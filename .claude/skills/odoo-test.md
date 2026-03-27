---
name: odoo-test
description: Ejecuta los tests unitarios del módulo hr_management_pro con odoo-bin
user_invocable: true
---

# Odoo Test — Ejecución de Tests

Ejecuta los tests del módulo `hr_management_pro` usando odoo-bin.

## Instrucciones

1. Verifica que exista el directorio `tests/` y archivos de test en el módulo.

2. Si existen tests, ejecuta:
   ```bash
   cd /c/odoo-project
   python odoo-bin --addons-path=addons --config=odoo.conf \
     --test-enable --stop-after-init --log-level=test \
     --test-tags=hr_management_pro 2>&1
   ```

3. Si NO existen tests, informa al usuario y ofrece generarlos con `/gen-tests`.

4. Analiza la salida y presenta:
   - Tests ejecutados vs pasados vs fallidos
   - Detalle de cada fallo con stack trace resumido
   - Sugerencias de corrección

5. Si el usuario proporciona argumentos adicionales (ej: `/odoo-test --test-tags=specific_test`), úsalos para filtrar.
