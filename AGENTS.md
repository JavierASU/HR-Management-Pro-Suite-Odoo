# AGENTS.md

## Odoo 17.0 Community Developer Agent Guide

### Propósito
Guía para agentes (humanos o IA) responsables de desarrollar, mantener y validar módulos Odoo siguiendo los estándares más altos, enfocado en el módulo `hr_management_pro` y compatible con Odoo 17.0-20260305 Community Edition.

---

## 1. Comandos build/lint/test 

### Iniciar Odoo:
```bash
odoo-bin --addons-path=addons --config=odoo.conf
```

### Lint (calidad de código):
```bash
flake8 hr_management_pro/
black --check hr_management_pro/
isort --check-only hr_management_pro/
```

### Test completo del módulo:
```bash
odoo-bin --addons-path=addons --config=odoo.conf --test-enable --stop-after-init --log-level=test
```

### Ejecutar test unitario de este módulo:
```bash
odoo-bin --addons-path=addons --config=odoo.conf --test-enable --stop-after-init --log-level=test --test-tags=hr_management_pro
```

### Requisitos y preparación:
- Python >=3.10
- Instala dependencias:
    ```bash
    pip install -r requirements.txt  # si está disponible
    pip install black flake8 isort
    ```
- Instala los addons nativos requeridos: `hr`, `mail`, `web`
- Archivo odoo.conf bien configurado en la raíz o ruta a usar

---

## 2. Pautas de Estilo y Código

### Imports (Python):
- 1° estándar, 2° terceros, 3° odoo, 4° locales, cada grupo separado por línea en blanco.
- Usar sólo los módulos necesarios.

### Formato y Nomenclatura:
- 4 espacios por indentación.
- snake_case para métodos y campos.
- CamelCase para clases.
- UPPER_CASE para constantes.
- Docstrings en inglés y descriptivos.
- Definir siempre `_name`, `_description` y `_inherit` en modelos/clases.
- IDs XML únicos, descriptivos y con prefijo de módulo.

### Tipos y Métodos:
- Usar decoradores `@api.model`, `@api.depends`, `@api.onchange`, `@api.model_create_multi` según corresponda.
- Métodos "action" para lógica de cambio de estado; separar validaciones y operaciones atómicas.
- No lógica pesada en vistas ni compute; usar wizards para operaciones masivas.

### Pruebas y Validación:
- Implementar pruebas unitarias en `tests/` usando TransactionCase o SavepointCase donde posible.
- Validar flujo completo: creación, aprobaciones, rechazos, permisos.
- Cobertura objetivo >70%.

### Seguridad:
- Añadir todos los modelos nuevos a `ir.model.access.csv`.
- Grupos: usuarios con mínima gestión, managers con control intermedio, admin HR con permisos completos.
- Nunca permisos globales para modelos sensibles.
- Validar ownership antes de escribir/borrar datos.

### Manejo de Errores:
- Usar siempre excepciones Odoo (`UserError`, `ValidationError`).
- Mensajes claros y localizables.

### Vistas y UI:
- Usar statusbar, botones por estado y restricciones en botones (`states=`).
- Máximo reuso y extensión vía `inherit_id` en XML.
- Agrupar fields por lógica de negocio.
- Usar kanban, árbol y form según el proceso.

### Wizards y Masivos:
- Wizards como TransientModel.
- Acción principal debe retornar `{type: 'ir.actions.act_window_close'}`.
- Validar estados antes de aprobar en masa.

### CI/CD y Git
- Usar ramas por feature/fix y PRs.
- Mensajes de commit claros: `[modulo] TIPO: Resumen (#issue)`
- Revisar permisos y cambios de estructura antes de mergear.
- Mantener README actualizado.

### Mantenimiento
- Documentar métodos y vistas complejas.
- Scripts de migración si cambian campos críticos.
- Comprobar que los reportes QWeb siguen el template actual y están registrados en el manifiesto.

---

## 3. Mejores Prácticas Reales de Este Proyecto

- Uso de secuencias para referencias (`ir.sequence`).
- Flujos de aprobación multinivel claros y diferenciados en backend y UI.
- Seguridad granular con roles concisos.
- Uso correcto de `mail.thread` y `mail.activity.mixin` para tracking y actividades.
- Extensión desde vistas nativas de Odoo (`inherit_id`).
- Agrupación de campos y lógica limpia en formularios profesionales.
- Wizards bien implementados para acciones masivas.

---

## 4. Documentación y Recursos Adicionales

- Documentación oficial: https://www.odoo.com/documentation/17.0/
- Ejemplos y referencias oficiales: https://github.com/odoo/odoo
- Comunidad y ayuda: https://www.odoo.com/forum/help-1

---

## 5. Checklist Básico de Módulo Profesional (para agente)

- [ ] ¿Todos los modelos tienen permisos definidos?
- [ ] ¿Todos los campos críticos tienen compute/tracking si es relevante?
- [ ] ¿La lógica de negocio respeta los decoradores y convenciones?
- [ ] ¿Están cubiertos casos de uso típico y edge cases en tests?
- [ ] ¿Los commits y PRs son semánticos y claros?
- [ ] ¿El módulo instala/explota/desinstala sin errores?
- [ ] ¿Las vistas son amigables y responsivas?
- [ ] ¿La cobertura de pruebas es aceptable?
- [ ] ¿Los wizards funcionan sin errores?
- [ ] ¿La seguridad y los roles están probados?
- [ ] ¿Los reportes y dashboards se visualizan correctamente?

---

### ¡Si el agente sigue este archivo, el módulo funcionará al 100% profesional y sin errores para Odoo 17 Community!