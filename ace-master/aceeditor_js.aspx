<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aceeditor_js.aspx.cs" Inherits="julia.web.aceeditor_js" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    
    <link href="./doc/site/images/favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="../jquery-easyui-1.2.6/jquery-1.7.2.min.js"  > </script>    
    <script type="text/javascript" src="../jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
    
    <script src="ace-builds-master/src-min-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
    
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
            inite();
            alert("js");
   
        
     })
     function inite(){
            myeditor = ace.edit("editor");
            myeditor.setTheme("ace/theme/monokai");    
            myeditor.getSession().setMode("ace/mode/javascript");
            myeditor.getSession().on('change', function(e) {          
           
           });           
     }
     function getcontent(){
        var content_t = myeditor.getValue();
        return   content_t;   
     }
     
    
    
    </script>    
    
</head>
<body>

<div id="editor">
     function foo(items) {    var x = "All this is syntax highlighted";    return x;}
</div>




</body>
</html>
