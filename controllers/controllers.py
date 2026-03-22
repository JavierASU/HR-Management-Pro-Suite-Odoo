# -*- coding: utf-8 -*-
# from odoo import http


# class HrManagementPro(http.Controller):
#     @http.route('/hr_management_pro/hr_management_pro', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/hr_management_pro/hr_management_pro/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('hr_management_pro.listing', {
#             'root': '/hr_management_pro/hr_management_pro',
#             'objects': http.request.env['hr_management_pro.hr_management_pro'].search([]),
#         })

#     @http.route('/hr_management_pro/hr_management_pro/objects/<model("hr_management_pro.hr_management_pro"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('hr_management_pro.object', {
#             'object': obj
#         })

