<%@ Page Language="C#" AutoEventWireup="true" CodeFile="menutree.aspx.cs" Inherits="julia.web.menutree" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>系统主界面页</title>
    <script type="text/javascript" src="treedata_js/tree_data.js"></script>
    <script type="text/javascript" src="treedata_js/cookie.js"></script>
    <script type="text/javascript" src="treedata_js/nobackspace.js  "></script>  
    <script type="text/javascript" src="treedata_js/time_interval.js"></script>        
    <script src="jquery-easyui-1.2.6/jquery-1.7.2.min.js" type="text/javascript" > </script>    
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.2.6/themes/icon.css" />
    <link href="jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css" />   
    
    <style type="text/css">
		input,textarea{
			width:200px;
			border:1px solid #ccc;
			padding:2px;
		}
	</style>
<script type="text/javascript" language="javascript">
      window.onunload=function(){
           //alert("谢谢使用");         
           window.location = "login_main.aspx";
      }
     //欢迎界面，防止闪屏
   function closes(){ 
    $("#Loading").fadeOut("normal",function(){ 
        $(this).remove();
     }); }  
    var pc;
    $.parser.onComplete = function(){
    if(pc) clearTimeout(pc);
     pc = setTimeout(closes, 1000);}    
     var menutree = "";
//     alert("here!!!");
//     if(getCookie("username")==null)  { alert("非法登录，请输入用户名和密码！");window.location.href="login_main.aspx"; }
      $.ajax({
            global: false,
            cache: false,
            async: false,
            type: "post",  
            data:{"username":getCookie("username")},         
            url: "Ajaxhandle/gettree_json.ashx",
//            data:{"username":"54823"},         
//            url: "Ajaxhandle/gettree_json.ashx",
            success: function (data,textstatus) {              
//              $.messager.alert('Info',data,'info');
//            alert("response"+data); 
              menutree = eval("("+data+")");
            //do something
            },            
            error: function (msg) {
            $.messager.alert('Info',msg,'info');
               alert(msg.responseText); //输出了出错的信息
            }
            });
    function request(paras){ 
        var url = location.href; 
        var paraString = url.substring(url.indexOf("?")+1,url.length).split("&"); 
        var paraObj = {} 
        for (i=0; j=paraString[i]; i++){ 
        paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length); 
        } 
        var returnValue = paraObj[paras.toLowerCase()]; 
        if(typeof(returnValue)=="undefined"){ 
        return ""; 
        }else{ 
        return returnValue; 
        } 
    }
      var username;
 	$(function(){    //等效于$(document).ready(function(){})或者 jQuery(function($){ })   ，防止文档在完全加载（就绪）之前运行 jQuery 代码
        username = getCookie("username");
        setusername(username);
//		showTime();
        addmenu();
		addNav(menutree["basic"]); 
//		addNav(_tree_dynamic["basic"]); 
        addmainTab('主页','cool_web/index.aspx?username='+username);
//        inittab();
//		 showTime2();
//        showInterval();
        iniwindow();	
 	})
 	function setusername(name)
 	{
 	   $("#username").html(name); 	
 	
 	}
 	function inittab(){
 	    //获取当前被选择的选项卡以及相应的选项卡对象   
 	    alert("here");
        var pp = $('#maintab').tabs('getTab','主页');   
        alert("pp"+pp);
        //相应的选项卡对象 
        $('#maintab').tabs('update',pp,{                
                content:'<iframe scrolling="auto" frameborder="0"  src="main.aspx" style="width:100%;height:100%;"></iframe>',
                closable:true,
                iconCls:""
                }); 
 	}
 	//基础功能菜单事件绑定
 	function addmenu(){
 	 	       var ddlmenu0 = $('#mb1').menubutton({menu:'#mm1'});
               var ddlmenu1 = $('#mb2').menubutton({menu:'#mm2'}); 
 	           //初始化 
//                var ddlMenu = $('#a4').menubutton({ menu: '#cusmenu' }); 
               //menubutton 依赖于 menu、linkbutton 这两个插件，所以我们可以这样搞定她 
               $(ddlmenu0.menubutton('options').menu).menu({ 
                        onClick: function (item) { 
                         //item 的相关属性参见API中的menu 
                         if(item.text=="主页"){ 
                             $('#maintab').tabs('select', '主页')                         
                         };
                         if(item.text=="密码修改"){
                             $('#win').window('open');
                         };
                         if(item.text=="退出"){ //setCookie("username",data.username);
                                    delCookie("username"); 
                                    window.location.href="menutree.aspx"; 
//                                    window.opener=null;
//                                    window.open('login_main.aspx');
//                                    window.open('','_self');
//                                    window.close();
                              }; 
                        } 
                })
 	}
 	 //动态生成accordion
     /* $('#west-accordion').accordion(options);*/
     function addNav(data) {           
            $.each(data, function(i, sm) //i=索引，sm=取值
             {  
                  var id = "tt"+i; 
                  $("#wnav").accordion('add',{
　　                                   title: sm.text,
　　                                   content:"<ul id='"+id+"'></ul> ",
　　                                   iconCls: sm.iconCls
                                                });  
                 var treeid =  '#'+id+'';
                
	             $(treeid).tree({
			        data :sm.children,                   //备注：引用js变量使用data，引用json文件使用url
				    onClick:function(node){
//				    alert('你点击了节点'+ node.text);
//				    alert('节点属性attribute:'+ node.attributes.url);
				    if (node.attributes.url!='') { 
				        addTab(node.text,node.attributes.url);} 
				    }				    
			       })/**/	//--------end of tree
//			       alert($(treeid).tree);
			    })   //--end of .each
			    
			    
			var pp = $('#wnav').accordion('panels');
	        var t = pp[0].panel('options').title;
	        $('#wnav').accordion('select', t);    		
			}
		//主页加载
		/*function showpage(url){
             $('#content').load(url);
        }	*/ 
        //主页添加一个新标签    
        function addTab(title, url){
        if ($('#maintab').tabs('exists', title)){
            $('#maintab').tabs('select', title);
        } else {
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
            $('#maintab').tabs('add',{
                title:title,
                content:content,
                closable:true,
                iconCls:""
            });
        }        
        //ajax 方式接受后台权限树          
        }  
        function addmainTab(title, url){
//        alert(title+'====='+url);
        if ($('#maintab').tabs('exists', title)){
            $('#maintab').tabs('select', title);
        } else {
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
            $('#maintab').tabs('add',{
                title:title,
                content:content,
                closable:false,
                iconCls:""
            });
        }   } 	
        
        
        
        function iniwindow()
        {
            $('#win').window({   
                    width:400,   
                    height:200,   
                    modal:true,
                    title:'窗口',
                    closed:true,
                     collapsible:true,
                    minimizable:false,
                    maximizable:false,
                    resizable:false,
                    closable:true 
            });
        }
        function cleardata(){
            $('#loginForm').form('clear');
        }
        function enter()
        {
            
            var oldpass = $('#oldpass').val();
            var newpass = $('#newpass').val();
            var newpassagain = $('#newpassagain').val();
            if(passright(oldpass))
            {                          
                    if(newpass!=newpassagain)
                    {
                        alert_e('警告！','新密码和确认密码不一致，请重新输入确认新密码！.','error');
                        
                    }
                    else
                    {            
                       show('通知！','密码修改完成！.','show');
                       alert_e('通知！',oldpass+'---'+newpass+'-----'+newpassagain,'info');
                        $('#win').window('close');
                       
                    }
            }
            else
            {
                 alert_e('警告！','原密码错误！请重新输入！','error');
            }
        
        }
        //show messag 的类型 type 包括：show,slide,fade 
        function show(title,content,type){
			$.messager.show({
				title:title,
				msg:content,
				showType:type
			});
		}
		//alert的类型,alert,error,info,question等
		function alert_e(title,content,type){
			$.messager.alert(title,content,type);
		}
		function passright(oldpass)
		{
		    
		}
	
        
        
        	
