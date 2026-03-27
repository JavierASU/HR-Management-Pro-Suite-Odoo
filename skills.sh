#!/bin/bash
# =============================================================================
# skills.sh — Generador de Skills para HR Management Pro Suite (Odoo 17)
# Ejecutar desde la raíz del módulo:
#   bash skills.sh
# =============================================================================

set -e

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$MODULE_DIR/.claude/skills"

echo "🔧 Creando directorio de skills en: $SKILLS_DIR"
mkdir -p "$SKILLS_DIR"

# =============================================================================
# Skill 1: /odoo-lint — Linter y formato del módulo
# =============================================================================
cat > "$SKILLS_DIR/odoo-lint.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ odoo-lint"

# =============================================================================
# Skill 2: /odoo-test — Ejecutar tests del módulo
# =============================================================================
cat > "$SKILLS_DIR/odoo-test.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ odoo-test"

# =============================================================================
# Skill 3: /gen-tests — Generador de tests unitarios
# =============================================================================
cat > "$SKILLS_DIR/gen-tests.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ gen-tests"

# =============================================================================
# Skill 4: /security-audit — Auditoría de seguridad del módulo
# =============================================================================
cat > "$SKILLS_DIR/security-audit.md" << 'SKILL_EOF'
---
name: security-audit
description: Audita permisos, grupos y reglas de acceso del módulo Odoo
user_invocable: true
---

# Auditoría de Seguridad — HR Management Pro

Realiza una auditoría completa de seguridad del módulo según las pautas de AGENTS.md.

## Instrucciones

1. Lee los siguientes archivos:
   - `security/ir.model.access.csv`
   - `security/security.xml`
   - Todos los modelos en `models/`
   - Todos los wizards en `wizard/`

2. Verifica:

   **Cobertura de modelos:**
   - Cada modelo definido (`_name`) tiene entradas en `ir.model.access.csv`
   - Cada TransientModel (wizard) tiene permisos definidos
   - No hay modelos huérfanos sin permisos

   **Grupos y jerarquía:**
   - Los grupos están correctamente definidos en `security.xml`
   - La jerarquía implied_ids es coherente (user < manager < admin)
   - Los permisos son progresivos (user: read/create, manager: +write, admin: +delete)

   **Validaciones en código:**
   - Los métodos action verifican ownership o permisos antes de escribir
   - No hay `sudo()` innecesarios
   - Las validaciones usan `UserError`/`ValidationError`

   **Record rules:**
   - Verificar si existen reglas de registro (domain-level)
   - Sugerir reglas si faltan (ej: usuarios solo ven sus propias requests)

3. Presenta un reporte con:
   - ✅ Checks que pasan
   - ⚠️ Warnings (mejorables)
   - ❌ Errores críticos
   - Recomendaciones de corrección
SKILL_EOF

echo "  ✅ security-audit"

# =============================================================================
# Skill 5: /validate-views — Validación de vistas XML
# =============================================================================
cat > "$SKILLS_DIR/validate-views.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ validate-views"

# =============================================================================
# Skill 6: /module-checklist — Checklist profesional del módulo
# =============================================================================
cat > "$SKILLS_DIR/module-checklist.md" << 'SKILL_EOF'
---
name: module-checklist
description: Ejecuta el checklist completo de calidad profesional del módulo Odoo
user_invocable: true
---

# Checklist Profesional — HR Management Pro

Evalúa el módulo contra el checklist de calidad definido en AGENTS.md sección 5.

## Instrucciones

1. Realiza una evaluación completa del módulo revisando cada punto:

   - [ ] **Permisos definidos**: Todos los modelos tienen `ir.model.access.csv`
   - [ ] **Campos con tracking**: Campos críticos usan `tracking=True` para mail.thread
   - [ ] **Decoradores correctos**: `@api.depends`, `@api.onchange`, `@api.model_create_multi`
   - [ ] **Tests unitarios**: Existen en `tests/` y cubren flujos principales
   - [ ] **Commits semánticos**: Revisar git log para formato `[modulo] TIPO: Resumen`
   - [ ] **Instalación limpia**: `__manifest__.py` tiene todas las dependencias y data files
   - [ ] **Vistas responsivas**: Formularios con groups, kanban con templates
   - [ ] **Cobertura de pruebas**: Objetivo >70%
   - [ ] **Wizards funcionales**: TransientModel con validaciones
   - [ ] **Seguridad y roles**: Grupos jerárquicos correctos
   - [ ] **Reportes y dashboards**: QWeb templates registrados y funcionales
   - [ ] **Secuencias**: ir.sequence definida y usada en create()
   - [ ] **Mail integration**: mail.thread y mail.activity.mixin correctos
   - [ ] **CSS/Assets**: Registrados en __manifest__.py assets
   - [ ] **README**: Existe y describe el módulo
   - [ ] **AGENTS.md**: Guía de desarrollo actualizada
   - [ ] **No hay archivos template vacíos**: Limpiar stubs sin contenido

