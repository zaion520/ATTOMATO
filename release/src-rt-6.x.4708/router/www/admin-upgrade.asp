<!--
Tomato GUI
Copyright (C) 2006-2010 Jonathan Zarate
http://www.polarcloud.com/tomato/

For use with Tomato Firmware only.
No part of this file may be used without permission.
--><title>固件升级</title>
<content>
	<style>
		#afu-progress {
			display: block;
			position: fixed;
			top: 0;
			right: 0;
			left: 0;
			bottom: 0;
			z-index: 20;
			background: #fff;
			color: #5A5A5A;
			opacity: 0;
			transition: opacity 250ms ease-out;
		}

		#afu-progress .text-container {
			position: absolute;
			display: block;
			text-align: center;
			font-size: 14px;
			width: 100%;
			height: 150px;
			top: 30%;
			margin-top: -75px;
			transform: scale(0.2);
			transition: all 350ms ease-out;
		}

		#afu-progress.active {
			opacity: 1;
		}

		#afu-progress.active .text-container {
			transform: scale(1);
			top: 40%;
		}
		
		.line-table tr { background: transparent !important; }
		.line-table tr:last-child { border: 0; }
	</style>
	<script type="text/javascript">
		// <% nvram("jffs2_on"); %>

		function clock()
		{
			var t = ((new Date()).getTime() - startTime) / 1000;
			elem.setInnerHTML('afu-time', Math.floor(t / 60) + ':' + Number(Math.floor(t % 60)).pad(2));
		}
		function upgrade() {
			var name;
			var i;
			var fom = document.form_upgrade;
			var ext;
			name = fixFile(fom.file.value);

			if (name.search(/\.(bin|trx|chk)$/i) == -1) {
				alert('支持 ".bin", ".trx" or ".chk" 文件。');
				return false;
			}

			if (!confirm('你确定要刷这个固件 ' + name + '?')) return;
			E('afu-upgrade-button').disabled = true;

			// Some cool things
			$('#wrapper > .content').css('position', 'static');
			$('#afu-progress').clone().prependTo('#wrapper').show().addClass('active');
			startTime = (new Date()).getTime();
			setInterval('clock()', 500);

			fom.action += '?_reset=' + (E('f_reset').checked ? "1" : "0");
			form.addIdAction(fom);
			fom.submit();
		}
	</script>
	<div id="afu-input">

		<div class="alert alert-warning icon">
			<h5>注意!</h5>有时下载的固件会出现损坏，为避免出现问题，请验证MD5校验值(<a target="_blank" href="http://en.wikipedia.org/wiki/Checksum"><i class="icon-info"></i></a>)  ，然后再尝试刷路由器。
			<a class="close"><i class="icon-cancel"></i></a>
		</div>

		<form name="form_upgrade" method="post" action="upgrade.cgi" encType="multipart/form-data">

			<div class="box">
				<div class="heading">路由升级</div>
				<div class="content">

					<fieldset>
						<label class="control-left-label col-sm-3">选择固件:</label>
						<div class="col-sm-9"><input class="uploadfile" type="file" name="file" size="50">
							<button type="button" value="Upgrade" id="afu-upgrade-button" onclick="upgrade();" class="btn btn-danger">升级 <i class="icon-upload"></i></button>
						</div>
					</fieldset>

					<fieldset>
						<label class="control-left-label col-sm-3" for="f_reset">恢复默认</label>
						<div class="col-sm-9">
							<div id="reset-input">
								<div class="checkbox c-checkbox"><label><input class="custom" type="checkbox" id="f_reset">
									<span class="icon-check"></span> &nbsp; 升级固件后，擦除NVRAM内存中的所有数据</label>
								</div>
							</div>
						</div>
					</fieldset>

				</div>
			</div>

			<div class="box">
				<div class="heading">路由器信息</div>
				<div class="content">
					<table class="line-table" id="version-table">
						<tr><td>当前版本:</td><td>&nbsp; <% version(1); %></td></tr>
					</table>
				</div>
			</div>

			<div id="afu-progress" style="display:none;">
				<div class="text-container">
					<div class="spinner spinner-large"></div><br /><br />
					<b id="afu-time">0:00</b><br />
					正在上传并升级固件，请稍候... <br />
					<b>升级期间不要中断网络浏览器或路由器电源！</b>
				</div>
			</div>
		</form>
	</div>

	/* JFFS2-BEGIN */
	<div class="alert alert-error" style="display:none;" id="jwarn">
		<h5>禁止升级!</h5>
		升级可能会覆盖当前使用的JFFS分区。 升级前，
请备份JFFS分区的内容，禁用JFFS后，然后重新启动路由器再升级。
		<a href="/#admin-jffs2.asp">禁用 &raquo;</a>
	</div>
	<script type="text/javascript">
		//	<% sysinfo(); %>
		$('#version-table').append('<tr><td>空闲内存:</td><td>&nbsp; ' + scaleSize(sysinfo.totalfreeram) + ' &nbsp; <small>(可以完全缓存在RAM中)</small></td></tr>');

		if (nvram.jffs2_on != '0') {
			E('jwarn').style.display = '';
			E('afu-input').style.display = 'none';
		}
	</script>
	/* JFFS2-END */
</content>