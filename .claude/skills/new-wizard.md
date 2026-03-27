---
name: new-wizard
description: Genera un wizard (TransientModel) completo con vista y acción
user_invocable: true
---

# Scaffold de Nuevo Wizard Odoo 17

Genera un wizard completo (TransientModel + vista + acción) para operaciones masivas o formularios intermedios.

## Instrucciones

El usuario debe proporcionar: nombre del wizard y su propósito.

1. **Modelo TransientModel** (`wizard/<wizard_name>.py`):
   ```python
   from odoo import models, fields, api
   from odoo.exceptions import UserError

   class HrWizardName(models.TransientModel):
       _name = 'hr.wizard.name'
       _description = 'Wizard Description'

       # Campos del wizard
       # Método action principal
       def action_confirm(self):
           self.ensure_one()
           # Lógica...
           return {'type': 'ir.actions.act_window_close'}
   ```

2. **Vista XML** (`wizard/<wizard_name>_view.xml`):
   - Form view compacta
   - Acción `ir.actions.act_window` con `target='new'`
   - Botones Confirmar/Cancelar

3. **Registrar** en `wizard/__init__.py`

4. **Seguridad**: Agregar permisos en `ir.model.access.csv` (al menos para manager y admin)

5. **Manifest**: Actualizar `__manifest__.py`

6. Seguir el patrón del wizard existente (`hr_internal_request_mass_approve`).
