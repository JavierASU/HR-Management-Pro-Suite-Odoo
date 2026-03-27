# HR Management Pro Suite

[![Odoo Version](https://img.shields.io/badge/Odoo-17.0-blue.svg)](https://www.odoo.com)
[![License: LGPL-3](https://img.shields.io/badge/License-LGPL--3-green.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/JavierASU/HR-Management-Pro-Suite-Odoo/pulls)

Professional Human Resources extension for **Odoo 17 Community Edition**. Manage internal employee requests with multi-level approval workflows, dashboards, and PDF reports.

---

## Screenshots

> Screenshots coming soon. Contributions welcome!

---

## Features

### Employee Profile Extension
- Seniority tracking, contract type, work modality
- Performance indicators and smart buttons

### Internal Request System
- Request types: leave, permission, equipment, remote work
- Automatic sequence numbering

### Multi-Level Approval Workflow
```
Draft --> Submitted --> Manager Approval --> HR Approval --> Done
                 \                    \
                  --> Rejected          --> Rejected
```

### Dashboard & Views
- Filtered views: pending, awaiting HR, approved this month
- Kanban, list, and form views with stat widgets

### Mass Approval Wizard
- Bulk approve/reject requests for managers and HR

### PDF Reports
- QWeb PDF reports with employee and approver signatures

### Role-Based Security
| Role | Permissions |
|------|------------|
| **HR Pro User** | Create and view own requests |
| **HR Pro Manager** | Approve/reject, view all requests |
| **HR Pro Admin** | Full access including delete |

---

## Requirements

- Odoo 17.0 Community or Enterprise
- Dependencies: `hr`, `mail`

## Installation

1. Clone this repository into your Odoo addons directory:
   ```bash
   cd /path/to/odoo/addons
   git clone https://github.com/JavierASU/HR-Management-Pro-Suite-Odoo.git hr_management_pro
   ```
2. Restart Odoo and update the apps list
3. Search for **HR Management Pro Suite** and click Install

## Configuration

1. Go to **Settings > Users** and assign one of the HR Pro roles:
   - HR Pro User
   - HR Pro Manager
   - HR Pro Admin
2. Navigate to **HR Management Pro** in the main menu

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Author

**HR Management Pro** - [JavierASU](https://github.com/JavierASU)

## License

This project is licensed under [LGPL-3](https://www.gnu.org/licenses/lgpl-3.0)
