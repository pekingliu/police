<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="julia.web.main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>   
   
    
    <link   type="text/css" rel="stylesheet"  href="jquery-easyui-1.2.6/themes/icon.css" />
    <link   type="text/css" href="jquery-easyui-1.2.6/themes/gray/easyui.css" rel="stylesheet"  /> 
    <%--<script type="text/javascript" src="json/tree_accord_menu_test.js"></script>--%>      
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery-1.7.2.min.js"  > </script>    
    <script type="text/javascript" src="jquery-easyui-1.2.6/jquery.easyui.min.js"></script> 
      <link href="jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css" />   

    
    
<script type="text/javascript" language="javascript">
     var menutree = "";
     var oldfilepath="";
     var newfilepath="";
     var treeeditflag="0";
     var content_file="";
     
     $(function(){    //等效于$(document).ready(function(){})或者 jQuery(function($){ })   ，防止文档在完全加载（就绪）之前运行 jQuery 代码
        getfiletree(0);
        addmenu();
//        addNav(_menus["basic"]);             
		addNav(menutree["basic"]);
//		addNav(_tree_dynamic["basic"]); 
        inittab();
        addTabssh('Console','','990');	
//        addTab('主页','cool_web/index.html','10000000');	
        iniwindow();
 	}) 	
 	//工程同步或者保存到后台目录，flag 保留字段”
	function getfiletree(flag){
 	     $.ajax({
                global: false,
                cache: false,
                async: false,              
                data:{"flag":flag},         
                url: "Ajaxhandle/Handler_getDirectory.ashx",
                success: function (data,textstatus) {              
//                      $.messager.alert('Info',data,'info');
//                      alert("response"+data); 
                      menutree = eval("("+data+")");
                    //do something
                },            
                error: function (msg) {
                    alert(msg.responseText); //输出了出错的信息
                }
        });
    }
 	
 	var treeid_whole,treename_whole; 	
 	//基础功能菜单事件绑定
 	function addmenu(){
 	 	       var ddlmenu0 = $('#mb1').menubutton({menu:'#mm1'});
               var ddlmenu1 = $('#mb2').menubutton({menu:'#mm2'}); 
               var ddlmenu2 = $('#mb3').menubutton({menu:'#mm3'});
               var ddlmenu3 = $('#mb4').menubutton({menu:'#mm4'}); 
 	           //初始化 
//                var ddlMenu = $('#a4').menubutton({ menu: '#cusmenu' }); 
               //menubutton 依赖于 menu、linkbutton 这两个插件，所以我们可以这样搞定她 
               $(ddlmenu0.menubutton('options').menu).menu({ 
                        onClick: function (item) { 
                         //item 的相关属性参见API中的menu 
                         if(item.text=="新建文件"){                                                  
//                             alert("添加树节点:树id="+treeid_whole);
                             appendnode('0');                             
//                           $('#maintab').tabs('select', '主页')
                         };
                         if(item.text=="新建目录"){                                                  
//                             alert("添加树节点:树id="+treeid_whole);
                             appendnode('1');                             
//                           $('#maintab').tabs('select', '主页')
                         };
                         if(item.text=="新建工程"){ 
                            appendnode('2')
                         };
                         if(item.text=="保存文件"){ //setCookie("username",data.username);
                            savefilecontent();
                         };
                         if(item.text=="删除文件"){ 
                            appendnode('3')
                         }; 
                         if(item.text=="重命名"){ 
                             var node = $(treeid_whole).tree('getSelected');                          
                             $(treeid_whole).tree('beginEdit',node.target);
                             treeeditflag="1";
                         }; 
                         if(item.text=="结束重命名"){
                             var node = $(treeid_whole).tree('getSelected');                          
                             $(treeid_whole).tree('endEdit',node.target);
                             treeeditflag="0";
                         };
                        } 
                });
                
                $(ddlmenu1.menubutton('options').menu).menu({ 
                        onClick: function (item) { 
                         //item 的相关属性参见API中的menu 
                         if(item.text=="帮助"){                                                  
                            
                         };
                         if(item.text=="升级"){                                                  
              
                         };
                         if(item.text=="关于"){                          
                            $('#win').window('open');  // open a window   
                           // $('#win').window('close');  // close a window  
                         };                       
                      } 
                })
                $(ddlmenu2.menubutton('options').menu).menu({ 
                        onClick: function (item) { 
                         //item 的相关属性参见API中的menu 
                         if(item.text=="帮助"){                                                  
                            
                         };
                         if(item.text=="升级"){                                                  
              
                         };
                         if(item.text=="关于"){                          
                            $('#win').window('open');  // open a window   
                           // $('#win').window('close');  // close a window  
                         };                       
                      } 
                })
               $(ddlmenu3.menubutton('options').menu).menu({ 
                        onClick: function (item) { 
                         //item 的相关属性参见API中的menu 
                         if(item.text=="帮助"){                                                  
                            
                         };
                         if(item.text=="升级"){                                                  
              
                         };
                         if(item.text=="关于"){                          
                            $('#win').window('open');  // open a window   
                           // $('#win').window('close');  // close a window  
                         };                       
                      } 
                })
 	}
 	function getmaxnode()
 	{
 	    var nodes = $(treeid_whole).tree('getRoots');
 	    var j=0;
 	    for(var i=0; i<nodes.length; i++)
 	    {
 	       if(nodes[i].id>j) j=nodes[i].id;
 	    } 	   
 	    return j;
 	}
 	///创建文件/目录，flag：0--文件，1--目录
 	function appendnode(flag)	
 	{
         //创建文件
         if(flag=='0'){
                 var maxid = getmaxnode();
                 var newid ;
                 var selected = $(treeid_whole).tree('getSelected');
                 if(selected)
                 {  
                     var selected_c = $(treeid_whole).tree('getChildren',selected.target); 
                     if(selected_c.length>0 ||selected.attributes.url==null){//选中的是目录，创建子文件
                        newid = getmaxid(selected);                       
                        $(treeid_whole).tree('append', {
                            parent: selected.target,
                            data: [{
                                id:newid,
                                text: 'default'+newid+'.jl',
                                state: 'open',
                                attributes:{url:'ace-master/aceeditor_julia.aspx'},
                                children: []
                            }]
                        });
                        var node = $(treeid_whole).tree('find', newid); 
                        $(treeid_whole).tree('expandTo', node.target);  
                        $(treeid_whole).tree('select', node.target);                           
                     }
                     else//选中的是文件，创建兄弟文件
                     {
                        var parent = $(treeid_whole).tree('getParent',selected.target);
                        if(parent){
                            newid = getmaxid(parent);//getmax()获取节点的孩子的最大id 
                            $(treeid_whole).tree('append', {
                                parent:parent.target ,//没有选择节点，作为根节点处理                 
                                data: [{
                                    id:newid,
                                    text: 'default'+newid+'.jl',
                                    state: 'open',
                                    attributes:{url:'ace-master/aceeditor_julia.aspx'},
                                    children: []
                                }]
                            });
                            var node = $(treeid_whole).tree('find', newid); 
                            $(treeid_whole).tree('expandTo', node.target);
                            $(treeid_whole).tree('select', node.target);
                        }else
                        {
                            newid = maxid ;//默认为最大根节点id+1；
                            newid++;
                            $(treeid_whole).tree('append', {
                //                parent: ,//没有选择节点，作为根节点处理                 
                                data: [{
                                    id:newid,
                                    text: 'default'+newid+'.jl',
                                    state: 'open',
                                    attributes:{url:'ace-master/aceeditor_julia.aspx'},
                                    children: []
                                }]
                            });
                            var node = $(treeid_whole).tree('find', newid); 
                            $(treeid_whole).tree('expandTo', node.target); 
                            $(treeid_whole).tree('select', node.target);                       
                        }  
                     }
                 }else
                 {
                    newid = maxid ;//默认为最大根节点id+1；
                    newid++;
                    $(treeid_whole).tree('append', {
        //                parent: ,//没有选择节点，作为根节点处理                 
                        data: [{
                            id:newid,
                            text: 'default'+newid,
                            state: 'open',
                            attributes:{url:'ace-master/aceeditor_julia.aspx'},
                            children: []
                        }]
                    });
                    var node = $(treeid_whole).tree('find', newid); 
                    $(treeid_whole).tree('expandTo', node.target); 
                     $(treeid_whole).tree('select', node.target);                 
                 }
                  addproject(1); 
         }
         //创建目录
         if(flag=='1'){
                 var maxid = getmaxnode();
                 var newid ;
                 var selected = $(treeid_whole).tree('getSelected');  
                 if(selected)
                 {
                     var selected_c = $(treeid_whole).tree('getChildren',selected.target); 
                     if(selected_c.length>0 ||selected.attributes.url==null){ //选中的目录，则创建子目录
                       newid = getmaxid(selected);                                                 
                        $(treeid_whole).tree('append', {
                            parent:selected.target,
                            data: [{
                                id:newid,
                                text: 'default'+newid,
                                state: 'closed',
                                attributes:{},
                                children: []
                            }]
                        }); 
                        var node = $(treeid_whole).tree('find', newid); 
                        $(treeid_whole).tree('expandTo', node.target);
                        $(treeid_whole).tree('select', node.target);
//                      $(treeid_whole).tree('beginEdit',newid);                            
                     }
                     else//选中的是文件，则创建兄弟目录
                     {
                        var parent = $(treeid_whole).tree('getParent',selected.target);
                        if(parent){
                            newid= getmaxid(parent);                                          
                            $(treeid_whole).tree('append', {
                                parent:parent.target ,//没有选择节点，作为根节点处理                 
                                data: [{
                                    id:newid,
                                    text: 'default'+newid,
                                    state: 'closed',
                                    attributes:{},
                                    children: []
                                }]
                            }); 
                            var node = $(treeid_whole).tree('find', newid); 
                            $(treeid_whole).tree('expandTo', node.target);
                            $(treeid_whole).tree('select', node.target);
                        }else
                        {
                            newid = maxid ;//默认为最大根节点id+1；
                            newid++;
                            $(treeid_whole).tree('append', {
                //                parent: ,//没有选择节点，作为根节点处理  (parent?parent.id:null)               
                                data: [{
                                    id:newid,
                                    text: 'default'+newid,
                                    state: 'closed',
                                    attributes:{},
                                    children: []
                                }]
                            });
                            var node = $(treeid_whole).tree('find', newid); 
                            $(treeid_whole).tree('expandTo', node.target);
                            $(treeid_whole).tree('select', node.target);                         
                        } 
                     }
                 }else
                 {
                    newid = maxid ;//默认为最大根节点id+1；
                    newid++;
                    $(treeid_whole).tree('append', {
        //                parent: ,//没有选择节点，作为根节点处理                 
                        data: [{
                            id:newid,
                            text: 'default'+newid,
                            state: 'closed',
                            attributes:{},
                            children: []
                        }]
                    });
                    var node = $(treeid_whole).tree('find', newid); 
                    $(treeid_whole).tree('expandTo', node.target); 
                    $(treeid_whole).tree('select', node.target); 
                 
                 } 
             addproject(0);                   

         }//end of flag=1
          if(flag=='2'){
                var maxid = getmaxnode();
                var newid ;                
                newid = maxid ;//默认为最大根节点id+1；
                newid++;
                $(treeid_whole).tree('append', {
    //                parent: ,//没有选择节点，作为根节点处理                 
                    data: [{
                        id:newid,
                        text: 'project'+newid,
                        state: 'closed',
                        attributes:{},
                        children: []
                    }]
                });
                var node = $(treeid_whole).tree('find', newid); 
                $(treeid_whole).tree('expandTo', node.target); 
                $(treeid_whole).tree('select', node.target);
                addproject(0);
         } 
         if(flag=="3")//删除文件或者目录
         {
            addproject(3);
            var node = $(treeid_whole).tree('getSelected');
            if(node){
                $(treeid_whole).tree('remove',node.target);            
            }
         }          
 	}
 	//文件同步到目录
    function addproject(flag)
 	{ 
        var path = getpath();
 	    save_project_ajax(flag,path);
 	}
 	//获取选择节点的路径
 	function getpath()
 	{
 	 	var path='';
 	    var selected = $(treeid_whole).tree('getSelected'); 	    
 	    var parent_temp; 
 	    if(selected){
 	        path = selected.text;
 	        for( var i=0;i<5;i++)
 	        {
 	            parent_temp = $(treeid_whole).tree('getParent',selected.target);
 	            if(parent_temp) {
 	               selected=parent_temp;
 	               path = parent_temp.text + '\\' +path;
 	            } 	                	        
 	        } 	       
 	        path = 'project' + '\\' +path;
// 	        alert(path);
 	    }
 	    return path;
 	
 	}
    //工程同步或者保存到后台目录，flag=0“创建目录”；falg=1“创建文件”
	function save_project_ajax(flag,project_path){
 	     $.ajax({
                global: false,
                cache: false,
                async: true,              
                data:{"flag":flag,'path':project_path},         
                url: "Ajaxhandle/Handler_project_creat.ashx",
                success: function (data,textstatus) {              
        //              $.messager.alert('Info',data,'info');
                      //alert("response"+data); 
                     // menutree = eval("("+data+")");
                    //do something
                },            
                error: function (msg) {
                    alert(msg.responseText); //输出了出错的信息
                }
        });
    }
 	//文件内容保存
    function savefilecontent()
 	{ 
 	    var path='';
 	    var selected = $(treeid_whole).tree('getSelected'); 	    
 	    var parent_temp;
 	    var editcontent;

 	    if(selected){
 	        path = selected.text;
 	        for( var i=0;i<5;i++)
 	        {
 	            parent_temp = $(treeid_whole).tree('getParent',selected.target);
 	            if(parent_temp) {
 	               selected=parent_temp;
 	               path = parent_temp.text + '\\' +path;
 	            } 	                	        
 	        }
 	        path = 'project' + '\\' +path; 
 	        editcontent = geteditcontent();	
 	        alert(path+"---"+editcontent);	
// 	        //------------------------- 
            savefilecontent_ajax(path,editcontent);
 	    } 	
 	}
 	function savefilecontent_ajax(filepath,filecontent)
	{
	    var content;
	    content = encodeURIComponent(filecontent);
	    $.ajax({
                global: false,
                cache: false,
                async: false,              
                data:{'path':filepath,'filecontent':filecontent},         
                url: "Ajaxhandle/Handler_savefilecontent.ashx",
                success: function (data,textstatus) {              
        //              $.messager.alert('Info',data,'info');
//                      alert("response"+data); 
                     // menutree = eval("("+data+")");
                    //do something
//                    content_file = data;
//                    alert(content_file);
                },            
                error: function (msg) {
                    alert(msg.responseText); //输出了出错的信息
                }
        });      
	
	}
 	
 	function geteditcontent()
 	{
 	     selected = $(treeid_whole).tree('getSelected'); 
 	        var iframe_id =  selected.id;
            var iframeName  = selected.text;
            
            //获取iframe标签对象
 	        var idd = refreshTab();
 	        idd = idd.id;
// 	        var cc = $(document.getElementById(idd).contentWindow.document.body).html(); 	        
 	        var obj=document.getElementById(idd).contentWindow;
 	        var tt_v = obj.getcontent(); 	                   
//            alert(tt_v); 
            return tt_v;
 	
 	}
 	
 	
 	//获取iframe的window对象和document对象
 	function getFrameDocument(frame){
        return frame && typeof(frame)=='object' && frame.tagName == 'IFRAME' 
        && frame.contentDocument || frame.contentWindow && frame.contentWindow.document || frame.document;
    }
    function getFrameWindow(frame){
        return frame && typeof(frame)=='object' && frame.tagName == 'IFRAME' && frame.contentWindow;
    }
    //-------------------------------------------

 	//返回iframe对象
 	function refreshTab(tabTitle){  
 	    var url,id; 
        var refresh_tab = tabTitle?$('#maintab').tabs('getTab',tabTitle):$('#maintab').tabs('getSelected');   
        if(refresh_tab && refresh_tab.find('iframe').length > 0){   
                var _refresh_ifram = refresh_tab.find('iframe')[0]; 
//                url = _refresh_ifram.contentWindow.location.href;   
//                id = _refresh_ifram.id;   
       }   
       return _refresh_ifram;
    }
 	
 	
 	//获取子树的最大ID号
 	function getmaxid(node)
 	{
 	   var s=0; 	   
 	   var brothers = $(treeid_whole).tree('getChildren',node.target); 
 	   for(var i=0;i<brothers.length;i++)
 	   {
 	       var parentid = $(treeid_whole).tree('getParent',brothers[i].target); 
 	       if(s<brothers[i].id && parentid.id==node.id)  s = brothers[i].id
// 	       alert(s);
 	   }
 	   if(s==0){s=node.id*100;}
 	   s++;
 	   return s;
 	}
 	//检查树节点是否重命名
 	function checkname(node){
 	   var s=0; 
 	   var count=0;
 	   var brothers;
 	   var parentid = $(treeid_whole).tree('getParent',node.target); 
 	   if(parentid)
 	       brothers = $(treeid_whole).tree('getChildren',parentid.target);
 	   else 	   
 	      brothers =  $(treeid_whole).tree('getRoots'); 
 	      
 	   for(var i=0;i<brothers.length;i++)
 	   {
           
 	       if(node.id != brothers[i].id && node.text==brothers[i].text)  {s++}
// 	       alert(s);
 	   }
 	   return s; 
 	} 
 	
 	 //动态生成accordion
     /* $('#west-accordion').accordion(options);*/
     var beforeedit_treenode_name='';
     var oldpath='';
     var newpath='';
     function addNav(data) {           
            $.each(data, function(i, sm) //i=索引，sm=取值
             {  
                $('#p').panel({ 
                  title: '解决方案',
                  fit:true,
                  tools: [{   
                    iconCls:'icon-add',   
                    handler:function(){alert('new')}   
                  },{   
                    iconCls:'icon-save',   
                    handler:function(){alert('save')}   
                  }]   
                });
                  
                  var id = "tt"+sm.id; 
//                  id='tt1'; 
//                  $("#wnav").accordion('add',{
//　　                                   title: sm.text,
//　　                                   content:"<ul id='"+id+"'></ul> ",
//　　                                   iconCls: sm.iconCls
//                                                });  
//                 alert(sm.children);
                 var treeid =  '#'+id+''; 
                 treeid_whole = treeid;
                 treename_whole = sm.text;
                 $(treeid).tree({
//                        lines:true,
                        idField:'id',
				        treeField:'text',
                        cascadeCheck:true,
//				        checkbox: true,
			            data :sm.children,                   //备注：引用js变量使用data，引用json文件使用url
				        onClick:function(node)
				        {
//    				        alert('你点击了节点'+ node.text);
//    				        alert('节点属性attribute:'+ node.attributes.url); 
				            if (node.attributes.url!=null) {
				                var filepath = getpath();
//				                filepath = encodeURIComponent(filepath);
				                getfilecontent(filepath);
				                var url =  node.attributes.url+"?filename="+node.text+"&filepath="+filepath+"&filecontent="+encodeURIComponent(content_file);
				                addTab(node.text,url,node.id);
				            }                          

				        },
				        onDblClick:function(node)
				        {
//				             $(treeid_whole).tree('beginEdit',node.target);	
				        },
				        onAfterEdit:function(node)
				        {
				           var s = checkname(node);
				           if(s>0) 
				           {
				               alert("文件重名，请重新输入文件名"); 
				               $(treeid_whole).tree('beginEdit',node.target);
//				                treeeditflag="1";
				           }else
				           {				           
				              newfilepath = getpath();
				              modifytab(beforeedit_treenode_name,node);	
				              renamefile(oldfilepath,newfilepath);	
//				              treeeditflag="0";	           
				           }			        
				        },
				        onBeforeEdit:function(node)
				        {
				            oldfilepath = getpath();
				            beforeedit_treenode_name = node.text;
				           		           
				        },
				        onContextMenu: function(e, node){
		                    e.preventDefault();
		                    // select the node
		                    $(treeid_whole).tree('select', node.target);
		                    // display context menu
		                    $('#mm1').menu('show',{
			                    left: e.pageX,
			                    top: e.pageY
		                    });
		                }			    
			      })/**/	//--------end of tree
			  })//--end of .each
//			var pp = $('#wnav').accordion('panels');
//	        var t = pp[0].panel('options').title;
//	        $('#wnav').accordion('select', t);    		
	}
	
	function renamefile(oldname,newname)	{	  
	   renmane_save_project_ajax(4,'',oldname,newname);
	}
	
	function renmane_save_project_ajax(flag,project_path,oldname,newname){
 	     $.ajax({
                global: false,
                cache: false,
                async: true,              
                data:{"flag":flag,'path':project_path,'oldpath':oldname,'newpath':newname},         
                url: "Ajaxhandle/Handler_project_creat.ashx",
                success: function (data,textstatus) {              
        //              $.messager.alert('Info',data,'info');
                      //alert("response"+data); 
                     // menutree = eval("("+data+")");
                    //do something
                },            
                error: function (msg) {
                    alert(msg.responseText); //输出了出错的信息
                }
        });
    }
	
	function getfilecontent(filepath)
	{   
	    var tempcontent = getcontent_ajax(filepath);
	}
	
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
	
	
	
	function modifytab(beforename,node){
	    	   
	    var title = node.text;
	    if ($('#maintab').tabs('exists', beforename))
	    {
           var tab  =  $('#maintab').tabs('getTab', beforename);           
//            = $('#tt').tabs('getSelected');  // get selected panel
            $('#maintab').tabs('update', {
                       tab: tab,
	                   options: {
		                    title: title	                   
	                  }
            });           
        }
	}
	
    ///树遍历--通过text文本
    //参数为树的ID，注意不要添加#
	function Travel(treeID,text){
       var roots=$(treeID).tree('getRoots'),children,i,j,id;
       for(i=0;i<roots.length;i++){
          if(roots[i].text==text) id = roots[i].id;
//          alert(roots[i].text);
          children=$(treeID).tree('getChildren',roots[i].target);
          if(children){
              for(j=0;j<children.length;j++)  { 
                if(children[j].text==text) { 
                        id = children[j].id;  //alert(children[j].text);
                }
              }
          }
       }
//       alert(id);
       return id;
    }

	//初始化标签
 	function inittab(){
        $('#maintab').tabs({   
            border:false,   
            onSelect:function(title,index){     
                var id = Travel(treeid_whole,title);
                // find a node and then select it
                var node = $(treeid_whole).tree('find', id);
                $(treeid_whole).tree('select', node.target);
                $(treeid_whole).tree('expandTo', node.target); 
            }   
        }); 
      
 	} 
	//主页加载
	/*function showpage(url){
         $('#content').load(url);
    }	*/ 
    //主页添加一个新标签    
    function addTab(title, url,id){
//    alert(url);
        if ($('#maintab').tabs('exists', title)){
            $('#maintab').tabs('select', title);
        } else {
            var content = '<iframe id = "if'+ id +'"  scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
            $('#maintab').tabs('add',{
                title:title,
                content:content,
                closable:true,
                iconCls:""
            });
        }    

    }  
    //编译页添加一个新标签    
    function addTabssh(title, url,id){
//    alert(url);
        if ($('#sshtab').tabs('exists', title)){
            $('#sshtab').tabs('select', title);
        } else {
            var content = '<iframe id = "if'+ id +'"  scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
            $('#sshtab').tabs('add',{
                title:title,
                content:content,
                closable:false,
                iconCls:""
            });
        }    

    } 
    
    function iniwindow()
    {
        $('#win').window({   
                width:600,   
                height:400,   
                modal:true,
                title:'窗口',
                closed:true 
        });
    }


		
