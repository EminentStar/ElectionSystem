vs = {
	url: {
		conv: function(url) {
			if (url.charAt(0) == '/') {
				url = url.substring(1, url.length);
			}
			return vs.config.contextRoot + url;
		},
		img: function(isThumnail, menu, dir, fileName) {
			var size = isThumnail ? 'tb/' : 'nm/';
			return vs.config.contextRoot + 'rsc/img/' + size + menu + '/' + dir + '/' + fileName + '.jpg';
		}
	},
	config: {
		contextRoot: null,
		locale: null,
		country: null,
		language: null
	},
	session: {
		user: {
			id: null,
			name: null,
			mfCode: null,
			mfName: null,
			dtCode: null,
			dtName: null,
			workNo: null,
			ceoName: null,
			address: null,
			tel: null,
			fax: null
		},
		check: function(response) {
			switch (response.status) {
			case 601:
				Ext.Msg.alert(
              		vs.i18n.getMsg('msg.alert.fail.title'), 
              		vs.i18n.getMsg('msg.fail.session.timeout'), function() {
              			window.location.href = vs.url.conv("/");
              		});
				break;
			case 602:
				Ext.Msg.alert(
						vs.i18n.getMsg('msg.alert.fail.title'), 
						vs.i18n.getMsg('msg.fail.access.denied'), function() {
							window.location.href = vs.url.conv('j_spring_security_logout');
						});
				break;
			case 691:
				Ext.Msg.alert(
						vs.i18n.getMsg('msg.alert.fail.title'), 
						vs.i18n.getMsg('msg.fail.access.denied'), function() {
							
						});
				break;
			case 692:
				Ext.Msg.alert(
						vs.i18n.getMsg('msg.alert.fail.title'), 
						vs.i18n.getMsg('msg.fail.access.denied'), function() {
							
						});
				break;
			case 693:
				Ext.Msg.alert(
						vs.i18n.getMsg('msg.alert.fail.title'), 
						vs.i18n.getMsg('msg.fail.access.denied'), function() {
							
						});
				break;
			default:
				return true;
			}
		}
	},
	format: {
		ymd: {
			display: 'Y-m-d',
			value: 'Ymd'
		},
		time: {
			display: 'H:i:s',
			value: 'His'
		}
	},
	authority: {
		group: {
			admin: {
				sys: '1',
				mft: '2'
			}
		},
		role: {
			admin: {
				sys: 'ROLE_SYS_ADMIN',
				mft: 'ROLE_MFT_ADMIN'
			},
			user: {
				mft: 'ROLE_MFT_USER'
			}
		},
		hasRole: function(role) {
			return Ext.Array.contains(vs.session.user.role, role);
		}
	},
	file: {
		capacity : {
			kb: 1024,
			mb: (1024 * 1024),
			gb: (1024 * 1024 * 1024)
		},
		text: {
			kb: 'KB',
			mb: 'MB',
			gb: 'GB'
		}
	},
	support: {
		email: 'scmsupport@javabugs.net'
	},
	error: {
		msg: function(msgKey, callback) {
			Ext.Msg.alert(vs.i18n.getMsg('msg.alert.error.title'), vs.i18n.getMsg(msgKey), callback);
		}
	}
};