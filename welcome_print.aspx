<%@ Page Language="C#" AutoEventWireup="true" CodeFile="welcome_print.aspx.cs" Inherits="julia.web.welcome_print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" rev="stylesheet" href="css/register.css" type="text/css" media="screen"
			charset='gb2312"' />
</head>
<body>
   <form id="form1" runat="server"  >
<div id="formwrapper">
    
<!--
<fieldset>
<legend>注册成功！</legend>
<div>
<label for="Name">用户名</label>
<input type="text" name="Name" id="Name" size="18" maxlength="30" />
<br/>
</div>
<div>
<label for="password">密码</label>
<input type="password" name="password" id="password" size="18" maxlength="30" />
<br/>
</div>
<div class="cookiechk">
<label>
<input type="checkbox" name="CookieYN" id="CookieYN" value="1" />
<a href="#" title="选择是否记录您的信息">记住我</a></label>
<input name="login791" type="submit" class="buttom" value="登录" />
</div>
<div class="forgotpass"><a href="#">您忘记密码?</a></div>
</fieldset> -->
    <asp:Image ID="Image1" runat="server" ImageUrl="" />
<br/><br/><br/>
<h3 style="font-family: 新宋体; font-size: small; color: #FF0000;">注册成功！！欢迎你！</h3>
<fieldset >
<legend>注册说明</legend>
<p ><strong >请登录！！
    </strong></p>
<div>
    <strong >
    <p>登录名：<asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red"></asp:Label></p>

   <p> 登录密码：<asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label></p>

    </strong>
</div>
</fieldset>
<!--<fieldset >
<legend>打印说明</legend>
<p ><strong >请打印
    <asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/战略合作协议（样本）.doc" ForeColor="Red" Target="_blank" >用户合作协议</asp:HyperLink>
    ，并加盖公章，邮寄到国家超级计算济南中心！</strong></p>
<div>
</div>
</fieldset> -->   
</div>
</form>
</body>
</html>
