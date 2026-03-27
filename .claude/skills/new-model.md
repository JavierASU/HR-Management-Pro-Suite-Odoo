---
name: new-model
description: Genera el scaffold completo para un nuevo modelo Odoo (Python + XML + seguridad)
user_invocable: true
---

# Scaffold de Nuevo Modelo Odoo 17

Genera todos los archivos necesarios para un nuevo modelo siguiendo las convenciones del proyecto.

## Instrucciones

El usuario debe proporcionar: nombre del modelo (ej: `hr.training.record`) y descripción.

1. **Modelo Python** (`models/<model_name>.py`):
   ```python
   from odoo import models, fields, api
   from odoo.exceptions import UserError, ValidationError

   class HrTrainingRecord(models.Model):
       _name = 'hr.training.record'
       _description = 'Training Record'
       _inherit = ['mail.thread', 'mail.activity.mixin']
       _order = 'create_date desc'

       name = fields.Char(string='Reference', readonly=True, copy=False, default='New')
       # ... campos según requerimiento
       state = fields.Selection([...], default='draft', tracking=True)
   ```

2. **Registrar** en `models/__init__.py`

3. **Vistas XML** (`views/<model_name>_view.xml`):
   - Tree view con decoración por estado
   - Form view con statusbar, botones, chatter
   - Kanban view con badges
   - Search view con filtros útiles

4. **Seguridad**:
   - Agregar líneas a `security/ir.model.access.csv` para los 3 grupos
   - Sugerir record rules si aplica

5. **Menú**: Agregar entrada en `views/menus.xml`

6. **Manifest**: Actualizar `__manifest__.py` con nuevos data files

7. **Secuencia** (si aplica): Agregar en `data/sequence.xml`

8. Seguir estrictamente las convenciones de AGENTS.md.