</script>   
</head>
<body class="easyui-layout"> 
     <div region="north" title="" border="false" style="overflow:hidden;height:30px;text-align:right; vertical-align:top;">
	 	 <div style="position:absolute; text-align:left; margin:10px; width:100%;"> 尊敬的用户：
          <label  id="username" for=""></label>
         ，企业云服务平台欢迎您！！</div>
	 
	 
        <div style="padding:5px;width:100%; padding-right:20px; text-align:right;">
            <a href="javascript:void(0)" id="mb1" icon="icon-edit">基本功能</a>
            <a href="javascript:void(0)" id="mb2" icon="icon-help">帮助</a>
        </div>
        <div id="mm1" style="width:150px;">
            <div icon="icon-undo">主页</div>
            <div class="menu-sep"></div>
            <div icon="icon-redo">密码修改</div>
              <div class="menu-sep"></div>
            <div icon="icon-remove">退出</div>
        </div>
        <div id="mm2" style="width:100px;">
            <div>帮助</div>
            <div>升级</div>
            <div>关于</div>
        </div>
     </div>
	<div region="south"  split="false" style="height:25px;padding:3px;">
		<div class="easyui-layout" fit="true" style="background:#ccc;">
			<div region="center" border="false"  fit="true" style="padding:1px;text-align:center;background:#fff;border:0px solid #ccc;">国家超算济南中心</div>
			<%--<div region="south" border="false"  style="width:200px;text-align:right;padding:5px 0;">sub center</div>--%>
		</div>
	</div>
