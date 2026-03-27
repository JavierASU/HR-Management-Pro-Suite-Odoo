# -*- coding: utf-8 -*-

from odoo import api, fields, models, _
from odoo.exceptions import UserError, ValidationError


class HrInternalRequest(models.Model):
    _name = 'hr.internal.request'
    _description = 'Internal Employee Request'
    _inherit = ['mail.thread', 'mail.activity.mixin']
    _order = 'create_date desc, id desc'

    name = fields.Char(
        string='Reference',
        required=True,
        copy=False,
        readonly=True,
        default=lambda self: _('New'),
    )
    employee_id = fields.Many2one(
        'hr.employee',
        string='Employee',
        required=True,
        tracking=True,
        default=lambda self: self.env.user.employee_id,
    )
    department_id = fields.Many2one(
        'hr.department',
        string='Department',
        related='employee_id.department_id',
        store=True,
        readonly=True,
    )
    request_type = fields.Selection([
        ('leave', 'Leave'),
        ('permission', 'Permission'),
        ('equipment', 'Equipment'),
        ('remote_work', 'Remote Work'),
    ], string='Request Type', required=True, tracking=True)

    date_from = fields.Datetime(string='Date From', required=True, tracking=True)
    date_to = fields.Datetime(string='Date To', required=True, tracking=True)
    duration_days = fields.Float(
        string='Duration (days)',
        compute='_compute_duration_days',
        store=True,
    )
    reason = fields.Text(string='Reason', tracking=True)

    state = fields.Selection([
        ('draft', 'Draft'),
        ('submitted', 'Submitted'),
        ('manager_approved', 'Manager Approved'),
        ('hr_approved', 'HR Approved'),
        ('rejected', 'Rejected'),
    ], string='Status', default='draft', tracking=True, copy=False)

    manager_id = fields.Many2one(
        'hr.employee',
        string='Manager',
        compute='_compute_manager_id',
        store=True,
        readonly=False,
        tracking=True,
    )
    hr_responsible_id = fields.Many2one(
        'hr.employee',
        string='HR Responsible',
        tracking=True,
    )
    company_id = fields.Many2one(
        'res.company',
        string='Company',
        default=lambda self: self.env.company,
        required=True,
    )
    rejection_reason = fields.Text(string='Rejection Reason', tracking=True)

    priority = fields.Selection([
        ('0', 'Normal'),
        ('1', 'Important'),
        ('2', 'Urgent'),
    ], string='Priority', default='0', tracking=True)

    color = fields.Integer(string='Color', compute='_compute_color')

    @api.depends('date_from', 'date_to')
    def _compute_duration_days(self):
        for rec in self:
            if rec.date_from and rec.date_to:
                delta = rec.date_to - rec.date_from
                rec.duration_days = delta.total_seconds() / 86400
            else:
                rec.duration_days = 0.0

    @api.depends('employee_id', 'employee_id.parent_id')
    def _compute_manager_id(self):
        for rec in self:
            rec.manager_id = rec.employee_id.parent_id

    @api.depends('state')
    def _compute_color(self):
        color_map = {
            'draft': 0,
            'submitted': 4,
            'manager_approved': 10,
            'hr_approved': 7,
            'rejected': 1,
        }
        for rec in self:
            rec.color = color_map.get(rec.state, 0)

    @api.constrains('date_from', 'date_to')
    def _check_dates(self):
        for rec in self:
            if rec.date_from and rec.date_to and rec.date_from >= rec.date_to:
                raise ValidationError(_('Date To must be after Date From.'))

    # ---- Workflow actions ----

    def action_submit(self):
        for rec in self:
            if rec.state != 'draft':
                raise UserError(_('Only draft requests can be submitted.'))
            rec.write({'state': 'submitted'})

    def action_manager_approve(self):
        for rec in self:
            if rec.state != 'submitted':
                raise UserError(_('Only submitted requests can be approved by manager.'))
            rec.write({
                'state': 'manager_approved',
                'manager_id': rec.manager_id.id or self.env.user.employee_id.id,
            })

    def action_hr_approve(self):
        for rec in self:
            if rec.state != 'manager_approved':
                raise UserError(_('Only manager-approved requests can be approved by HR.'))
            rec.write({
                'state': 'hr_approved',
                'hr_responsible_id': self.env.user.employee_id.id,
            })

    def action_reject(self):
        for rec in self:
            if rec.state in ('hr_approved', 'rejected'):
                raise UserError(_('Cannot reject an already approved or rejected request.'))
            rec.write({'state': 'rejected'})

    def action_reset_draft(self):
        for rec in self:
            if rec.state != 'rejected':
                raise UserError(_('Only rejected requests can be reset to draft.'))
            rec.write({
                'state': 'draft',
                'rejection_reason': False,
            })

    @api.model_create_multi
    def create(self, vals_list):
        for vals in vals_list:
            if vals.get('name', _('New')) == _('New'):
                vals['name'] = self.env['ir.sequence'].next_by_code(
                    'hr.internal.request'
                ) or _('New')
        return super().create(vals_list)
