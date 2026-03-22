from odoo import api, fields, models, _
from odoo.exceptions import UserError

class HrInternalRequestMassApproveWizard(models.TransientModel):
    _name = 'hr.internal.request.mass.approve.wizard'
    _description = 'Mass Approve Internal Requests'

    approve_as = fields.Selection([
        ('manager', 'Manager'),
        ('hr', 'HR')
    ], string='Approve As', required=True)
    request_ids = fields.Many2many('hr.internal.request', string='Requests')

    def action_mass_approve(self):
        for request in self.request_ids:
            if self.approve_as == 'manager':
                if request.state == 'submitted':
                    request.action_manager_approve()
            elif self.approve_as == 'hr':
                if request.state == 'manager_approved':
                    request.action_hr_approve()
        return {'type': 'ir.actions.act_window_close'}
