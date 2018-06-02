<!--
Tomato GUI
Copyright (C) 2006-2010 Jonathan Zarate
http://www.polarcloud.com/tomato/

For use with Tomato Firmware only.
No part of this file may be used without permission.
--><title>IP 流量监控</title>
<content>
	<script type="text/javascript">

		// <% nvram("at_update,tomatoanon_answer,cstats_enable,cstats_path,cstats_stime,cstats_offset,cstats_exclude,cstats_include,cstats_sshut,et0macaddr,cifs1,cifs2,jffs2_on,cstats_bak,cstats_all,cstats_labels"); %>

		function fix(name)
		{
			var i;
			if (((i = name.lastIndexOf('/')) > 0) || ((i = name.lastIndexOf('\\')) > 0))
				name = name.substring(i + 1, name.length);
			return name;
		}
		function backupNameChanged()
		{
			if (location.href.match(/^(http.+?\/.+\/)/)) {
				// E('backup-link').href = RegExp.$1 + 'ipt/' + fix(E('backup-name').value) + '.gz?_http_id=' + nvram.http_id; // Not Required since we replaced link with button
			}
		}
		function backupButton()
		{
			var name;
			name = fix(E('backup-name').value);
			if (name.length <= 1) {
				alert('无效的文件名。');
				return;
			}

			location.href = '/ipt/' + name + '.gz?_http_id=' + nvram.http_id;
		}
		function restoreButton() {

			var fom;
			var name;
			var i;
			name = fix(E('restore-name').value);
			name = name.toLowerCase();

			if ((name.length <= 3) || (name.substring(name.length - 3, name.length).toLowerCase() != '.gz')) {
				alert('无效的文件名。 正确的类似“.gz”文件。');
				return false;
			}

			if (!confirm('从 ' + name + '中还原数据?')) return;
			E('restore-button').disabled = 1;
			fields.disableAll(E('_fom'), 1);
			E('restore-form').submit();

		}

		function getPath()
		{
			var s = E('_f_loc').value;
			return (s == '*user') ? E('_f_user').value : s;
		}
		function verifyFields(focused, quiet) {

			var b, v;
			var path;
			var eLoc, eUser, eTime, eOfs;
			var bak;
			var eInc, eExc, eAll, eBak, eLab;

			eLoc = E('_f_loc');
			eUser = E('_f_user');
			eTime = E('_cstats_stime');
			eOfs = E('_cstats_offset');

			eInc = E('_cstats_include');
			eExc = E('_cstats_exclude');
			eAll = E('_f_all');
			eBak = E('_f_bak');

			eLab = E('_cstats_labels');

			b = !E('_f_cstats_enable').checked;
			eLoc.disabled = b;
			eUser.disabled = b;
			eTime.disabled = b;
			eOfs.disabled = b;
			eInc.disabled = b;
			eExc.disabled = b;
			eAll.disabled = b;
			eBak.disabled = b;
			eLab.disabled = b;
			E('_f_new').disabled = b;
			E('_f_sshut').disabled = b;
			E('backup-button').disabled = b;
			E('backup-name').disabled = b;
			E('restore-button').disabled = b;
			E('restore-name').disabled = b;
			ferror.clear(eLoc);
			ferror.clear(eUser);
			ferror.clear(eOfs);
			if (b) return 1;

			eInc.disabled = eAll.checked;

			path = getPath();
			E('newmsg').style.visibility = ((nvram.cstats_path != path) && (path != '*nvram') && (path != '')) ? 'visible' : 'hidden';

			bak = 0;
			v = eLoc.value;
			b = (v == '*user');
			elem.display(eUser, b);
			if (b) {
				if (!v_length(eUser, quiet, 2)) return 0;
				if (path.substr(0, 1) != '/') {
					ferror.set(eUser, '请从/root目录开始。', quiet);
					return 0;
				}
			}
			else if (v == '/jffs/') {
				if (nvram.jffs2_on != '1') {
					ferror.set(eLoc, 'JFFS2未启用。', quiet);
					return 0;
				}
			}
			else if (v.match(/^\/cifs(1|2)\/$/)) {
				if (nvram['cifs' + RegExp.$1].substr(0, 1) != '1') {
					ferror.set(eLoc, 'CIFS #' + RegExp.$1 + '未启用。', quiet);
					return 0;
				}
			}
			else {
				bak = 1;
			}

			E('_f_bak').disabled = bak;

			return v_range(eOfs, quiet, 1, 31);
		}
		function save()
		{
			var fom, path, en, e, aj;
			if (!verifyFields(null, false)) return;
			aj = 1;
			en = E('_f_cstats_enable').checked;
			fom = E('_fom');
			fom._service.value = 'cstats-restart';
			if (en) {
				path = getPath();
				if (((E('_cstats_stime').value * 1) <= 48) &&
					((path == '*nvram') || (path == '/jffs/'))) {
					if (!confirm('不建议频繁保存到NVRAM或JFFS2。 仍然继续?')) return;
				}
				if ((nvram.cstats_path != path) && (fom.cstats_path.value != path) && (path != '') && (path != '*nvram') &&
					(path.substr(path.length - 1, 1) != '/')) {
					if (!confirm('注意: ' + path + ' 将被视为一个文件。 如果这是一个目录，请使用/. 仍然继续?')) return;
				}
				fom.cstats_path.value = path;
				if (E('_f_new').checked) {
					fom._service.value = 'cstatsnew-restart';
					aj = 0;
				}
			}
			fom.cstats_path.disabled = !en;
			fom.cstats_enable.value = en ? 1 : 0;
			fom.cstats_sshut.value = E('_f_sshut').checked ? 1 : 0;
			fom.cstats_bak.value = E('_f_bak').checked ? 1 : 0;
			fom.cstats_all.value = E('_f_all').checked ? 1 : 0;
			e = E('_cstats_exclude');
			e.value = e.value.replace(/\s+/g, ',').replace(/,+/g, ',');
			e = E('_cstats_include');
			e.value = e.value.replace(/\s+/g, ',').replace(/,+/g, ',');
			fields.disableAll(E('backup-section'), 1);
			fields.disableAll(E('restore-section'), 1);
			form.submit(fom, aj);
			if (en) {
				fields.disableAll(E('backup-section'), 0);
				fields.disableAll(E('restore-section'), 0);
			}
		}
		function init() {

			$('#backup-section .input-append').prepend('<input size="40" type="text" size="40" maxlength="64" id="backup-name" name="backup_name" onchange="backupNameChanged()" value="tomato_cstats_' + nvram.et0macaddr.replace(/:/g, '').toLowerCase() + '">');
			backupNameChanged();

		}
	</script>

	<div class="box">
		<div class="heading">IP 流量监控设置</div>
		<div class="content">
			<form id="_fom" method="post" action="tomato.cgi">
				<input type="hidden" name="_nextpage" value="/#admin-iptraffic.asp">
				<input type="hidden" name="_service" value="cstats-restart">
				<input type="hidden" name="cstats_enable">
				<input type="hidden" name="cstats_path">
				<input type="hidden" name="cstats_sshut">
				<input type="hidden" name="cstats_bak">
				<input type="hidden" name="cstats_all">

				<div id="iptconfig"></div><hr>
			</form>

			<script type='text/javascript'>
				switch (nvram.cstats_path) {
					case '':
					case '*nvram':
					case '/jffs/':
					case '/cifs1/':
					case '/cifs2/':
						loc = nvram.cstats_path;
						break;
					default:
						loc = '*user';
						break;
				}
				$('#iptconfig').forms([
					{ title: '启用', name: 'f_cstats_enable', type: 'checkbox', value: nvram.cstats_enable == '1' },
					{ title: '数据保存路径', multi: [
						/* REMOVE-BEGIN
						//	{ name: 'f_loc', type: 'select', options: [['','RAM (Temporary)'],['*nvram','NVRAM'],['/jffs/','JFFS2'],['/cifs1/','CIFS 1'],['/cifs2/','CIFS 2'],['*user','Custom Path']], value: loc },
						REMOVE-END */
						{ name: 'f_loc', type: 'select', options: [['','内存 (临时)'],['/jffs/','JFFS2分区'],['/cifs1/','CIFS 1分区'],['/cifs2/','CIFS 2分区'],['*user','自定义路径']], value: loc },
						{ name: 'f_user', type: 'text', maxlen: 48, size: 30, value: nvram.cstats_path }
						] },
											{ title: '保存频率', indent: 2, name: 'cstats_stime', type: 'select', value: nvram.cstats_stime, options: [
						[1,'每小时'],[2,'每2小时'],[3,'每3小时'],[4,'每4小时'],[5,'每5小时'],[6,'每6小时'],
						[9,'每9小时'],[12,'每12小时'],[24,'每天'],[48,'每2天'],[72,'每3天'],[96,'每4天'],
						[120,'每5天'],[144,'每6天'],[168,'每周']] },
						{ title: '关机时保存', indent: 2, name: 'f_sshut', type: 'checkbox', value: nvram.cstats_sshut == '1' },
						{ title: '创建新文件<br><small>(清除数据时)</small>', indent: 2, name: 'f_new', type: 'checkbox', value: 0,
						suffix: ' &nbsp; <b id="newmsg" style="visibility:hidden"><small>如果这是一个新文件，则启用</small></b>' },
						{ title: '创建备份', indent: 2, name: 'f_bak', type: 'checkbox', value: nvram.cstats_bak == '1' },
						{ title: '每月1日', name: 'cstats_offset', type: 'text', value: nvram.cstats_offset, maxlen: 2, size: 4 },
						{ title: '排除的IP', help: '逗号分隔列表', name: 'cstats_exclude', type: 'text', value: nvram.cstats_exclude, maxlen: 512, size: 50 },
						{ title: '包含的IP', help: '逗号分隔列表', name: 'cstats_include', type: 'text', value: nvram.cstats_include, maxlen: 2048, size: 50 },
						{ title: '启用自动发现', name: 'f_all', type: 'checkbox', value: nvram.cstats_all == '1', suffix: '&nbsp;<small>(在检测到任何流量时自动将新的IP包括在监视中)</small>' },
						{ title: '图形上的标签', name: 'cstats_labels', type: 'select', value: nvram.cstats_stime, options: [[0,'已知的主机名和IP'],[1,'已知的主机名，否则只显示IP'],[2,'仅显示IP']], value: nvram.cstats_labels }
						], { align: 'left' });
			</script>

			<div class="row">

				<div class="col-sm-12">
					<h4>备份</h4>
					<div class="section" id="backup-section">
						<form>
							<div class="input-append">
								<button name="f_backup_button" id="backup-button" onclick="backupButton(); return false;" class="btn">备份 <i class="icon-download"></i></button>
							</div>
						</form>
					</div>
				</div>

				<div class="col-sm-12">
					<h4>恢复</h4>
					<div class="section" id="restore-section">
						<form id="restore-form" method="post" action="ipt/restore.cgi?_http_id=<% nv(http_id); %>" encType="multipart/form-data">
							<input class="uploadfile" type="file" size="40" id="restore-name" name="restore_name" accept="application/x-gzip">
							<button type="button" name="f_restore_button" id="restore-button" value="Restore" onclick="restoreButton(); return false;" class="btn">恢复 <i class="icon-upload"></i></button>
						</form><br>
					</div>
				</div>

				<div class="col-sm-12">
					<h4>Notes</h4>
					<ul>
						<li>IP流量监测<i>IPv4</i> 网络流量 <i>通过</i> 路由器</li>
						<li>检查你的 <a class="ajaxload" href="#basic-network.asp">LAN设置</a> 在启用此功能：任何/所有的LAN接口必须至少16位的子网掩码（255.255.0.0）。</li>
						<li>不支持大的子网的监控。</li>
					</ul>

					<p>其他相关的说明/提示:</p>
					<ul>
						<li>启用此功能之前，请检查您的 <a class="ajaxload" href="basic-network.asp">LAN 设置</a> 确保在任何/所有你的局域网的子网掩码桥接已正确配置（即子网掩码与至少16位设置或“255.255.0.0”）。</li>
						<li>虽然技术上的支持，这是不推荐的IP流量监控子网大于/等于一个C类网络（即子网掩码与至少24位设置或“255.255.255.0”）。</li>
						<li>IP流量监控跟踪数据/包，这将是要么 <i>从哪里来/离开</i> 或 <i>去/到达</i> 在LAN接口/子网的IP。</li>
						<li>作为一个经验法则，这意味着跟踪网络/数据包正在从/转发到LAN接口为某种路由（或NAT）的结果，将排除任何/所有数据/所/内的设备到达之间交换的数据包在同一个局域网接口（即在同一IP子网/ LAN桥接，即使数据包实际上正在从/有线/无线/不同的接口通过路由器转发）。</li>
						<!-- VLAN-BEGIN -->
						<li>网络流量/流向自/至/不同的局域网桥之间的通信/子网将被跟踪/独立核算/相应（“两倍”，如：字节数/包 <i>来自哪里</i> 的第一个局域网桥和（相同）字节/数据包的数量 <i>去到</i> 第二个LAN桥接）。</li>
						<!-- VLAN-END -->
					</ul>
				</div>

			</div>
		</div>
	</div>

	<button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">保存 <i class="icon-check"></i></button>
	<button type="button" value="Cancel" id="cancel-button" onclick="javascript:reloadPage();" class="btn">取消 <i class="icon-cancel"></i></button>
	<span id="footer-msg" class="alert alert-warning" style="visibility: hidden;"></span><br /><br />

	<script type="text/javascript">init(); verifyFields(null, 1);</script>
</content>