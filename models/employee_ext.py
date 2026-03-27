# -*- coding: utf-8 -*-

from odoo import api, fields, models, _
from odoo.exceptions import ValidationError


class HrEmployee(models.Model):
    _inherit = 'hr.employee'

    seniority_level = fields.Selection([
        ('junior', 'Junior'),
        ('mid', 'Mid'),
        ('senior', 'Senior'),
        ('lead', 'Lead'),
    ], string='Seniority Level', tracking=True)

    contract_type = fields.Selection([
        ('indefinite', 'Indefinite'),
        ('fixed', 'Fixed Term'),
        ('contractor', 'Contractor'),
        ('intern', 'Intern'),
    ], string='Contract Type', tracking=True)

    work_modality = fields.Selection([
        ('remote', 'Remote'),
        ('hybrid', 'Hybrid'),
        ('onsite', 'Onsite'),
    ], string='Work Modality', tracking=True)

    performance_score = fields.Float(
        string='Performance Score',
        digits=(3, 1),
        tracking=True,
    )

    @api.constrains('performance_score')
    def _check_performance_score(self):
        for employee in self:
            if employee.performance_score < 0 or employee.performance_score > 10:
                raise ValidationError(
                    _('Performance score must be between 0 and 10.')
                )

    internal_request_count = fields.Integer(
        string='Request Count',
        compute='_compute_internal_request_count',
    )

    @api.depends()
    def _compute_internal_request_count(self):
        request_data = self.env['hr.internal.request'].sudo().read_group(
            [('employee_id', 'in', self.ids)],
            ['employee_id'],
            ['employee_id'],
        )
        mapped = {d['employee_id'][0]: d['employee_id_count'] for d in request_data}
        for employee in self:
            employee.internal_request_count = mapped.get(employee.id, 0)

    def action_view_internal_requests(self):
        self.ensure_one()
        return {
            'type': 'ir.actions.act_window',
            'name': 'Internal Requests',
            'res_model': 'hr.internal.request',
            'view_mode': 'tree,form',
            'domain': [('employee_id', '=', self.id)],
            'context': {'default_employee_id': self.id},
        }
