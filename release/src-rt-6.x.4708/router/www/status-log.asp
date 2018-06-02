<title>
    路由日志
</title>
<content>
    <script type="text/javascript">
        //<% nvram("at_update,tomatoanon_answer,log_file"); %>
        function find() {
            var s = E('find-text').value;
            if (s.length) document.location = 'logs/view.cgi?find=' + escapeCGI(s) + '&_http_id=' + nvram.http_id;
        }

        function init() {
            var e = E('find-text');
            if (e) e.onkeypress = function(ev) {
                if (checkEvent(ev).keyCode == 13) find();
            }
        }
    </script>
    <div class="box">
        <div class="heading">
            路由器日志
            <a class="ajaxload pull-right" data-toggle="tooltip" title="Configure Logging"
            href="#admin-log.asp">
                <i class="icon-system">
                </i>
            </a>
        </div>
        <div class="content">
            <div id="logging">
                <div class="section">
                    <a href="logs/view.cgi?which=25&_http_id=<% nv(http_id) %>">
                        显示最后 25 行
                    </a>
                    <br />
                    <a href="logs/view.cgi?which=50&_http_id=<% nv(http_id) %>">
                        显示最后 50 Lines
                    </a>
                    <br />
                    <a href="logs/view.cgi?which=100&_http_id=<% nv(http_id) %>">
                        显示最后 100 Lines
                    </a>
                    <br />
                    <a href="logs/view.cgi?which=all&_http_id=<% nv(http_id) %>">
                        显示全部
                    </a>
                    <br />
                    <br />
                    <div class="input-append">
                        <input class="span3" type="text" maxsize="32" id="find-text">
                        <button value="Find" onclick="find()" class="btn">
                            查找
                            <i class="icon-search">
                            </i>
                        </button>
                    </div>
                    <i>
                        在可用日志文件中搜索特定文本并显示匹配的行
                    </i>
                    <br>
                    <br />
                    <hr>
                    <a class="btn btn-primary" href="logs/syslog.txt?_http_id=<% nv(http_id) %>">
                        下载日志文件
                        <i class="icon-download">
                        </i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        if (nvram.log_file != '1') {
            $('#logging').before('<div class="alert alert-info">路由器日志已被禁用.</b><br><br><a href="#admin-log.asp">启用日志 &raquo;</a></div>');
            E('logging').style.display = 'none';
        }
    </script>
    <script type="text/javascript">
        init()
    </script>