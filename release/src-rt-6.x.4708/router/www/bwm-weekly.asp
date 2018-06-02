<!--
Tomato GUI
Copyright (C) 2006-2010 Jonathan Zarate
http://www.polarcloud.com/tomato/

For use with Tomato Firmware only.
No part of this file may be used without permission.
-->
<title>带宽监控: 每周</title>
<content>
	<style>
		table tr td { width: 25%; }
		.total { font-weight: 500; }
	</style>
	<script type="text/javascript" src="js/bwm-hist.js"></script>
	<script type="text/javascript">
		//<% nvram("wan_ifname,wan2_ifname,wan3_ifname,wan4_ifname,lan_ifname,rstats_enable"); %>

		try {
			//	<% bandwidth("daily"); %>
		}
		catch (ex) {
			daily_history = [];
		}
		rstats_busy = 0;
		if (typeof(daily_history) == 'undefined') {
			daily_history = [];
			rstats_busy = 1;
		}

		var weeks = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
var weeksShort = ['日', '一', '二', '三', '四', '五', '六'];
		var startwk = 0;
		var summary = 1;

		function save()
		{
			cookie.set('weekly', scale + ',' + startwk + ',' + summary, 31);
		}

		function changeStart(e)
		{
			startwk = e.value * 1;
			redraw();
			save();
		}

		function changeMode(e)
		{
			summary = e.value * 1;
			redraw();
			save();
		}

		function nth(n)
		{
			n += '';
			switch (n.substr(n.length - 1, 1)) {
				case '1':
					return n + 'st';
				case '2':
					return n + 'nd';
				case '3':
					return n + 'rd';
			}
			return n + 'th';
		}

		function redraw()
		{
			var h;
			var grid;
			var block;
			var rows;
			var dend;
			var dbeg;
			var dl, ul;
			var d, diff, ds;
			var tick, lastSplit;
			var yr, mo, da, wk;
			var gn;
			var swk;

			rows = 0;
			block = [];
			gn = 0;
			w = 0;
			lastSplit = 0;
			ul = dl = 0;
			dend = dbeg = '';

			swk	= startwk - 1;
			if (swk < 0) swk = 6;

			if (summary) {
				grid = '<table class="line-table">';
				grid += '<tr><td><b>日期</b></td><td><b>下行</b></td><td><b>上行</b></td><td><b>总计</b></td></tr>';
			}
			else {
				grid = '';
			}

			function flush_block()
			{
				grid += '<h5>' + dbeg + ' to ' + dend + '</h5>' +
				'<table class="line-table">' +
				'<tr><td><b>日期</b></td><td><b>下行</b></td><td><b>上行</b></td><td><b>总计</b></td></tr>' +
				block.join('') +
				makeRow('bold', '总计', rescale(dl), rescale(ul), rescale(dl + ul)) +
				'</table><br>';
			}

			for (i = 0; i < daily_history.length; ++i) {
				h = daily_history[i];
				yr = (((h[0] >> 16) & 0xFF) + 1900);
				mo = ((h[0] >>> 8) & 0xFF);
				da = (h[0] & 0xFF);
				d = new Date(yr, mo, da);
				wk = d.getDay();

				tick = d.getTime();
				diff = lastSplit - tick;

				ds = ymdText(yr, mo, da) + ' <small>(' + weeksShort[wk] + ')</small>';

				/*	REMOVE-BEGIN

				Jan 2007
				SU MO TU WE TH FR SA
				01 02 03 04 05 06
				07 08 09 10 11 12 13
				14 15 16 17 18 19 20
				21 22 23 24 25 26 27
				28 29 30 31

				Feb 2007
				SU MO TU WE TH FR SA
				01 02 03
				04 05 06 07 08 09 10
				11 12 13 14 15 16 17
				18 19 20 21 22 23 24
				25 26 27 28

				Mar 2007
				SU MO TU WE TH FR SA
				01 02 03
				04 05 06 07 08 09 10
				11 12 13 14 15 16 17
				18 19 20 21 22 23 24
				25 26 27 28 29 30 31

				REMOVE-END */

				if ((wk == swk) || (diff >= (7 * 86400000)) || (lastSplit == 0)) {
					if (summary) {
						if (i > 0) {
							grid += makeRow(((rows & 1) ? 'odd' : 'even'),
								dend + '<br>' + dbeg, rescale(dl), rescale(ul), rescale(dl + ul));
							++rows;
							++gn;
						}
					}
					else {
						if (rows) {
							flush_block();
							++gn;
						}
						block = [];
						rows = 0;
					}
					dl = ul = 0;
					dend = ds;
					lastSplit = tick;
				}

				dl += h[1];
				ul += h[2];
				if (!summary) {
					block.unshift(makeRow(((rows & 1) ? 'odd' : 'even'), weeks[wk] + ' <small>' + (mo + 1) + '-' + da + '</small>', rescale(h[1]), rescale(h[2]), rescale(h[1] + h[2])))
					++rows;
				}

				dbeg = ds;
			}

			if (summary) {
				if (gn < 9) {
					grid += makeRow(((rows & 1) ? 'odd' : 'even'),
						dend + '<br>' + dbeg, rescale(dl), rescale(ul), rescale(dl + ul));
				}
				grid += '</table>';
			}
			else {
				if ((rows) && (gn < 9)) {
					flush_block();
				}
			}
			E('bwm-weekly-grid').innerHTML = grid;
		}

		function init()
		{
			var s;

			if (nvram.rstats_enable != '1') { $('#rstats').before('<div class="alert alert-warning">带宽监控已禁用.</b> <a href="/#admin-bwm.asp">启用 &raquo;</a></div>'); return; }

			if ((s = cookie.get('weekly')) != null) {
				if (s.match(/^([0-2]),([0-6]),([0-1])$/)) {
					E('scale').value = scale = RegExp.$1 * 1;
					E('startwk').value = startwk = RegExp.$2 * 1
					E('shmode').value = summary = RegExp.$3 * 1;
				}
			}

			initDate('ymd');
			daily_history.sort(cmpHist);
			redraw();
		}
	</script>

	<ul class="nav-tabs">
