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
