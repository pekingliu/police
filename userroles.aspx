<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userroles.aspx.cs" Inherits="julia.web.userroles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <script type="text/javascript" src="treedata_js/tree_data.js"></script>
    <script type="text/javascript" src="treedata_js/cookie.js"></script>
    <script type="text/javascript" src="treedata_js/nobackspace.js  "></script>  
    
    <script type="text/javascript" src="treedata_js/time_interval.js"></script>        
    <script src="jquery-easyui-1.3.2/jquery-1.8.0.min.js" type="text/javascript" > </script>    
    <script type="text/javascript" src="jquery-easyui-1.3.2/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="jquery-easyui-1.3.2/json2.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.3.2/themes/icon.css" />
    <link href="jquery-easyui-1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css" />   
</head>
<script type="text/javascript" language="javascript">  
  $(function(){    //等效于$(document).ready(function(){})或者 jQuery(function($){ })   ，防止文档在完全加载（就绪）之前运行 jQuery 代码
       
//		showTime();
        adddatagrid();
        addmenu();
//        adddatagrid_user_roles();
        
//        addbutton();		
 	})
 	function addmenu(){
	     $('#p').panel({   
              //width:800,   
              height:1024,
              left:50,   
              title: '角色',   
              tools: [{   
                iconCls:'icon-add',                
                handler:function(){alert('new')}   
              },{   
                iconCls:'icon-save',   
                handler:function(){
                alert('save');                
                }   
              }]   
            }); 
	 }
 //用户记录加载
  function adddatagrid(){
             var lastIndex;
             var $dg =$('#usert');
                $dg.datagrid({
                //title:'角色',
				iconCls:'icon-save',
				//width:270,
				height:800,
				nowrap: false,
				striped: false,
				collapsible:false,				
				sortName: 'USERNUM',
				sortOrder: 'asc',
				remoteSort: false,
				idField:'USERNUM', 
                rownumbers:false,
//                pagination:true,
                url:'Ajaxhandle/Handler_userget.ashx',
                columns:[[
					{field:'USERNUM',title:'编号',width:80,sortable:false},
					{field:'USERNAME',title:' 用户名',width:180,editor:'text'}
					//{field:'addr',title:'Address',width:50},
					//{field:'col4',title:'Col41',width:50}
				]],
				onClickRow:function(rowIndex, rowData){
//				    if(lastIndex!=rowIndex) $dg.datagrid('endEdit', lastIndex);
		            $dg.datagrid('unselectAll');
		            $dg.datagrid('selectRow',rowIndex);
		           // alert(rowIndex+"---"+rowData.ROLENAME+"-----"+rowData.ROLENUM);
                    adddatagrid_user_roles(rowData.USERNUM);
                    $dg.datagrid('endEdit', rowIndex);
                   // alert(rowData.ROLENUM);
	           				    			    
                },
                onDblClickRow:function(rowIndex, rowData){
                    editrow();					   				    			    
                },
                onAfterEdit:function(rowIndex, rowData, changes){ 
                    //alert("编辑后触发----"+rowData.ROLENAME); 
                     if ($dg.datagrid('getChanges').length){
                        inserttodb_roles(rowData.USERNUM,rowData.USERNAME,'insert'); 
                        var acceptall = $dg.datagrid('acceptChanges');
                    }                   
                },              
                toolbar:[
                        {
				            id:'btnadd',
				            text:'增加',
				            iconCls:'icon-add',
				            handler:function(){				               
				               lastIndex = addrow(lastIndex);				
					        }				      
				        },'-',{
				            id:'btnedit',
				            text:'编辑',
				            iconCls:'icon-edit',
				            handler:function(){
				               lastIndex = editrow(lastIndex);
				               //alert(lastIndex);
					        }				      
				        },'-',{
//				            text :"结束编辑",
//				            iconCls : "icon-undo",
//				            handler :function(){$dg.datagrid('rejectChanges');}
//			            },'-',{
				            id:'btnendedit',
				            text : "删除",
				            iconCls : "icon-cancel",
				            handler :function(){				                
	                             delrow(lastIndex);
					        }			
//			            },'-',{
//				            id:'btnendedit',
//				            text : "保存",
//				            iconCls : "icon-save",
//				            handler :function(){
//				                 //endeditrow();
//				                 //saverow();
//					        }//end of 	function(){     endeditrow();		
			            } 
				     ]// end tools bar
            });//end   $dg.datagrid(
    }//end adddatagrid()
    
   //增加行
    function addrow(lastIndex){
//        var lastIndex;
        var maxid=getmaxnum();				                ;
        $('#usert').datagrid('endEdit', lastIndex);
        $('#usert').datagrid('appendRow',{
                        USERNUM:maxid,
                        USERNAME:''	
               });
        lastIndex = $('#usert').datagrid('getRows').length-1;
        $('#usert').datagrid('selectRow', lastIndex);
        $('#usert').datagrid('beginEdit', lastIndex);
        return lastIndex; 
		
    }//end func	delrow
        //获取最大序号
    function getmaxnum(){    
        var rows = $("#usert").datagrid("getRows");
       // var rows = $('#rolestt').datagrid('getData'); 
        var count=0;
        if(rows){
            
            for(var i=0; i<rows.length; i++){    
                if(rows[i].USERNUM>count) 
                     count = rows[i].USERNUM;
                     //alert(rows[i].ROLENUM);
                    }        
        }
        count++         
        return count;      
    }
        //编辑行
   function editrow(lastIndex){
        var row =$('#usert').datagrid('getSelected');
        if (row) {
            var rowIndex = $('#usert').datagrid('getRowIndex', row);
            $('#usert').datagrid('endEdit', lastIndex);
			$('#usert').datagrid('beginEdit',rowIndex);		
			lastIndex = rowIndex;		
            return lastIndex;
        }     
    }//end func	editrow
    //结束编辑航
    function endeditrow(){
        var rows =$('#usert').datagrid('getRows');
		for ( var i = 0; i < rows.length; i++) {
			$('#usert').datagrid('endEdit', i);
			
		}		
    }//end func	endeditrow
    //用户表删除行
    function delrow(lastIndex){
         var inserted = $('#usert').datagrid('getChanges', "inserted");         
         var updated = $('#usert').datagrid('getChanges', "updated");
         //前台删除
         if(inserted.length || updated.length){
             //alert("有修改的记录！请先保存！");
             $.messager.alert('提示！','有修改的记录！请先保存！','warning');
         }else
         {
             $.messager.confirm('警告！', '请谨慎删除角色！<br> 确认删除？', function(r){
                if (r){
                     var rows = $('#usert').datagrid('getSelected');
                     if (rows) {
                            var ronum = rows.USERNUM;
                            var roname = rows.USERNAME;
                            inserttodb_roles(ronum,roname,'del');                            
                            var rowIndex = $('#usert').datagrid('getRowIndex', rows);
                            $('#usert').datagrid('deleteRow', rowIndex); 
                            var acceptall = $('#usert').datagrid('acceptChanges');
                            adddatagrid_user_roles(ronum);
                     }
                     else
                     {
                         $.messager.alert('提示！','请选择待删除的行！','warning');
                     }
               }//end if (r)
            });//confirm
         } 
    }//end func	delrow
    //修改用户数据库
    function inserttodb_roles(roleid,rolename,flag)
    {
//	   alert(roleid+rolename+"====="+flag);
	   $.ajax({
        global: false,
        cache: false,
        async: true,
        type: "post",
        data:{"rownum":roleid,"rolename":rolename,'flag':flag},         
        url: "Ajaxhandle/Handler_usermodify.ashx",
        success: function (data,textstatus) {              
             
//          alert("response"+data); 
              var menutree='';
              menutree = eval("("+data+")");
              //alert(menutree[0].flag);
              if(menutree[0].flag=='success') {
                 $.messager.alert('Info','保存成功！','info')
//                   var ee;
               }else{
                 $.messager.alert('Info','保存失败！','info')}
                 
              
        //do something
        },            
        error: function (msg) {
            alert(msg.responseText); //输出了出错的信息
        }
        });	
	}
    
    //用户-角色关系加载
    //获取用户对应的较色，含check状态
      function adddatagrid_user_roles(usenum){
             var url_user_roles = 'Ajaxhandle/Handler_user_rolesget.ashx?usernum='+usenum;
             var lastIndex;
             var $dg =$('#userrolest');
                $dg.datagrid({
                //title:'角色',
				iconCls:'icon-save',
				//width:500,
				height:650,
				nowrap: false,
				striped: false,
				collapsible:false,				
				sortName: 'ROLENUM',
				sortOrder: 'asc',
				remoteSort: false,
				idField:'ROLENUM', 
                rownumbers:false,
//                pagination:true,
                sortOrder: 'asc',
                sortName: 'ROLENUM',
                selectOnCheck:true,
                singleSelect:false,
                url:url_user_roles,
                frozenColumns:[[
	                 {title:'选中',field:'ck',checkbox:true},                  
	                {title:'编号',field:'ROLENUM',width:80,sortable:true}
				]],
                columns:[[
					{title:' 角色名',field:'ROLENAME',width:180,editor:'text'}
				]],
				onClickRow:function(rowIndex, rowData){
//				    if(lastIndex!=rowIndex) $dg.datagrid('endEdit', lastIndex);
//		            $dg.datagrid('unselectAll');
		            $dg.datagrid('selectRow',rowIndex);
		           // alert(rowIndex+"---"+rowData.ROLENAME+"-----"+rowData.ROLENUM);
                   // alert(rowData.ROLENUM);	           				    			    
                },
                onDblClickRow:function(rowIndex, rowData){
                    editrow();					   				    			    
                },
                onAfterEdit:function(rowIndex, rowData, changes){ 
                    //alert("编辑后触发----"+rowData.ROLENAME); 
                     if ($dg.datagrid('getChanges').length){
                        inserttodb_roles(rowData.ROLENUM,rowData.ROLENAME,'insert'); 
                          var acceptall = $dg.datagrid('acceptChanges');
                    }                  
                },
                onLoadSuccess:function(data){ 
                         var rows = $dg.datagrid('getRows');
                         for(var i=0;i<rows.length;i++)
                         {
                            var tflag = rows[i].ck; 
                            var rowid = $dg.datagrid('getRowIndex',rows[i]);
                            if(tflag) {
                                 $dg.datagrid('selectRow',rowid);
                               }else{
                                 $dg.datagrid('unselectRow',rowid);
                               }                                                        
                         }
                },
                oncheck:function(rowIndex,rowData){
//                     alert("check--"+rowIndex);                
                     //  save(rowData.ROLENUM,'insert');
                },
                onUncheck:function(rowIndex,rowData){
//                     alert("uncheck--"+rowIndex);
                     //  save(rowData.ROLENUM,'del');
                },
                toolbar:[
                        {
				            id:'btnsave',
				            text:'保存',
				            iconCls:'icon-save',
				            handler:function(){	
//				               alert("save");			               
				               todosave();				
					        }				      
				        }
				]             

            });//end   $dg.datagrid(
    }//end adddatagrid()
    
    function todosave(){
        var allrolenum='';
        var count=0;    
        var rows = $('#userrolest').datagrid('getChecked');
//        alert(rows);
        for(var i=0;i<rows.length;i++)
        {
            if(count<rows.length-1)
                allrolenum = allrolenum + rows[i].ROLENUM +',';
            else
                allrolenum = allrolenum + rows[i].ROLENUM
            count++;             
        }
//        alert(allrolenum);
        save(allrolenum,'update');
    }
   
     function save(ROLENUM,flag){  
          var row = $('#usert').datagrid('getSelected');        
          if(row){
               inserttodb(row.USERNUM,ROLENUM,flag);
          }else{
              alert("请选择用户！");
          }       
    }
    //用户角色修改数据库AJAX
	function inserttodb(userid,roleid,flag)
    {
	   $.ajax({
        global: false,
        cache: false,
        async: true,
        type: "post",
        data:{"userid":userid,'roleid':roleid,'flag':flag},         
        url: "Ajaxhandle/Handler_user_roles_modify.ashx",
        success: function (data,textstatus) {              
             
//              alert("response"+data); 
              var menutree='';
              menutree = eval("("+data+")");
              //alert(menutree[0].flag);
              if(menutree[0].flag=='success') {
                 $.messager.alert('Info','保存成功！','info')
               }else{
                 $.messager.alert('Info','保存失败！','info')
               }
                 
              
        //do something
        },            
        error: function (msg) {
            alert(msg.responseText); //输出了出错的信息
        }
        });	
	}
	//



</script>
<body class="easyui-layout">
  	<div region="west" split="false" title="用户管理" style="width:270px;overflow:hidden;" collapsible="false">
  	    <table id="usert"></table>	
	</div>
	<div region="center"  style="overflow:hidden;" id="content" title="用户角色管理"> 
		    <div id="p" >  	    
	       <table id="userrolest"></table> 
	        </div> 
	</div> 
  
    <div id="mm" class="easyui-menu" style="width:120px;">	
		<div onclick="expand()" iconCls="icon-add">Expand</div>
		<div class="menu-sep"></div>
		<div onclick="collapse()" iconCls="icon-remove">Collapse</div>
	</div>
    

</body>
</html>
