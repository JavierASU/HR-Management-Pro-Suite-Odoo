---
name: add-field
description: Agrega un campo nuevo a un modelo existente con su vista y migración
user_invocable: true
---

# Agregar Campo a Modelo Existente

Agrega un campo nuevo a un modelo del módulo con todas las actualizaciones necesarias.

## Instrucciones

El usuario debe proporcionar: modelo destino, nombre del campo, tipo y descripción.

1. **Agregar campo en Python**:
   - Añadir la definición del campo en el modelo correspondiente
   - Si es computed, crear el método `_compute_<field>`
   - Si necesita onchange, crear `_onchange_<field>`
   - Respetar el orden: campos básicos, related, computed

2. **Actualizar vistas XML**:
   - Agregar el campo en la vista form (en el group lógico correcto)
   - Agregar en tree view si es relevante para listados
   - Agregar en search view si es filtrable
   - Agregar en kanban si es visible en tarjetas

3. **Si el campo es tracking**:
   - Agregar `tracking=True` para integración con mail.thread

4. **Si necesita migración** (módulo ya instalado):
   - Sugerir script de migración pre/post en `migrations/`

5. Seguir convenciones de AGENTS.md para naming y estilo.
