<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aceeditor_julia.aspx.cs" Inherits="julia.web.aceeditor_julia" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    
    <link href="./doc/site/images/favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="../jquery-easyui-1.2.6/jquery-1.7.2.min.js"  > </script>    
    <script type="text/javascript" src="../jquery-easyui-1.2.6/jquery.easyui.min.js"></script>     
    <script src="ace-builds-master/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
    
    <%--<script src="require.js" type="text/javascript" charset="utf-8"></script>--%>
    
    <style type="text/css" media="screen">    
    #editor {  
         position: absolute;        
         top: 0;        
         right: 0;        
         bottom: 0;        
         left: 0;    
     }
    </style>
    <script type="text/javascript">
     var myeditor;
     $(function(){ 
// var url =  node.attributes.url+"?filename="+node.text+"@filepath="+filepath+"&filecontent="+content_file;;
          var tt = request("filecontent");
//          alert(tt);
          inite(); 
          addcontent(tt);       
     })
     function inite(tt){
//            var ace = require("lib/ace");
            myeditor = ace.edit("editor");
            myeditor.setTheme("ace/theme/monokai");    
            myeditor.getSession().setMode("ace/mode/julia");
            myeditor.getSession().on('change', function(e) {            
           });           
     }
     function addcontent(tt)
     {
//            myeditor.setValue(tt);  
            myeditor.insert(tt);  
     
     }
     function getcontent(){
        var content_t = myeditor.getValue();
        return   content_t;   
     }

     //获取请求参数
     function request(strParame) { 
        var args = new Object( ); 
        var query = location.search.substring(1); 

        var pairs = query.split("&"); // Break at ampersand 
        for(var i = 0; i < pairs.length; i++) { 
        var pos = pairs[i].indexOf('='); 
        if (pos == -1) continue; 
        var argname = pairs[i].substring(0,pos); 
        var value = pairs[i].substring(pos+1); 
        value = decodeURIComponent(value); 
        args[argname] = value; 
        } 
        return args[strParame]; 
    } 
    
    	function getfilecontent(filepath)
	{   
	    var tempcontent = getcontent_ajax(filepath);
	}
	//获取给定目录文件内容
	function getcontent_ajax(filepath)
	{
	    var content;
	    $.ajax({
                global: false,
                cache: false,
                async: false,              
                data:{'path':filepath},         
                url: "Ajaxhandle/Handler_getfilecontent.ashx",
                success: function (data,textstatus) {              
        //              $.messager.alert('Info',data,'info');
//                      alert("response"+data); 
                     // menutree = eval("("+data+")");
                    //do something
                    content_file = data;
//                    alert(content_file);
                },            
                error: function (msg) {
                    alert(msg.responseText); //输出了出错的信息
                }
        });      
	
	}

     
    
    
    </script>    
    
</head>
<body>

<div id="editor">
      
</div>




</body>
</html>
