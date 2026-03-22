{
    "name": "HR Management Pro Suite",
    "version": "17.0.1.0.0",
    "summary": "Gestión avanzada de RRHH: solicitudes internas, dashboard, reportes, mejoras UX.",
    "author": "Tu Empresa",
    "website": "https://www.tuempresa.com",
    "category": "Human Resources",
    "license": "LGPL-3",
    "depends": ["hr", "mail", "web"],
    "data": [
        "security/security.xml",
        "security/ir.model.access.csv",
        "data/sequence.xml",
        "views/hr_employee_view.xml",
        "views/hr_internal_request_view.xml",
        "views/hr_dashboard_view.xml",
        "views/hr_internal_request_report.xml",
        "wizard/hr_internal_request_mass_approve_view.xml",
        "reports/hr_internal_request_report_template.xml",
        "views/menus.xml",
        "static/src/css/style.css"
    ],
    "assets": {
        "web.assets_backend": [
            "hr_management_pro/static/src/css/style.css"
        ]
    },
    "installable": True,
    "application": True,
    "auto_install": False
}

