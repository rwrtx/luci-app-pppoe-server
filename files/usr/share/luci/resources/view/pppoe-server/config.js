'use strict';
'require form';
'require view';

return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map('pppoe-server', _('PPPoE Server Configuration'), _('MikroTik-style PPPoE Server setup for OpenWrt 24.'));

		s = m.section(form.TypedSection, 'main', _('General Settings'));
		s.anonymous = true;

		o = s.option(form.Flag, 'enabled', _('Enable PPPoE Server'));
		o.rmempty = false;

		o = s.option(form.Value, 'interface', _('Interface'));
		o.datatype = 'network';
		o.default = 'lan';

		o = s.option(form.Value, 'local_ip', _('Server IP Address'));
		o.datatype = 'ip4addr';

		o = s.option(form.Value, 'ip_pool_start', _('IP Pool Start'));
		o.datatype = 'ip4addr';

		o = s.option(form.Value, 'ip_pool_end', _('IP Pool End'));
		o.datatype = 'ip4addr';

		o = s.option(form.Value, 'dns1', _('Primary DNS'));
		o.datatype = 'ip4addr';
		o.default = '8.8.8.8';

		o = s.option(form.Value, 'dns2', _('Secondary DNS'));
		o.datatype = 'ip4addr';
		o.default = '8.8.4.4';

		return m.render();
	}
});
