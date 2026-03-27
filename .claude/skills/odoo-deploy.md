---
name: odoo-deploy
description: Verifica que el módulo esté listo para instalar/actualizar en Odoo
user_invocable: true
---

# Verificación de Despliegue — HR Management Pro

Verifica que el módulo esté listo para ser instalado o actualizado en una instancia Odoo.

## Instrucciones

1. **Verificar __manifest__.py**:
   - Todos los archivos XML/CSV listados en `data` existen
   - Todos los assets listados existen
   - Las dependencias son correctas (`hr`, `mail`, `web`)
   - La versión sigue el formato `17.0.X.Y.Z`

2. **Verificar estructura de archivos**:
   - Todos los archivos `.py` importados en `__init__.py` existen
   - Todos los archivos XML referenciados en manifest existen
   - No hay archivos huérfanos (Python no importado, XML no registrado)

3. **Verificar XML**:
   - Sintaxis XML válida en todos los archivos
   - IDs de registros únicos (no duplicados)
   - Referencias `ref()` apuntan a IDs que existen

4. **Verificar Python**:
   - Imports válidos (no módulos faltantes)
   - Clases con `_name` y `_description`
   - No hay syntax errors

5. **Generar comando de instalación/actualización**:
   ```bash
   # Instalación limpia
   odoo-bin --addons-path=addons --config=odoo.conf -i hr_management_pro --stop-after-init

   # Actualización
   odoo-bin --addons-path=addons --config=odoo.conf -u hr_management_pro --stop-after-init
   ```

6. Presentar reporte de readiness con estado GO/NO-GO.
