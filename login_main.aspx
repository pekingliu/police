<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login_main.aspx.cs" Inherits="julia.web.login" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <style>#pic{max-width:1600px; max-height:600px}</style>
    <style type="text/css">
   <STYLE TYPE="text/css">
    <!--BODY{background-position: center;background-repeat: no-repeat;background-attachment: fixed;}
    -->
    </STYLE>

    
    <%--<style>#pic{size:autosize}</style>--%>
    <script type="text/javascript" src="treedata_js/tree_data.js"></script>
    <script type="text/javascript" src="treedata_js/cookie.js"></script>  
    <script type="text/javascript" src="treedata_js/nobackspace.js  "></script>      
    <script src="jquery-easyui-1.2.6/jquery-1.7.2.min.js" type="text/javascript" > </script>    
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.2.6/themes/icon.css" />
    <link href="jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css" />  
     
    <script type="text/javascript" >
    document.onkeydown = function(e){
    var event = e || window.event;  
    var code = event.keyCode || event.which || event.charCode;
    if (code == 13) {
        login();
    }
    }
    function cleardata(){
        $('#loginForm').form('clear');
    }
    function login(){
         if($("input[name='login']").val()=="" || $("input[name='password']").val()==""){
             $("#showMsg").html("用户名或密码为空，请输入");
             $("input[name='login']").focus();
        }else{
//               alert("ajax");
               //ajax异步提交  
               $.ajax({  
                      global: false,
                      cache: false,
                      async: true,                       
                      type:"POST",   //post提交方式默认是get
                      url:"Ajaxhandle/login_verify.ashx", 
                      data:$("#loginForm").serialize(),   //序列化   { "username": $("#ipt_username").val(),"userpwd":$("#ipt_userpwd").val() },             
                      error:function(request) {      // 设置表单提交出错                                       
                          $("#showMsg").html(request);  //登录错误提示信息
                      },
                      success:function(data) {
                           data =  eval("("+data+")");
                           var a = data.flag; 
                           if (a == "0") {//登录成功
                                 $("#showMsg").html("登录成功！！页面加载中！！")
                                 setCookie("username",data.username);
//                                 Session["UserName"]=data.username;
//                               document.location = "menutree.aspx";  
                                  window.location.href="menutree.aspx";  
//                                    window.opener=null;
//                                    window.open('menutree.aspx');
//                                    window.open('','_self');
//                                    window.close();
                             }
                             else {//登录失败
                                 $("#showMsg").html("用户名或密码错误！登录失败！")
                             } 
                      }            
                });       
            } 
    } 
    function register()
    {
         window.open('user_register.aspx');    
    }
    
    
    $(function(){ 
       $('#loginWin').window({
            collapsible:true,
            minimizable:false,
            maximizable:false,
            resizable:false,
            closable:false
      });
        $('#loginWin').window('open');
        $("input[name='login']").focus();
   })
   
   
     function register()
    {
         window.open('user_register.aspx');    
    }
   
  </script>   
</head>
<body style=" width:auto; height:inherit; margin:0px; padding:0px; background-image:url();"> 
    <%--<img src="images/gaosu1.jpg" />--%> 
    <div id="loginWin" class="easyui-window" title="登录" style="width:350px;height:188px;padding:5px;" >
        <div class="easyui-layout" fit="true">
           <div region="center" border="false" style="padding:5px;background:#fff;border:1px solid #ccc;">
                <form id="loginForm" method="post">
                    <div style="padding:5px 0;">
                        <label  for="login">帐号:</label>
                        <input type="text" name="login" style="width:260px;"></input>
                    </div>
                    <div style="padding:5px 0;">
                        <label for="password">密码:</label>
                        <input type="password" name="password" style="width:260px;"></input>
                    </div>
                     <div style="padding:5px 0;text-align: center;color: red;" id="showMsg"></div>
                </form>
           </div>
            <div region="south" border="false" style="text-align:right;padding:5px 0;">
                <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="login()">登录</a>
                <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="cleardata()">重置</a>
                 <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="register()">注册</a>
             
            </div>
        </div>
    </div>
    
</body>
</html>
