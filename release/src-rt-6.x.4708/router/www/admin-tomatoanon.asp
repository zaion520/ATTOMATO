<!--
Tomato GUI
Copyright (C) 2012 Shibby
http://openlinksys.info
For use with Tomato Firmware only.
No part of this file may be used without permission.
--><title>番茄统计计划</title>
<content>
	<script type="text/javascript">
		//	<% nvram("tomatoanon_enable,tomatoanon_answer,tomatoanon_id"); %>
		$('.anonlink').append('<a title="Check out my router" class="pull-right" href="http://anon.groov.pl/?search=9&routerid=<% nv('tomatoanon_id'); %>" target="_blank"><i class="icon-forward"></i></a>');
		function verifyFields(focused, quiet)
		{
			var o = (E('_tomatoanon_answer').value == '1');
			E('_tomatoanon_enable').disabled = !o;
			var s = (E('_tomatoanon_enable').value == '1');
			return 1;
		}
		function save()
		{
			if (verifyFields(null, 0)==0) return;
			var fom = E('_fom');
			fom._service.value = 'tomatoanon-restart';
			form.submit('_fom', 1);
		}
		function init()
		{
			var anon = true;
		}

		function submit_complete()
		{
			document.location.reload();
		}
	</script>


	<form id="_fom" method="post" action="tomato.cgi">
<input type="hidden" name="_nextpage" value="/#admin-tomatoanon.asp">
<input type="hidden" name="_service" value="tomatoanon-restart">
<div class="box">
<div class="heading">关于TomatoAnon项目</div>
<div class="content">
<p>我想向您介绍一个新的项目，我一直在努力，为tomatoanon。
该TomatoAnon脚本将信息发送到你的路由器的型号和Tomato安装版的在线数据库。
提交的信息是100％匿名的，并且将只用于统计目的。
<b>这个脚本不会收集或传送任何（如MAC地址，IP地址等），任何私人或个人信息！</b>
The TomatoAnon脚本是完全开放的，并写入在bash。每个人都免费看收集并传送到数据库中的信息..
</p>
<p>所收集的数据在此 <a href="http://anon.groov.pl/" target="_blank"><b>TomatoAnon统计</b></a>页。<br>
此信息可以帮助帮助您选择您所在的国家或地区可用的最佳和最流行的路由器。
可以找到最常用的Tomato版本和哪个版本是在每个路由器模型最稳定。
该TomatoAnon脚本可以在你喜欢不提供数据或与被收集的数据不舒服的情况下，禁用..
在任何时候您可以随时重新启用它。
</p>
<p>将以下的数据收集和TomatoAnon发送:</p>
<ul>
<li>WAN+ LAN的MAC地址MD5SUM - 这提供了一个唯一的标识符每个路由器，例如: 1c1dbd4202d794251ec1acf1211bb2c8</li>
<li>路由器的型号，例如: Asus RT-N66U</li>
<li>Tomato安装版本号, 例如: 102 K26 USB</li>
<li>构建类型，例如: Mega-VPN-64K</li>
<li>国家，例如: China</li>
<li>ISO国家代码，例如: PL</li>
<li>路由器的正常运行时间，例如: 3 天</li>
<li>这就是以上！！</li>
</ul>
<p>感谢您的阅读，并请作出正确的选择，以帮助这个项目。</p><br />
<h3>Tomato更新通知</h3>
<p>
先进Tomato包括增加的TomatoAnon脚本提供一种自动更新检查机制。
由于TomatoAnon脚本发送收集到的数据回TomatoAnon项目，该脚本还会检查AdvancedTomato与可用的最新版本已安装的版本。
就像TomatoAnon，代码是免费提供观看，以确保正在收集任何其他敏感信息。
</p><br />
<h4>它是如何工作的?</h4>
<p>高级检索Tomato路由器的当前版本，Tomato，并创建看起来像这样在页面上的一个小环节: <b><a target="_blank" href="http://advancedtomato.com/update.php?v=1.06.08">http://advancedtomato.com/update.php?v=1.06.08</a></b>.
Web浏览器将跟随链接和AdvancedTomato服务器发送一个响应指示更新的版本是否可用。<br>
这就是以上！！
</p>
</div>
</div>
<div class="box anon">
<div class="heading anonlink">TomatoAnon设置</div>
<div class="content"></div>
<script type="text/javascript">
$('.box.anon .content').forms([
{ title: '您了解TomatoAnon是什么吗?', name: 'tomatoanon_answer', type: 'select', options: [ ['0','我不清楚，我必须在读完所有信息后才能做出选择.'], ['1','是的，我了解并且希望选择它.'] ], value: nvram.tomatoanon_answer, suffix: ' '},
{ title: '您想启用TomatoAnon吗?', name: 'tomatoanon_enable', type: 'select', options: [ ['-1','现在还不想.'], ['1','是的，我确定要启用'], ['0','我丝毫不感兴趣也不想启用它'] ], value: nvram.tomatoanon_enable, suffix: ' '}
]);
</script>
</div>
<button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">保存 <i class="icon-check"></i></button>
<button type="button" value="Cancel" id="cancel-button" onclick="javascript:reloadPage();" class="btn">取消 <i class="icon-cancel"></i></button>
<span id="footer-msg" class="alert alert-warning" style="visibility: hidden;"></span>
</form>
<script type="text/javascript">verifyFields(null, 1); init();</script>
</content>