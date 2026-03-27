# -*- coding: utf-8 -*-

from odoo import api, fields, models, _
from odoo.exceptions import UserError


class HrInternalRequestMassApproveWizard(models.TransientModel):
    _name = 'hr.internal.request.mass.approve.wizard'
    _description = 'Mass Approve Internal Requests'

    approve_as = fields.Selection([
        ('manager', 'Manager'),
        ('hr', 'HR'),
    ], string='Approve As', required=True, default='manager')

    request_ids = fields.Many2many(
        'hr.internal.request',
        string='Requests',
    )

    @api.model
    def default_get(self, fields_list):
        res = super().default_get(fields_list)
        active_ids = self.env.context.get('active_ids', [])
        if active_ids:
            res['request_ids'] = [(6, 0, active_ids)]
        return res

    def action_mass_approve(self):
        self.ensure_one()
        if not self.request_ids:
            raise UserError(_('No requests selected.'))

        approved = 0
        skipped = 0
        for request in self.request_ids:
            if self.approve_as == 'manager' and request.state == 'submitted':
                request.action_manager_approve()
                approved += 1
            elif self.approve_as == 'hr' and request.state == 'manager_approved':
                request.action_hr_approve()
                approved += 1
            else:
                skipped += 1

        if skipped and not approved:
            raise UserError(_(
                'None of the selected requests are in the correct state for this approval type.'
            ))

        return {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'title': _('Mass Approval'),
                'message': _('%d request(s) approved, %d skipped.') % (approved, skipped),
                'type': 'success' if approved else 'warning',
                'sticky': False,
                'next': {'type': 'ir.actions.act_window_close'},
            },
        }

    def action_mass_reject(self):
        self.ensure_one()
        if not self.request_ids:
            raise UserError(_('No requests selected.'))

        rejected = 0
        skipped = 0
        for request in self.request_ids:
            if request.state in ('submitted', 'manager_approved'):
                request.action_reject()
                rejected += 1
            else:
                skipped += 1

        if skipped and not rejected:
            raise UserError(_(
                'None of the selected requests can be rejected.'
            ))

        return {'type': 'ir.actions.act_window_close'}