2. Para cada punto, marca:
   - ✅ **PASS** — Cumple correctamente
   - ⚠️ **WARN** — Parcialmente, con sugerencia
   - ❌ **FAIL** — No cumple, con instrucción de corrección

3. Calcula un score: (PASS * 1 + WARN * 0.5) / total * 100

4. Presenta el reporte con score final y top 3 acciones prioritarias.
SKILL_EOF

echo "  ✅ module-checklist"

# =============================================================================
# Skill 7: /new-model — Scaffold de nuevo modelo Odoo
# =============================================================================
cat > "$SKILLS_DIR/new-model.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ new-model"

# =============================================================================
# Skill 8: /new-wizard — Scaffold de nuevo wizard
# =============================================================================
cat > "$SKILLS_DIR/new-wizard.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ new-wizard"

# =============================================================================
# Skill 9: /odoo-deploy — Verificar y preparar despliegue
# =============================================================================
cat > "$SKILLS_DIR/odoo-deploy.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ odoo-deploy"

# =============================================================================
# Skill 10: /add-field — Agregar campo a modelo existente
# =============================================================================
cat > "$SKILLS_DIR/add-field.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ add-field"

# =============================================================================
# Skill 11: /git-flow — Gestión de ramas y commits según convención
# =============================================================================
cat > "$SKILLS_DIR/git-flow.md" << 'SKILL_EOF'
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
SKILL_EOF

echo "  ✅ git-flow"

# =============================================================================
# Crear CLAUDE.md del proyecto si no existe
# =============================================================================
if [ ! -f "$MODULE_DIR/.claude/CLAUDE.md" ]; then
cat > "$MODULE_DIR/.claude/CLAUDE.md" << 'CLAUDE_EOF'
# HR Management Pro — Claude Code Config

## Módulo
- Odoo 17.0 Community Edition
- Módulo: `hr_management_pro`
- Ubicación: `/c/odoo-project/addons/hr_management_pro`

## Skills disponibles
- `/odoo-lint` — Linter y formato (flake8, black, isort)
- `/odoo-test` — Ejecutar tests unitarios
- `/gen-tests` — Generar tests unitarios
- `/security-audit` — Auditoría de seguridad
- `/validate-views` — Validar vistas XML vs modelos
- `/module-checklist` — Checklist profesional completo
- `/new-model` — Scaffold de nuevo modelo
- `/new-wizard` — Scaffold de nuevo wizard
- `/odoo-deploy` — Verificar readiness para deploy
- `/add-field` — Agregar campo a modelo existente
- `/git-flow` — Gestión git según convenciones

## Convenciones
- Ver AGENTS.md para guía completa de desarrollo
- Python 3.10+, 4 espacios, snake_case campos/métodos, CamelCase clases
- Commits: `[hr_management_pro] TIPO: Resumen`
- Seguridad: 3 niveles (user, manager, admin)
CLAUDE_EOF
echo "  ✅ CLAUDE.md"
fi

# =============================================================================
# Resumen final
# =============================================================================
echo ""
echo "============================================="
echo "  Skills creadas exitosamente!"
echo "============================================="
echo ""
echo "  📁 Ubicación: $SKILLS_DIR"
echo ""
echo "  Skills disponibles:"
echo "    /odoo-lint        — Linter y formato"
echo "    /odoo-test        — Ejecutar tests"
echo "    /gen-tests        — Generar tests unitarios"
echo "    /security-audit   — Auditoría de seguridad"
echo "    /validate-views   — Validar vistas XML"
echo "    /module-checklist — Checklist profesional"
echo "    /new-model        — Scaffold de modelo"
echo "    /new-wizard       — Scaffold de wizard"
echo "    /odoo-deploy      — Verificar deploy"
echo "    /add-field        — Agregar campo"
echo "    /git-flow         — Gestión git"
echo ""
echo "  Usa cualquier skill escribiendo su nombre"
echo "  en Claude Code (ej: /odoo-lint)"
echo "============================================="
