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
