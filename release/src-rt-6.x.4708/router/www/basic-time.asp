<!-- Tomato GUI Copyright (C) 2006-2010 Jonathan Zarate http://www.polarcloud.com/tomato/
For use with Tomato Firmware only. No part of this file may be used without
permission. -->
<title>
    Time
</title>
<content>
    <script type="text/javascript">
        //	<% nvram("at_update,tomatoanon_answer,tm_sel,tm_dst,tm_tz,ntp_updates,ntp_server,ntp_tdod,ntp_kiss"); %>
        var ntpList = [['custom', '自定义...'], ['', '默认'], ['africa', '非洲'], ['asia', '亚洲'], ['europe', '欧洲'], ['oceania', '大洋洲'], ['north-america', '北美洲'], ['south-america', '南美洲'], ['us', '美国']];

        function ntpString(name) {
            if (name == '') name = 'pool.ntp.org';
            else name = name + '.pool.ntp.org';
            return '0.' + name + ' 1.' + name + ' 2.' + name;
        }

        function verifyFields(focused, quiet) {
            var ok = 1;

            var s = E('_tm_sel').value;
            var f_dst = E('_f_tm_dst');
            var f_tz = E('_f_tm_tz');
            if (s == 'custom') {
                f_dst.disabled = true;
                f_tz.disabled = false;
                PR(f_dst).style.display = 'none';
                PR(f_tz).style.display = '';
            } else {
                f_tz.disabled = true;
                PR(f_tz).style.display = 'none';
                PR(f_dst).style.display = '';
                if (s.match(/^([A-Z]+[\d:-]+)[A-Z]+/)) {
                    if (!f_dst.checked) s = RegExp.$1;
                    f_dst.disabled = false;
                } else {
                    f_dst.disabled = true;
                }
                f_tz.value = s;
            }

            var a = 1;
            var b = 1;
            switch (E('_ntp_updates').value * 1) {
            case - 1 : b = 0;
            case 0:
                a = 0;
                break;
            }
            elem.display(PR('_f_ntp_tdod'), a);

            elem.display(PR('_f_ntp_server'), b);
            a = (E('_f_ntp_server').value == 'custom');
            elem.display(PR('_f_ntp_1'), PR('_f_ntp_2'), PR('_f_ntp_3'), a && b);

            elem.display(PR('ntp-preset'), !a && b);

            if (a) {
                if ((E('_f_ntp_1').value == '') && (E('_f_ntp_2').value == '') && ((E('_f_ntp_3').value == ''))) {
                    ferror.set('_f_ntp_1', '至少需要一个NTP服务器', quiet);
                    return 0;
                }
            } else {
                E('ntp-preset').innerHTML = ntpString(E('_f_ntp_server').value).replace(/\s+/, ', ');
            }

            ferror.clear('_f_ntp_1');
            return 1;
        }

        function save(clearKiss) {
            if (!verifyFields(null, 0)) return;

            var fom, a, i;

            fom = E('_fom');
            fom.tm_dst.value = fom.f_tm_dst.checked ? 1 : 0;
            fom.tm_tz.value = fom.f_tm_tz.value;

            if (E('_f_ntp_server').value != 'custom') {
                fom.ntp_server.value = ntpString(E('_f_ntp_server').value);
            } else {
                a = [fom.f_ntp_1.value, fom.f_ntp_2.value, fom.f_ntp_3.value];
                for (i = 0; i < a.length;) {
                    if (a[i] == '') a.splice(i, 1);
                    else++i;
                }
                fom.ntp_server.value = a.join(' ');
            }

            fom.ntp_tdod.value = fom.f_ntp_tdod.checked ? 1 : 0;
            fom.ntp_kiss.disabled = !clearKiss;
            form.submit(fom);
        }

        function earlyInit() {
            if (nvram.ntp_kiss != '') {
                E('ntpkiss-ip').innerHTML = nvram.ntp_kiss;
                E('ntpkiss').style.display = '';
            }
            verifyFields(null, 1);
        }
    </script>
    <form id="_fom" method="post" action="tomato.cgi">
        <input type="hidden" name="_nextpage" value="/#basic-time.asp">
        <input type="hidden" name="_nextwait" value="5">
        <input type="hidden" name="_service" value="ntpc-restart">
        <input type="hidden" name="_sleep" value="3">
        <input type="hidden" name="tm_dst">
        <input type="hidden" name="tm_tz">
        <input type="hidden" name="ntp_server">
        <input type="hidden" name="ntp_tdod">
        <input type="hidden" name="ntp_kiss" value="" disabled>
        <div class="box">
            <div class="heading">
                系统时间设置
            </div>
            <div class="content">
                <div id="timesec" class="section">
                </div>
                <script type="text/javascript">
                    ntp = nvram.ntp_server.split(/\s+/);

                    ntpSel = 'custom';
                    for (i = ntpList.length - 1; i > 0; --i) {
                        if (ntpString(ntpList[i][0]) == nvram.ntp_server) ntpSel = ntpList[i][0];
                    }

                    /* REMOVE-BEGIN

					http://tldp.org/HOWTO/TimePrecision-HOWTO/tz.html
					http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html

					Canada
					http://www3.sympatico.ca/c.walton/canada_dst.html
					http://home-4.tiscali.nl/~t876506/Multizones.html#ca
					http://www3.sympatico.ca/c.walton/canada_dst.html

					Brazil
					http://www.timeanddate.com/worldclock/clockchange.html?n=233
					http://www.timeanddate.com/worldclock/city.html?n=479

					Finland
					http://www.timeanddate.com/worldclock/city.html?n=101

					New Zeland
					http://www.dia.govt.nz/diawebsite.nsf/wpg_URL/Services-Daylight-Saving-Index

					Australia
					http://en.wikipedia.org/wiki/Time_in_Australia
					http://www.timeanddate.com/library/abbreviations/timezones/au/

					REMOVE-END */

                    $('#timesec').forms([{
                        title: '路由时间',
                        text: '<span id="clock"><% time(); %></span>'
                    },
                    {
                        title: '时区',
                        name: 'tm_sel',
                        type: 'select',
                        options: [['custom', '自定义...'], ['UTC12', 'UTC-12:00 夸贾林环礁(位于太平洋西部)'], ['UTC11', 'UTC-11:00 中途岛，萨摩亚'], ['UTC10', 'UTC-10:00 夏威夷'], ['NAST9NADT,M3.2.0/2,M11.1.0/2', 'UTC-09:00 阿拉斯加州'], ['PST8PDT,M3.2.0/2,M11.1.0/2', 'UTC-08:00 太平洋时间'], ['UTC7', 'UTC-07:00 亚利桑那州'], ['MST7MDT,M3.2.0/2,M11.1.0/2', 'UTC-07:00 山地时间'], ['UTC6', 'UTC-06:00 墨西哥'], ['CST6CDT,M3.2.0/2,M11.1.0/2', 'UTC-06:00 中部时间'], ['UTC5', 'UTC-05:00 哥伦比亚,巴拿马到'], ['EST5EDT,M3.2.0/2,M11.1.0/2', 'UTC-05:00 东部时间'], ['VET4:30', 'UTC-04:30 委内瑞拉'], ['UTC4', 'UTC-04:00 阿鲁巴,百慕大,圭亚那,波多黎各'], ['BOT4', 'UTC-04:00 玻利维亚'], ['AST4ADT,M3.2.0/2,M11.1.0/2', 'UTC-04:00 大西洋时间'], ['BRWST4BRWDT,M10.3.0/0,M2.5.0/0', 'UTC-04:00 巴西西部'], ['NST3:30NDT,M3.2.0/0:01,M11.1.0/0:01', 'UTC-03:30 纽芬兰'], ['WGST3WGDT,M3.5.6/22,M10.5.6/23', 'UTC-03:00 格陵兰'], ['BRT3BRST,M10.3.0/0,M2.3.0/0', 'UTC-03:00 巴西东部'], ['UTC3', 'UTC-03:00 阿根廷,法属圭亚那,苏里南'], ['UTC2', 'UTC-02:00 中部大西洋'], ['STD1DST,M3.5.0/2,M10.5.0/2', 'UTC-01:00 亚速尔群岛'], ['UTC0', 'UTC+00:00 冈比亚,利比里亚,摩洛哥'], ['GMT0BST,M3.5.0/2,M10.5.0/2', 'UTC+00:00 英国'], ['UTC-1', 'UTC+01:00 突尼斯'], ['CET-1CEST,M3.5.0/2,M10.5.0/3', 'UTC+01:00 法国,德国,意大利,波兰,瑞典'], ['EET-2EEST-3,M3.5.0/3,M10.5.0/4', 'UTC+02:00 爱沙尼亚,芬兰,拉脱维亚,立陶宛'], ['UTC-2', 'UTC+02:00 南非,以色列'], ['STD-2DST,M3.5.0/2,M10.5.0/2', 'UTC+02:00 希腊,乌克兰,罗马尼亚,土耳其,拉脱维亚'], ['UTC-3', 'UTC+03:00 伊拉克,约旦,加里宁格勒,科威特'], ['UTC-4', 'UTC+04:00 莫斯科,阿曼,阿拉伯联合酋长国'], ['AMT-4AMST,M3.5.0,M10.5.0/3', 'UTC+04:00 亚美尼亚'], ['UTC-4:30', 'UTC+04:30 喀布尔'], ['UTC-5', 'UTC+05:00 巴基斯坦'], ['UTC-5:30', 'UTC+05:30 孟买,加尔各答,马德拉斯,新德里'], ['UTC-6', 'UTC+06:00 孟加拉国,叶卡捷琳堡'], ['UTC-7', 'UTC+07:00 鄂木斯克,泰国'], ['UTC-8', 'UTC+08:00 中国, 香港,克拉斯诺亚尔斯克,西澳大利,亚州,新加坡,台湾'], ['UTC-9', 'UTC+09:00 伊尔库茨克,日本,韩国'], ['ACST-9:30ACDT,M10.1.0/2,M4.1.0/3', 'UTC+09:30 南澳大利亚'], ['ACST-9:30', 'UTC+09:30 达尔文'], ['AEST-10AEDT,M10.1.0,M4.1.0/3', 'UTC+10:00 澳大利亚'], ['AEST-10', 'UTC+10:00 布里斯班,雅库茨克'], ['UTC-11', 'UTC+11:00 所罗门群岛,关岛,符拉迪沃斯托克'], ['UTC-12', 'UTC+12:00 斐济,马加丹'], ['NZST-12NZDT,M9.5.0/2,M4.1.0/3', 'UTC+12:00 新西兰']],
                        value: nvram.tm_sel
                    },
                    {
                        title: '自动夏令时间',
                        indent: 2,
                        name: 'f_tm_dst',
                        type: 'checkbox',
                        value: nvram.tm_dst != '0'
                    },
                    {
                        title: '自定义时区名称',
                        indent: 2,
                        name: 'f_tm_tz',
                        type: 'text',
                        maxlen: 32,
                        size: 34,
                        value: nvram.tm_tz || ''
                    },
                    null, {
                        title: '自动更新时间',
                        name: 'ntp_updates',
                        type: 'select',
                        options: [[ - 1, '不更新'], [0, '开机更新'], [1, '每小时'], [2, '每2小时'], [4, '每4小时'], [6, '每6小时'], [8, '每8小时'], [12, '每12小时'], [24, '每24小时']],
                        value: nvram.ntp_updates
                    },
                    {
                        title: '按需触发连接',
                        indent: 2,
                        name: 'f_ntp_tdod',
                        type: 'checkbox',
                        value: nvram.ntp_tdod != '0'
                    },
                    {
                        title: 'NTP时间服务器',
                        name: 'f_ntp_server',
                        type: 'select',
                        options: ntpList,
                        value: ntpSel
                    },
                    {
                        title: '&nbsp;',
                        text: '<small><span id="ntp-preset">xx</span></small>',
                        hidden: 1
                    },
                    {
                        title: '',
                        name: 'f_ntp_1',
                        type: 'text',
                        maxlen: 48,
                        size: 50,
                        value: ntp[0] || 'pool.ntp.org',
                        hidden: 1
                    },
                    {
                        title: '',
                        name: 'f_ntp_2',
                        type: 'text',
                        maxlen: 48,
                        size: 50,
                        value: ntp[1] || '',
                        hidden: 1
                    },
                    {
                        title: '',
                        name: 'f_ntp_3',
                        type: 'text',
                        maxlen: 48,
                        size: 50,
                        value: ntp[2] || '',
                        hidden: 1
                    }]);
                </script>
                <div id="ntpkiss" style="display:none">
                    以下NTP服务器已无法使用:
                    <b id="ntpkiss-ip">
                    </b>
                    <div>
                        <input type="button" value="Clear" onclick="save(1)" class="btn">
                    </div>
                </div>
            </div>
        </div>
    </form>
    <button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">
        保存
        <i class="icon-check">
        </i>
    </button>
    <button type="button" value="Cancel" id="cancel-button" onclick="javascript:reloadPage();"
    class="btn">
        取消
        <i class="icon-cancel">
        </i>
    </button>
    <span id="footer-msg" class="alert alert-warning" style="visibility: hidden;">
    </span>
    <script type='text/javascript'>
        earlyInit()
    </script>
</content>