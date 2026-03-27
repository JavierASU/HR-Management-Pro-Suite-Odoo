---
name: gen-tests
description: Genera tests unitarios para los modelos y wizards del módulo
user_invocable: true
---

# Generador de Tests Unitarios para Odoo 17

Genera tests completos para el módulo `hr_management_pro` siguiendo las mejores prácticas de Odoo y AGENTS.md.

## Instrucciones

1. Lee todos los modelos en `models/` y wizards en `wizard/` del módulo.

2. Crea el directorio `tests/` si no existe, con su `__init__.py`.

3. Genera tests usando `TransactionCase` o `SavepointCase` cubriendo:

   **Para `hr.internal.request`:**
   - Creación de request con secuencia automática (REQ-XXXXX)
   - Flujo completo: draft → submitted → manager_approved → hr_approved
   - Flujo de rechazo: draft → submitted → rejected
   - Validaciones de estado (no saltar pasos)
   - Permisos por grupo (user, manager, admin)

   **Para extensión `hr.employee`:**
   - Campos nuevos: seniority_level, contract_type, work_modality, performance_score
   - Campo computed: leave_balance

   **Para wizard `hr.internal.request.mass.approve`:**
   - Aprobación masiva como manager
   - Aprobación masiva como HR
   - Validación de estados antes de aprobar

4. Estructura de cada test file:
   ```python
   from odoo.tests.common import TransactionCase
   from odoo.exceptions import UserError, ValidationError

   class TestHrInternalRequest(TransactionCase):
       @classmethod
       def setUpClass(cls):
           super().setUpClass()
           # Setup de datos de prueba

       def test_create_request(self):
           """Test request creation with auto-sequence."""
           ...
   ```

5. Registra los tests en `tests/__init__.py` y verifica que `__init__.py` raíz importe `tests`.

6. Objetivo: cobertura >70% de la lógica de negocio.
