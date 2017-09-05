<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rolefunc.aspx.cs" Inherits="julia.web.rolefunc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
        <script type="text/javascript" src="treedata_js/tree_data.js"></script>
    <script type="text/javascript" src="treedata_js/cookie.js"></script>
    <script type="text/javascript" src="treedata_js/nobackspace.js  "></script>  
    
    <script type="text/javascript" src="treedata_js/time_interval.js"></script>        
    <script src="jquery-easyui-1.2.6/jquery-1.7.2.min.js" type="text/javascript" > </script>    
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="jquery-easyui-1.2.6/json2.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.2.6/themes/icon.css" />
    <link href="jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css" />   
<script type="text/javascript" language="javascript">    
   ext_treenode_parent();    
  $(function(){    //等效于$(document).ready(function(){})或者 jQuery(function($){ })   ，防止文档在完全加载（就绪）之前运行 jQuery 代码
       
//		showTime();
        adddatagrid();
        addmenu();
        addbutton();
//        rolefunc(2);
//        addrolefunc();
//		addNav(menutree["basic"]); 
//		addNav(_tree_dynamic["basic"]); 
//        addmainTab('主页','main.aspx');
//        inittab();
//		 showTime2();
//        showInterval();
		
 	})
 	function rolesget(){	}
	 function addmenu(){
	     $('#p').panel({   
              //width:500,   
              height:1024,
              left:50,   
              title: '权限树',   
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
    function adddatagrid(){
             var lastIndex;
                $('#rolestt').datagrid({
                //title:'角色',
				iconCls:'icon-save',
				width:1024,
				//height:650,
				nowrap: false,
				striped: false,
				collapsible:false,				
				sortName: 'ROLENUM',
				sortOrder: 'asc',
				remoteSort: false,
				idField:'ROLENUM', 
                rownumbers:false,
//                pagination:true,
                url:'Ajaxhandle/Handler_rolesget.ashx',
                columns:[[
					{field:'ROLENUM',title:'编号',width:80,sortable:false},
					{field:'ROLENAME',title:' 角色名',width:180,editor:'text'}
					//{field:'addr',title:'Address',width:50},
					//{field:'col4',title:'Col41',width:50}
				]],
				onClickRow:function(rowIndex, rowData){
//				    if(lastIndex!=rowIndex) $('#rolestt').datagrid('endEdit', lastIndex);
		            $('#rolestt').datagrid('unselectAll');
		            $('#rolestt').datagrid('selectRow',rowIndex);
		           // alert(rowIndex+"---"+rowData.ROLENAME+"-----"+rowData.ROLENUM);
                    rolefunc(rowData.ROLENUM);
                    $('#rolestt').datagrid('endEdit', rowIndex);
                   // alert(rowData.ROLENUM);	    			    
                },
                onDblClickRow:function(rowIndex, rowData){
                    editrow();					   				    			    
                },
                onAfterEdit:function(rowIndex, rowData, changes){ 
                    //alert("编辑后触发----"+rowData.ROLENAME); 
                     if ($('#rolestt').datagrid('getChanges').length){
                        inserttodb_roles(rowData.ROLENUM,rowData.ROLENAME,'insert'); 
                          var acceptall = $('#rolestt').datagrid('acceptChanges');
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
//				            handler :function(){$('#rolestt').datagrid('rejectChanges');}
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
            });//end   $('#rolestt').datagrid(
    }//end adddatagrid()
    //获取最大序号
    function getmaxnum(){    
        var rows = $("#rolestt").datagrid("getRows");
       // var rows = $('#rolestt').datagrid('getData'); 
        var count=0;
        if(rows){
            
            for(var i=0; i<rows.length; i++){    
                if(rows[i].ROLENUM>count) 
                     count = rows[i].ROLENUM;
                     //alert(rows[i].ROLENUM);
                    }        
        }
        count++         
        return count;      
    }
    //编辑行
   function editrow(lastIndex){
        var row =$('#rolestt').datagrid('getSelected');
        if (row) {
            var rowIndex = $('#rolestt').datagrid('getRowIndex', row);
            $('#rolestt').datagrid('endEdit', lastIndex);
			$('#rolestt').datagrid('beginEdit',rowIndex);		
			lastIndex = rowIndex;		
            return lastIndex;
        }     
    }//end func	editrow
    //结束编辑航
    function endeditrow(){
        var rows =$('#rolestt').datagrid('getRows');
		for ( var i = 0; i < rows.length; i++) {
			$('#rolestt').datagrid('endEdit', i);
		}
		
    }//end func	endeditrow
    //删除行
    function delrow(lastIndex){
         var inserted = $('#rolestt').datagrid('getChanges', "inserted");         
         var updated = $('#rolestt').datagrid('getChanges', "updated");
         //前台删除
         if(inserted.length || updated.length){
             //alert("有修改的记录！请先保存！");
             $.messager.alert('提示！','有修改的记录！请先保存！','warning');
         }else
         {
             $.messager.confirm('警告！', '请谨慎删除角色！<br> 确认删除？', function(r){
                if (r){
                     var rows = $('#rolestt').datagrid('getSelected');
                     if (rows) {
                            var ronum = rows.ROLENUM;
                            var roname = rows.ROLENAME;
                            inserttodb_roles(ronum,roname,'del');                            
                            var rowIndex = $('#rolestt').datagrid('getRowIndex', rows);
                            $('#rolestt').datagrid('deleteRow', rowIndex); 
                            var acceptall = $('#rolestt').datagrid('acceptChanges');
                     }
                     else
                     {
                         $.messager.alert('提示！','请选择待删除的行！','warning');
                     }
               }//end if (r)
            });//confirm
         } 
    }//end func	delrow
    
////删除数据写数据库  
//    var deleted = $('#rolestt').datagrid('getChanges', "deleted");                       
//    if (deleted.length) {  
//       var json_str = JSON.stringify(deleted);
//       alert("deleted"+json_str);    
//       inserttodb_roles(json_str,'del');   

    //增加行
    function addrow(lastIndex){
//        var lastIndex;
        var maxid=getmaxnum();				                ;
        $('#rolestt').datagrid('endEdit', lastIndex);
        $('#rolestt').datagrid('appendRow',{
                        ROLENUM:maxid,
                        ROLENAME:''	});
        lastIndex = $('#rolestt').datagrid('getRows').length-1;
        $('#rolestt').datagrid('selectRow', lastIndex);
        $('#rolestt').datagrid('beginEdit', lastIndex);
        return lastIndex; 
		
    }//end func	delrow
        /**
      * json对象转字符串形式
     */
     function json2str(o) {
         var arr = [];
         var fmt = function(s) {
             if (typeof s == 'object' && s != null) return json2str(s);
             return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s;
         }
         for (var i in o) arr.push("'" + i + "':" + fmt(o[i]));
         return '{' + arr.join(',') + '}';
     }
     ///
     //保存修改和新增的行---当前版本没有使用，待多数据保存时使用
     ///
    function saverow(){
        if ($('#rolestt').datagrid('getChanges').length) {
	            var inserted = $('#rolestt').datagrid('getChanges', "inserted");
	            var updated = $('#rolestt').datagrid('getChanges', "updated");            						
	            if (inserted.length) {
//                   var json_str = json2str(inserted);                  
                    var json_str = JSON.stringify(inserted);
                    inserttodb_roles(json_str,'insert');                     
	            }
	            if (updated.length) {
		           // effectRow["updated"] = JSON.stringify(updated);
		            var json_str = JSON.stringify(updated);
                    inserttodb_roles(json_str,'update'); 
//		           alert("更新"+updated.length);		           
	            }
	            //一种post请求后台响应
//	            $.post("servlet/commit",effectRow,
//	                             function(rsp) {
//		                                if(rsp.status){
//			                                $.messager.alert("提示", "提交成功！");
//			                                $dg.datagrid('acceptChanges');
//		                                }
//	                               },"JSON").error(function() {
//		            $.messager.alert("提示", "提交错误了！");
//	            });
	            var acceptall = $('#rolestt').datagrid('acceptChanges');
		 }//end of 	 if ($('#rolestt').datagrid('getChanges').length)     
    }
    //修改角色数据库
    function inserttodb_roles(roleid,rolename,flag)
    {
//	   alert(roleid+rolename+"====="+flag);
	   $.ajax({
        global: false,
        cache: false,
        async: true,
        type: "post",
        data:{"rownum":roleid,"rolename":rolename,'flag':flag},         
        url: "Ajaxhandle/Handler_rolesmodify.ashx",
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
    
    //权限功能部分按钮
    function addbutton(){
        $('#save').linkbutton({   
            iconCls: 'icon-save',
            plain:false              
        });
        $('#getChecked').linkbutton({   
            iconCls: 'icon-ok',
            plain:true              
        });
        $('#collapseAll').linkbutton({   
            iconCls: 'icon-remove',
            plain:false              
        });
        $('#expandAll').linkbutton({   
            iconCls: 'icon-add',
            plain:false              
        });
    }
    //获取角色对应的功能树，含check状态
    function rolefunc(roleid){
        var url_rolefunc = 'Ajaxhandle/Handler_rolesfunc.ashx?id='+roleid;
//        alert(url_rolefunc);
           $('#rolefunc').tree({
//                lines:true,
                idField:'id',
				treeField:'text',
                cascadeCheck:true,
				checkbox: true,
				url:url_rolefunc,
//				url: 'treedata_js/tree_data.json',
				onClick:function(node){
					$(this).tree('toggle', node.target);
//					alert('you click '+node.id);
				},
				onContextMenu: function(e, node){
					e.preventDefault();
					$('#rolefunc').tree('select', node.target);
					$('#mm').menu('show', {
						left: e.pageX,
						top: e.pageY
					});
				}
			});
    }
    function save(){  
      var row = $('#rolestt').datagrid('getSelected');  
      if(row){          
          var sqlstr = getChecked();
//          alert(sqlstr);
          inserttodb(row.ROLENUM,sqlstr);
      }else{
          alert("请选择角色！");
      }       
    }
	//角色权限修改数据库AJAX
	function inserttodb(roleid,treeid)
    {
	   $.ajax({
        global: false,
        cache: false,
        async: true,
        type: "post",
        data:{"rownum":roleid,'id':treeid},         
        url: "Ajaxhandle/Handler_rolesfunc_modify.ashx",
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
    function collapse(){
		var node = $('#rolefunc').tree('getSelected');
		$('#rolefunc').tree('collapse',node.target);
	}
	function expand(){
		var node = $('#rolefunc').tree('getSelected');
		$('#rolefunc').tree('expand',node.target);
	} 
	function collapseAll(){
		var node = $('#rolefunc').tree('getSelected');
		if (node){
			$('#rolefunc').tree('collapseAll', node.target);
		} else {
			$('#rolefunc').tree('collapseAll');
		}
	}
	function expandAll(){
		var node = $('#rolefunc').tree('getSelected');
		if (node){
			$('#rolefunc').tree('expandAll', node.target);
		} else {
			$('#rolefunc').tree('expandAll');
		}
	}
	function getChecked(){
		var nodes = $('#rolefunc').tree('getChecked');
		var nodes1 = $('#rolefunc').tree('getSolidExt');	
//		alert(nodes.length);
//		alert(nodes[1].text);
	    var s = '';
	    for(var i=0; i<nodes.length; i++){
		    if (s != '') s += ',';
		    s += nodes[i].id;		    
	     }
	    var w = '';
	    for(var i=0; i<nodes1.length; i++){
		    if (w != '') w += ',';
		    w += nodes1[i].id;
	    }
	    var total='';
        if(w!=''){
            total=s+","+w;		
        }else{
            total=s;           
        }  
       return total;
	}
	/*
	 #扩展easyui tree的两个方法 获取实心节点 	
	*/	
	function ext_treenode_parent(){
	        $.extend($.fn.tree.methods,{  
            getCheckedExt: function(jq){  
                var checked = $(jq).tree("getChecked");  
                var checkbox2 = $(jq).find("span.tree-checkbox2").parent();  
                $.each(checkbox2,function(){  
                    var node = $.extend({}, $.data(this, "tree-node"), {  
                        target : this  
                    });  
                    checked.push(node);  
                });  
                return checked;  
            },  
            getSolidExt:function(jq){  
                var checked =[];  
                var checkbox2 = $(jq).find("span.tree-checkbox2").parent();  
                $.each(checkbox2,function(){  
                    var node = $.extend({}, $.data(this, "tree-node"), {  
                        target : this  
                    });  
                    checked.push(node);  
                });  
                return checked;  
            }  
        });
    }
    //-------END扩展--------   
</script>
</head>
<body class="easyui-layout">
  	<div region="west" split="false" title="角色管理" style="width:270px;overflow:hidden;" collapsible="false">
  	    <table id="rolestt"></table>	
	</div>
	<div region="center"  style="overflow:hidden;" id="content" title="角色-权限管理"> 
	    <div id="p" style="padding:10px;">  
	    	<div style="margin:10px;">
		       <%-- <a id="reload" href="#" onclick="reload()">reload</a>--%>
		        <a id="save" href="#" onclick="save()">保存</a>	
		         <a id="expandAll" href="#" onclick="expandAll()">展开全部</a>	       
		        <a id="collapseAll" href="#" onclick="collapseAll()">收缩全部</a>
	        </div>  
            <ul id="rolefunc"></ul>
        </div>   
	</div> 
    <div id="mm" class="easyui-menu" style="width:120px;">	
		<div onclick="expand()" iconCls="icon-add">Expand</div>
		<div class="menu-sep"></div>
		<div onclick="collapse()" iconCls="icon-remove">Collapse</div>
	</div>
</body>
</html>