<li><a class="ajaxload" href="bwm-realtime.asp"><i class="icon-hourglass"></i> 实时</a></li>
<li><a class="ajaxload" href="bwm-24.asp"><i class="icon-graphs"></i> 最近24小时</a></li>
<li><a class="ajaxload" href="bwm-daily.asp"><i class="icon-clock"></i> 每日</a></li>
<li><a class="active"><i class="icon-week"></i> 每周</a></li>
<li><a class="ajaxload" href="bwm-monthly.asp"><i class="icon-month"></i> 每月</a></li>
</ul>
<div id="rstats" class="box">
<div class="heading">每周带宽监控 <a class="pull-right" href="#" data-toggle="tooltip" title="重新加载信息" onclick="reloadPage(); return false;"><i class="icon-refresh"></i></a></div>
<div class="content">
<div id="bwm-weekly-grid"></div>
</div>
</div>
<a href="admin-bwm.asp" class="btn btn-danger ajaxload">配置 <i class="icon-tools"></i></a>
<span class="pull-right">
<b>显示</b> <select onchange="changeMode(this)" id="shmode"><option value="1" selected>概要<option value="0">全部</select> &nbsp;
<b>日期</b> <select onchange="changeDate(this, 'ymd')" id="dafm"><option value="0">yyyy-mm-dd</option><option value="1">mm-dd-yyyy</option><option value="2">mmm dd, yyyy</option><option value="3">dd.mm.yyyy</option></select>  &nbsp;
<b>星期</b> <select onchange="changeStart(this)" id="startwk"><option value="0" selected>日<option value="1">一<option value="2">二<option value="3">三<option value="4">四<option value="5">五<option value="6">六</select>  &nbsp;
<b>单位</b> <select onchange="changeScale(this)" id="scale"><option value="0">KB</option><option value="1">MB</option><option value="2" selected>GB</option></select> &nbsp;
</span>
<script type="text/javascript">init()</script>
</content>