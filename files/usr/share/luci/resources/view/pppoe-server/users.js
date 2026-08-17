'use strict';
'require form';
'require view';

return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map('pppoe-server', _('PPPoE User Secrets & Bandwidth Management'));

		s = m.section(form.GridSection, 'user', _('User Secrets'));
		s.addremove = true;
		s.anonymous = true;

		o = s.option(form.Value, 'username', _('Username'));
		o.rmempty = false;

		o = s.option(form.Value, 'password', _('Password'));
		o.password = true;

		o = s.option(form.Value, 'remote_ip', _('Remote IP'));
		o.datatype = 'ip4addr';

		o = s.option(form.Value, 'download_limit', _('Max Download (e.g., 10M)'));
		o.placeholder = '10M';

		o = s.option(form.Value, 'upload_limit', _('Max Upload (e.g., 5M)'));
		o.placeholder = '5M';

		o = s.option(form.Flag, 'isolated', _('Isolir (Block Internet)'));
		o.rmempty = false;

		o = s.option(form.Flag, 'disabled', _('Disable Account'));
		o.rmempty = false;

		return m.render();
	}
});
