<html>
    <head><title>固件升级</title>
    <script type="text/javascript">
    function upgrade() {
        document.form_upgrade.submit();
    }
    </script>
    </head>
    <body>
        <h1>固件升级</h1>
        <b>警告:</b>
        <ul>
            <li>此页面中没有上传状态信息，也不会有
             在按下升级按钮后显示中的更改。 你会看到一个
             新页面只有在升级完成后。
            <li>升级可能需要3分钟才能完成。 不要中断
             路由器电源或浏览器。
        </ul>
        <br>
        <form name="form_upgrade" method="post" action="upgrade.cgi?_http_id=<% nv(http_id); %>" encType="multipart/form-data">
            <label>选择要使用的文件:</label>
            <input type="file" name="file" size="50"> <button type="button" value="Upgrade" id="afu-upgrade-button" onclick="upgrade()" class="btn btn-danger">升级</button>
        </form>
    </body>
</html>