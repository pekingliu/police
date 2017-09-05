<%@ Page Language="C#" AutoEventWireup="true" CodeFile="functiondic.aspx.cs" Inherits="julia.web.functiondic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>功能字典维护</title>
    <script type="text/javascript" src="treedata_js/tree_data.js"></script>
    <script type="text/javascript" src="treedata_js/cookie.js"></script>  
    <script type="text/javascript" src="treedata_js/nobackspace.js  "></script>      
    <script src="jquery-easyui-1.2.6/jquery-1.7.2.min.js" type="text/javascript" > </script>    
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.2.6/themes/icon.css" />
    <link href="jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css" />  
    <script type="text/javascript" language="javascript">  
		$(function(){
			$('#test').treegrid({
				title:'TreeGrid',
				iconCls:'icon-save',
				width:900,
				height:550,
				nowrap: false,
				rownumbers: false,
				animate:false,
				collapsible:true,
				url:'Ajaxhandle/Handler_functiondic.ashx',
				idField:'trid',
				treeField:'text',
				frozenColumns:[[
	                {title:'功能树',field:'text',width:220,
		                formatter:function(value){
		                	return '<span style="color:blue">'+value+'</span>';
		                },
		                editor:{type:'text',options:{precision:1}}
	                }
				]],
				columns:[[				   
					{field:'trid',title:'本节点号',width:60,editor:'text'},
					{field:'parentid',title:'父节点号',width:80,editor:'text'},					
					{field:'iconCls',title:'图标',width:60,editor:'text'},
					{field:'attributes',title:'URL地址',width:150,editor:'text'},
					{field:'state',title:'展开状态',width:60,editor:'text'},
					{field:'checked',title:'选取状态',width:60}
				//	{field:'state',title:'展开状态',width:60}
				]],
				onBeforeLoad:function(row,param){				
					if (row){
						$(this).treegrid('options').url = 'Ajaxhandle/Handler_functiondic.ashx';
					} else {
						$(this).treegrid('options').url = 'Ajaxhandle/Handler_functiondic.ashx';
					}
				},
				onContextMenu: function(e,row){
					e.preventDefault();
					$(this).treegrid('unselectAll');
					$(this).treegrid('select',row.trid);
					$('#mm').menu('show',{
						left: e.pageX,
						top: e.pageY
					});
				},
				onAfterEdit:function(row,changes){ 
//                    alert("编辑后触发----"+row.text); 
                    updatedb();
                },
                onDblClickRow:function(row){
                    $(this).treegrid('unselectAll');
					$(this).treegrid('select',row.trid);
                    editrow();
                },
                onClickRow:function(row){
                    $(this).treegrid('unselectAll');
					$(this).treegrid('select',row.trid);
                    endeditrow();
                },
                onUnselect:function(rowIndex,rowData)
                {  
                    alert("补选中");
                    $(this).treegrid('unselectAll');
                }, 
				toolbar: [
				    {
		                iconCls: '',
		                text:'取消选择',
		                handler: function(){$('#test').treegrid('unselectAll');}
	                },'-',{
		                iconCls: '',
		                text:'展开节点',
		                handler: function(){expandAll();}
	                },'-',{
	                    iconCls: '',
	                     text:'闭合节点',
	                    handler: function(){collapseAll();}
	                }
	            ]	
			});
		});
        //基础函数
		function reload(node){
			//var node = $('#test').treegrid('getSelected');
			if (node){
				$('#test').treegrid('reload', node.trid);
			} else {
				//$('#test').treegrid('reload');
			}		}
		function refresh(node){
		   	if (node){
			$('#test').treegrid('refresh', node.trid);
			} else {
				//$('#test').treegrid('reload');
			}
		}
		function getChildren(nodes){		
			var s='';
			var lenght_node=nodes.length-1;
			for(var i=0; i<nodes.length; i++){
			    s += nodes[i].trid + ',';			
			}
			return s;			
		}
		
		function getSelected(){
			var node = $('#test').treegrid('getSelected');		
			if (node){
				alert(node.trid+":"+node.text);
			}
		}
		function collapse(){
			var node = $('#test').treegrid('getSelected');
			if (node){
				$('#test').treegrid('collapse', node.trid);
			}
		}
		function expand(){
			var node = $('#test').treegrid('getSelected');
			if (node){
				$('#test').treegrid('expand', node.trid);
			}
		}
		function collapseAll(){
			var node = $('#test').treegrid('getSelected');
			if (node){
				$('#test').treegrid('collapseAll', node.trid);
			} else {
				$('#test').treegrid('collapseAll');
			}
		}
		function expandAll(){
			var node = $('#test').treegrid('getSelected');
			if (node){
				$('#test').treegrid('expandAll',node.trid);
			} else {
				$('#test').treegrid('expandAll');
			}
		}
		function expandTo(){
			$('#test').treegrid('expandTo', '02013');
			$('#test').treegrid('select', '02013');
		}
		// 结束  基础函数
		//增加子节点
		function append(){
			var node = $('#test').treegrid('getSelected');
			var idmax = getChildren_Max();
			var data = [{
				text: '',
				trid:idmax,
				parentid:node.trid,
				iconCls:'',
				attributes:'',
				state:'',
				checked:''
			}];			
			$('#test').treegrid('append',{
				parent:(node?node.trid:null),
				data:data
			});
			$('#test').treegrid('expand',node.trid);
//			inserttodb(node.trid,node.parentid,node.text,node.iconCls,node.attributes,node.state,node.checked,'update');	
			inserttodb(idmax,node.trid,'','','',node.state,'','insert');			
		}
		//编辑更新数据库
		function updatedb(){
			var node = $('#test').treegrid('getSelected');
			inserttodb(node.trid,node.parentid,node.text,node.iconCls,node.attributes,node.state,node.checked,'update');		
		}
		//新增节点增、删、改、数据库AJAX
		function inserttodb(id,parentid,text,icons,
		                    attributes,state,checked,flag)
	    {
		   $.ajax({
            global: false,
            cache: false,
            async: true,
            type: "post",
            data:{"id":id,'parentid':parentid,'text':text,'icons':icons,'attributes':attributes,'state':state,'checked':checked,'flag':flag},         
            url: "Ajaxhandle/Handler_functiondic_insertdb.ashx",
            success: function (data,textstatus) {              
//              $.messager.alert('Info',data,'info');
//              alert("response"+data); 
             // menutree = eval("("+data+")");
            //do something
            },            
            error: function (msg) {
            alert(msg.responseText); //输出了出错的信息
            }
            });	
		}
		//删除节点->子节点
		function remove(){
			var node = $('#test').treegrid('getSelected');
			if (node){		
			    deletedb(node);    
			    $('#test').treegrid('remove', node.trid);
				var nodep = $('#test').treegrid('getParent', node.trid);
//				var childs = $('#test').treegrid('getChildren', nodep.trid);
//				if(childs){ inserttodb(nodep.trid,nodep.parentid,nodep.text,nodep.iconCls,nodep.attributes,nodep.state,nodep.checked,'update');	}										
				if(nodep){refresh(nodep);}else{refresh(node);}				
			}			
		}
		//数据库删除节点及其子节点--后台数据库
		function deletedb(node){		    
			var nodes = $('#test').treegrid('getChildren',node.trid);
			var s='';
			if(nodes){	
                s = getChildren(nodes)+node.trid;
//                alert("has  children--"+s);
            }else{
 			    s = node.trid;
// 			    alert("no  children--"+s);
 			} 
 			//alert(node.id);			
 			inserttodb(node.trid,node.parentid,s,node.iconCls,node.attributes,node.state,node.checked,'delete');
		}//end func
		//获取子节点最大编号
		function getChildren_Max(){
			var node = $('#test').treegrid('getSelected');			
			if (node){
				var nodes = $('#test').treegrid('getChildren',node.trid);				
				var s=0;
				//alert(node.trid);//getParent
			    for(var i=0; i<nodes.length; i++){	
			    var parentid = $('#test').treegrid('getParent',nodes[i].trid); 
			    //alert(parentid.trid); 
				  if(s<nodes[i].trid && nodes[i]['_parentId']==node.trid)  //if(selectNodes[j][idField]==childId && children[i]['_parentId']==p[idField])  
				   { s = nodes[i].trid ;}
			   }
			   if(s==0){s=node.trid*100;}
			   s++;			   	
			   return s;
			} else {alert("请选取一个节点!!");}
		}
		// end of getChildren_Max 增加根节点
		function append_brother(){
			var node = $('#test').treegrid('getSelected');
			//var level = $('#test').treegrid('getLevel',node.trid);
			var parentid = $('#test').treegrid('getParent',node.trid);			
			var idmax = getRoot_max();			
			var data = [{
			        text: '',
			        trid:idmax,
			        parentid:-1,
			        iconCls:'',
			        attributes:'',
			        state:'',
			        checked:''
		    }];
		    
		    $('#test').treegrid('append',{
			    parent:null,
			    data:data
		    });		   
		    inserttodb(idmax,-1,'','','',node.state,'','insert');	
		}//end funcappend_brother
		//获取根节点最大编号
        function getRoot_max(){
          var nodes = $('#test').treegrid('getRoots');
          var s=0;
          for(var i=0; i<nodes.length; i++){	
               if(s<nodes[i].trid) 
                { s = nodes[i].trid ;}    
          }
          s++;	
          return s;
        }//end func	
        //
        function getRoot(){
          var nodes = $('#test').treegrid('getRoots');
          var s="";
          for(var i=0; i<nodes.length; i++){
          	s = s + nodes[i].trid+":"+nodes[i].text + "-" ;               
          }          	
          alert(s);
        }//end func	
        //编辑行
       function editrow(){
         var node = $('#test').treegrid('getSelected');   
         var temp = $('#test').treegrid('beginEdit',node.trid); 
        }//end func	editrow
        //结束编辑航
        function endeditrow(){
         var node = $('#test').treegrid('getSelected');      
        // alert(node.id); 
         var temp = $('#test').treegrid('endEdit',node.trid); 
        }//end func	endeditrow		
    </script>
</head>
<body>    
<%--    <div>
    	<div style="margin:10px 0;">
		<a href="#" onclick="reload()">Reload---</a>
		<a href="#" onclick="getChildren()">GetChildren----</a>
		<a href="#" onclick="getSelected()">GetSelected</a>
		<a href="#" onclick="collapse()">Collapse</a>
		<a href="#" onclick="expand()">Expand</a>
		<a href="#" onclick="collapseAll()">CollapseAll</a>
		<a href="#" onclick="expandAll()">ExpandAll</a>
		<a href="#" onclick="expandTo()">ExpandTo</a>
		
	</div>--%>
    <table id="test"></table>
    <div id="mm" class="easyui-menu" style="width:120px;">
        <div onclick="append_brother()">新增主菜单</div>	
		<div onclick="append()">新增子菜单</div>
		<div class="menu-sep"></div>	
		<div onclick="remove()">删除菜单</div>
		<div class="menu-sep"></div>
		<div onclick="editrow()">开始编辑</div>
		<div onclick="endeditrow()">结束编辑</div>
	</div>
</body>
</html>