<%--	<div region="east" iconCls="icon-reload" title="折叠菜单" split="true" style="width:180px;" >
	</div>--%>
	<div region="west" split="true" title="导航" style="width:200px;padding:1px;overflow:hidden;">
		<div fit="true" border="false" SelectedIndex="1" id="wnav" class="easyui-accordion" >
		</div>	
	</div>
	<div region="center"  style="overflow:hidden;" id="content">
		<div class="easyui-tabs" fit="true" border="false" id="maintab">
	<%--		<div id="cc" title="主页" style="padding:20px;overflow:hidden;"   > 
			</div>--%>
			</div>
		</div>
<%--	  <div id="tabsMenu" class="easyui-menu" style="width:120px;"> 
        <div name="close">关闭</div>
        <div name="Other">关闭其他</div>
         <div name="All">关闭所有</div>
    </div>  --%>
    
     <div id="win" > 
                <div class="easyui-layout" fit="true" style="background:#ccc;">  
                    <div region='south' style="height:50px;text-align:center;padding:5px 0;">
                    
                   <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="enter()">确认</a>
                   <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="cleardata()">重置</a>
                    
                    </div>  
                    <div region='center' fit="true" style="padding:20px; text-align:center;">
	                       
	                        <form id="loginForm" method="post">
	                        <table>
		                        <tr>
			                        <td>原密码:</td>
			                        <td ><input id='oldpass' class="easyui-validatebox"  validType="string"/></td>
		                        </tr>
		                        <tr>
			                        <td>新密码:</td>
			                        <td><input id='newpass' class="easyui-validatebox"  validType="string"/></td>
		                        </tr>
		                        <tr>
			                        <td>确认新密码:</td>
			                        <td><input id='newpassagain' class="easyui-validatebox"  validType="string"/></td>
		                        </tr>
		         <%--               <tr>
			                        <td>Note:</td>
			                        <td><textarea class="easyui-validatebox" required="true" style="height:100px;"/></textarea></td>
		                        </tr>--%>
	                        </table>
	                        </form>
                    </div>
                </div>
     </div>
    
    
</body>
</html>