</script>
    
    
</head>
<body class="easyui-layout">  
	 <div region="north" title="" border="false" style="overflow:hidden;height:30px;text-align:right; vertical-align:top;">
	 
        <div style="padding:5px;width:100%; text-align:left;">
            <a href="javascript:void(0)" id="mb1" icon="icon-edit">文件管理</a>
              <a href="javascript:void(0)" id="mb3" icon="icon-edit">工具</a>
               <a href="javascript:void(0)" id="mb4" icon="icon-edit">调试</a>
            <a href="javascript:void(0)" id="mb2" icon="icon-help">帮助</a>
        </div>
         <div id="mm1" style="width:150px;">
            <div icon="icon-reload">新建工程</div>
            <div class="menu-sep"></div>
            <div icon="icon-undo">新建目录</div>
            <div class="menu-sep"></div>
            <div icon="icon-undo">新建文件</div>           
            <div icon="icon-remove">删除文件</div>         
            <div icon="icon-redo">保存文件</div>
            <div class="menu-sep"></div>
            <div icon="icon-redo">重命名</div> 
              <div class="menu-sep"></div>
            <div icon="icon-remove">退出</div>
        </div>
        <div id="mm3" style="width:100px;">
            <div>端口设置</div>
            <div>文件上传</div>
            <div>控制台</div>
        </div>
       <div id="mm4" style="width:100px;">
            <div>Debug</div>
            <div>Run</div>
            <div>SSH</div>
        </div>
        <div id="mm2" style="width:100px;">
            <div>帮助</div>
            <div>升级</div>
            <div>关于</div>
        </div>
     </div>
	<div region="south"  split="true" collapsed="true" title='' border="false"  style="height:150px;padding:0px;">
		<div class="easyui-layout" fit="true" style="background:#ccc;">
		    <div region="center"  style="overflow:hidden;" id="ssh">
		         <div class="easyui-tabs" fit="true" border="false" id="sshtab">

			</div>
		     </div>
			<div region="south" border="false"  style="padding:0px;text-align:center;background:#fff;border:1px solid #ccc;">国家超算济南中心@2012</div>
			
		</div>
	</div>
	<div region="west" split="true" title="" style="width:200px;padding:1px;overflow:hidden;">
	<%--	<div fit="true" border="false" SelectedIndex="1" id="wnav" class="easyui-accordion" >
			
		  </div>	--%>
		  <div id="p" style="padding:2px;">   
		       <ul id="tt1"></ul >      
          </div>
	</div>
	<div region="center" split="true" style="overflow:hidden;" id="content">
		<div class="easyui-tabs" fit="true" border="true" id="maintab">

			</div>
		</div>	
	<div id="win" >  tttt
                <div class="easyui-layout" fit="true" style="background:#ccc;">  
                    <div region='north' style="height:100px">yhhhhh</div>  
                    <div region='center' fit="true">  
                        The Content.   
                    </div>
                </div>
     </div>
</body>
</html>
