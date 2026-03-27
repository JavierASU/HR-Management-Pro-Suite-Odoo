---
name: validate-views
description: Valida coherencia entre modelos Python y vistas XML del módulo
user_invocable: true
---

# Validación de Vistas XML — HR Management Pro

Verifica que las vistas XML sean coherentes con los modelos Python.

## Instrucciones

1. Lee todos los modelos Python en `models/` y `wizard/` para obtener:
   - Campos definidos (nombre, tipo, atributos)
   - Estados del workflow (selection fields con state)
   - Métodos action definidos

2. Lee todas las vistas XML en `views/`, `wizard/`, y `reports/`.

3. Verifica:

   **Campos:**
   - Todo `<field name="X">` en XML corresponde a un campo existente en el modelo
   - Los campos computed tienen `readonly="1"` en la vista si no son editables
   - Los campos required en Python tienen `required="1"` en la vista o viceversa

   **Botones y estados:**
   - Todo `<button name="action_X">` tiene un método correspondiente en Python
   - Los atributos `states=` o `invisible=` son coherentes con los estados definidos
   - Los botones de workflow respetan la secuencia lógica

   **Herencia:**
   - Los `inherit_id` referencian vistas que existen (nativas o del módulo)
   - Los xpath expressions son válidos

   **Menús:**
   - Cada menú tiene una acción válida
   - Las acciones referencian modelos existentes
   - Los grupos en menús corresponden a grupos definidos

   **Reportes QWeb:**
   - Los campos usados en templates existen en el modelo
   - Los reportes están registrados en `__manifest__.py`

4. Presenta resultados organizados por archivo/vista.
