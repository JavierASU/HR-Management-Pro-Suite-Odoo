{
    "name": "HR Management Pro Suite",
    "version": "17.0.1.2.0",
    "summary": "Advanced HR management: internal requests, approvals, dashboards and reports.",
    "description": """
HR Management Pro Suite
=======================

Professional Human Resources extension for Odoo 17 Community.

Features:
---------
* Employee professional profile extension (seniority, contract, modality, performance)
* Internal employee request system (leave, permission, equipment, remote work)
* Multi-level approval workflow (draft → submitted → manager → HR)
* Filtered dashboard views (pending, awaiting HR, approved this month)
* Mass approval wizard for managers and HR
* QWeb PDF reports with signatures
* Smart buttons and stat widgets
* Role-based security with record rules
* Full mail.thread integration with tracking
""",
    "author": "HR Management Pro",
    "website": "https://github.com/JavierASU/HR-Management-Pro-Suite-Odoo",
    "category": "Human Resources",
    "license": "LGPL-3",
    "depends": [
        "hr",
        "mail",
    ],
    "data": [
        "security/security.xml",
        "security/ir.model.access.csv",

        "data/sequence.xml",

        "views/hr_internal_request_view.xml",
        "views/hr_employee_view.xml",
        "views/hr_dashboard_view.xml",
        "views/menus.xml",

        "wizard/hr_internal_request_mass_approve_view.xml",

        "reports/hr_internal_request_report_template.xml",
    ],
    "assets": {
        "web.assets_backend": [
            "hr_management_pro/static/src/css/style.css",
        ],
    },
    "demo": [],
    "installable": True,
    "application": True,
    "auto_install": False,

}
