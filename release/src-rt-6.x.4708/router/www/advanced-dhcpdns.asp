<!--
Tomato GUI
Copyright (C) 2006-2010 Jonathan Zarate
http://www.polarcloud.com/tomato/

For use with Tomato Firmware only.
No part of this file may be used without permission.
--><title>DHCP / DNS 服务器</title>
<content>
	<script type="text/javascript">

		//<% nvram("dnsmasq_q,ipv6_radvd,ipv6_dhcpd,dhcpd_dmdns,dns_addget,dhcpd_gwmode,dns_intcpt,dhcpd_slt,dhcpc_minpkt,dnsmasq_custom,dnsmasq_norw,dhcpd_lmax,dhcpc_custom,dns_norebind,dhcpd_static_only,dnsmasq_debug"); %>

		if ((isNaN(nvram.dhcpd_lmax)) || ((nvram.dhcpd_lmax *= 1) < 1)) nvram.dhcpd_lmax = 255;

		function verifyFields(focused, quiet)
		{
			var b = (E('_f_dhcpd_sltsel').value == 1);
			elem.display('_dhcpd_sltman', b);
			if ((b) && (!v_range('_f_dhcpd_slt', quiet, 1, 43200))) return 0;
			if (!v_length('_dnsmasq_custom', quiet, 0, 2048)) return 0;
			if (!v_range('_dhcpd_lmax', quiet, 1, 0xFFFF)) return 0;
			if (!v_length('_dhcpc_custom', quiet, 0, 80)) return 0;
			return 1;
		}

		function nval(a, b)
		{
			return (a == null || (a + '').trim() == '') ? b : a;
		}

		function save()
		{
			if (!verifyFields(null, false)) return;

			var a;
			var fom = E('_fom');

			fom.dhcpd_dmdns.value = E('_f_dhcpd_dmdns').checked ? 1 : 0;
			a = E('_f_dhcpd_sltsel').value;
			fom.dhcpd_slt.value = (a != 1) ? a : E('_f_dhcpd_slt').value;
			fom.dns_addget.value = E('_f_dns_addget').checked ? 1 : 0;
			fom.dns_norebind.value = E('_f_dns_norebind').checked ? 1 : 0;
			fom.dhcpd_gwmode.value = E('_f_dhcpd_gwmode').checked ? 1 : 0;
			fom.dns_intcpt.value = E('_f_dns_intcpt').checked ? 1 : 0;
			fom.dhcpc_minpkt.value = E('_f_dhcpc_minpkt').checked ? 1 : 0;
			fom.dhcpd_static_only.value = E('_f_dhcpd_static_only').checked ? '1' : '0';
			fom.dnsmasq_debug.value = E('_f_dnsmasq_debug').checked ? '1' : '0';
			fom.ipv6_radvd.value = E('_f_ipv6_radvd').checked ? '1' : '0';
			fom.ipv6_dhcpd.value = E('_f_ipv6_dhcpd').checked ? '1' : '0';

			fom.dnsmasq_q.value = 0;
			if (fom.f_dnsmasq_q4.checked) fom.dnsmasq_q.value |= 1;
			if (fom.f_dnsmasq_q6.checked) fom.dnsmasq_q.value |= 2;
			if (fom.f_dnsmasq_qr.checked) fom.dnsmasq_q.value |= 4;

			if (fom.dhcpc_minpkt.value != nvram.dhcpc_minpkt ||
				fom.dhcpc_custom.value != nvram.dhcpc_custom) {
				nvram.dhcpc_minpkt = fom.dhcpc_minpkt.value;
				nvram.dhcpc_custom = fom.dhcpc_custom.value;
				fom._service.value = '*';
			}
			else {
				fom._service.value = 'dnsmasq-restart';
			}


			if (fom.dns_intcpt.value != nvram.dns_intcpt) {
				nvram.dns_intcpt = fom.dns_intcpt.value;
				if (fom._service.value != '*') fom._service.value += ',firewall-restart';
			}

			/* IPV6-BEGIN */
			if (fom.dhcpd_dmdns.value != nvram.dhcpd_dmdns) {
				nvram.dhcpd_dmdns = fom.dhcpd_dmdns.value;
				if (fom._service.value != '*') fom._service.value += ',dnsmasq-restart';
			}
			/* IPV6-END */

			form.submit(fom, 1);
		}

		function toggleVisibility(whichone) {
			if(E('sesdiv' + whichone).style.display=='') {
				E('sesdiv' + whichone).style.display='none';
				E('sesdiv' + whichone + 'showhide').innerHTML='<i class="icon-chevron-up"></i>';
				cookie.set('adv_dhcpdns_' + whichone + '_vis', 0);
			} else {
				E('sesdiv' + whichone).style.display='';
				E('sesdiv' + whichone + 'showhide').innerHTML='<i class="icon-chevron-down"></i>';
				cookie.set('adv_dhcpdns_' + whichone + '_vis', 1);
			}
		}

		function init() {
			var c;
			if (((c = cookie.get('adv_dhcpdns_notes_vis')) != null) && (c == '1')) {
				toggleVisibility("notes");
			}
		}
	</script>

	<form id="_fom" method="post" action="tomato.cgi">
		<input type="hidden" name="_nextpage" value="/#advanced-dhcpdns.asp">
		<input type="hidden" name="_service" value="">

		<input type="hidden" name="dhcpd_dmdns">
		<input type="hidden" name="dhcpd_slt">
		<input type="hidden" name="dns_addget">
		<input type="hidden" name="dns_norebind">
		<input type="hidden" name="dhcpd_gwmode">
		<input type="hidden" name="dns_intcpt">
		<input type="hidden" name="dhcpc_minpkt">
		<input type="hidden" name="dhcpd_static_only">
		<input type='hidden' name="dnsmasq_debug">
		<input type="hidden" name="ipv6_radvd">
		<input type='hidden' name="ipv6_dhcpd">
		<input type="hidden" name="dnsmasq_q">

		<div class="box" data-box="dhcp-server">
			<div class="heading">DHCP / DNS 服务器 (LAN)</div>
			<div class="section dnsdhcp content"></div>
			<script type="text/javascript">
				$('.section.dnsdhcp').forms([
{ title: '使用内部DNS', name: 'f_dhcpd_dmdns', type: 'checkbox', value: nvram.dhcpd_dmdns == '1' },
{ title: '调试模式', indent: 2, name: 'f_dnsmasq_debug', type: 'checkbox', value: nvram.dnsmasq_debug == '1' },
{ title: '使用获取和自定义DNS', name: 'f_dns_addget', type: 'checkbox', value: nvram.dns_addget == '1' },
{ title: '防止DNS污染', name: 'f_dns_norebind', type: 'checkbox', value: nvram.dns_norebind == '1' },
{ title: '拦截DNS端口<br>(UDP 53)', name: 'f_dns_intcpt', type: 'checkbox', value: nvram.dns_intcpt == '1' },
{ title: 'WAN禁用则使用自定义网关', name: 'f_dhcpd_gwmode', type: 'checkbox', value: nvram.dhcpd_gwmode == '1' },
{ title: '忽略来自未知设备的DHCP请求', name: 'f_dhcpd_static_only', type: 'checkbox', value: nvram.dhcpd_static_only == '1' },
{ title: '最大活动DHCP租期', name: 'dhcpd_lmax', type: 'text', maxlen: 5, size: 8, value: nvram.dhcpd_lmax },
{ title: '静态租期时间', multi: [
{ name: 'f_dhcpd_sltsel', type: 'select', options: [[0,'与正常租期时间相同'],[-1,'无限制'],[1,'自定义']],
value: (nvram.dhcpd_slt < 1) ? nvram.dhcpd_slt : 1 },
{ name: 'f_dhcpd_slt', type: 'text', maxlen: 5, size: 8, prefix: '<span id="_dhcpd_sltman"> ', suffix: '分钟</span>',
value: (nvram.dhcpd_slt >= 1) ? nvram.dhcpd_slt : 3600 } ] },
{ title: '广播IPv6(SLAAC)', name: 'f_ipv6_radvd', type: 'checkbox', value: nvram.ipv6_radvd == '1' },
{ title: '广播IPv6(DHCP)', name: 'f_ipv6_dhcpd', type: 'checkbox', value: nvram.ipv6_dhcpd == '1' },
{ title: '隐藏DHCPV4记录', name: 'f_dnsmasq_q4', type: 'checkbox', value: (nvram.dnsmasq_q & 1) },
{ title: '隐藏DHCPV6记录', name: 'f_dnsmasq_q6', type: 'checkbox', value: (nvram.dnsmasq_q & 2) },
{ title: '隐藏RA记录', name: 'f_dnsmasq_qr', type: 'checkbox', value: (nvram.dnsmasq_q & 4) },
{ title: '<a href="http://www.thekelleys.org.uk/" target="_new">Dnsmasq</a><br>自定义配置', name: 'dnsmasq_custom', type: 'textarea', value: nvram.dnsmasq_custom,
style: 'width: 100%; height:100px;' }
]);
			</script>
		</div>

		<div class="box" data-box="dhcp-client-wan">
			<div class="heading">DHCP 客户端 (WAN)</div>
			<div class="section dhcpwan content"></div>
			<script type="text/javascript">
				$('.dhcpwan').forms([
					{ title: 'DHCPC 选项', name: 'dhcpc_custom', type: 'text', maxlen: 80, size: 34, value: nvram.dhcpc_custom },
					{ title: '减少包大小', name: 'f_dhcpc_minpkt', type: 'checkbox', value: nvram.dhcpc_minpkt == '1' }
				]);
			</script>
		</div>

		<div class="box">
			<div class="heading">说明 <a class="pull-right" data-toggle="tooltip" title="Hide/Show Notes" href="javascript:toggleVisibility('notes');"><span id="sesdivnotesshowhide"><i class="icon-chevron-up"></i></span></a></div>
			<div class="section content" id="sesdivnotes" style="display:none">

				<i>DHCP / DNS 服务器 (LAN):</i><br>
				<ul>
				<li><b>使用内部DNS</b> - 允许dnsmasq作为您的LAN上的DNS服务器.</li>
				<li><b>使用获取和自定义DNS</b> - 将从WAN连接接收的DNS服务器添加到静态DNS服务器列表 (看 <a href='#basic-network.asp'>这里</a> 的设置).</li>
				<li><b>防止DNS污染</b> - 在Dnsmasq上启用DNS污染保护.</li>
				<li><b>拦截DNS端口</b> - 任何发送到UDP端口53的DNS请求/数据包都将重定向到内部DNS服务器.</li>
				<li><b>WAN禁用则使用自定义网关</b> - DHCP将使用路由器的IP地址作为每个LAN上的默认网关.</li>
				<li><b>忽略DHCP请求 (...)</b> - Dnsmasq将忽略对仅列出的MAC地址的DHCP请求在 <a href='#basic-static.asp'>静态 DHCP/ARP</a> 里的计算机将无法通过DHCP获取IP地址.</li>
				<li><b>最大活动DHCP租期</b> - 自行百度.</li>
				<li><b>静态租期时间</b> - 允许任何DHCP租用有效的绝对最大时间量.</li>
				<li><b>自定义配置</b> - 要添加到Dnsmasq配置文件的额外选项.</li>
				</ul>

				<i>DHCP 客户端 (WAN):</i><br>
				<ul>
				<li><b>DHCPC 选项</b> - DHCP客户端的额外选项.</li>
				<li><b>减少包大小</b> - 自行百度.</li>
				</ul>
				<i>其他相关注意事项/提示:</i><br>
				<ul>
				<li>文件/etc/dnsmasq.custom的内容也被添加到Dnsmasq配置文件的结尾（如果存在）.</li>
				</ul>
			</div>
		</div>

		<button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">保存 <i class="icon-check"></i></button>
		<button type="button" value="Cancel" id="cancel-button" onclick="javascript:reloadPage();" class="btn">取消 <i class="icon-cancel"></i></button>
		<span id="footer-msg" class="alert alert-warning" style="visibility: hidden;"></span>

	</form>

	<script type="text/javascript">init(); verifyFields(null, true);</script>
</content>
