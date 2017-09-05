 	var _menus = {   //添加json数据对象_menus
	   "basic" :  [
		 {
	    "id":20,       //  序列号
	    "text":"基础数据",//"title" : "基础数据",
	    "iconCls":"icon-ok",//"iconCls" : "",
	    "state":"closed",   //"content" : "icon-sys",
	    "children":[{     //"tree" :
			"id":1,
			"text":"menu",
			"iconCls":"icon-ok",
			"state":"closed",
			"attributes":{
				      "url":"layout.aspx"				
					},
			"children":[{
			"id":2,
				"text":"File1",
				"checked":true
			},{
			"id":3,
				"text":"Folder2",
				"state":"open",
				"children":[{
			"id":4,
					"text":"File3",
					"attributes":{
						"p1":"value1",
						"p2":"value2",
						"url":"default.aspx"
					},
					"checked":true,
					"iconCls":"icon-reload"
				},{
			"id": 8,
					"text":"Async Folder",
					"state":"closed"
				}]
			}]
               }
	       ]		
               },{
	    "id":10,       //  序列号
	    "text":"系统管理",//"title" : "系统管理",
	    "iconCls":"icon-ok",//"iconCls" : "",
	    "state":"closed",   //"content" : "icon-sys",
	    "children":[{     //"tree" :
			"id":1,
			"text":"menu",
			"iconCls":"icon-ok",
			"state":"closed",
			"attributes":{
				      "url":"layout.aspx"				
					},
			"children":[{
			"id":2,
				"text":"File1",
				"checked":true
			},{
			"id":3,
				"text":"Folder2",
				"state":"open",
				"children":[{
			"id":4,
					"text":"File3",
					"attributes":{
						"p1":"value1",
						"p2":"value2",
						"url":"default.aspx"
					},
					"checked":true,
					"iconCls":"icon-reload"
				},{
			"id": 8,
					"text":"Async Folder",
					"state":"closed"
				}]
			}]
               }
	       ]
        }
	]
	}
	
	
	var _tree =  [{
			"id":1,
			"text":"menu",
			"iconCls":"icon-ok",
			"state":"closed",
			"attributes":{
				      "url":"http://www.1616.net"				
					},
			"children":[{
			"id":2,
				"text":"File1",
				"checked":true
			},{
			"id":3,
				"text":"Folder2",
				"state":"open",
				"children":[{
			"id":4,
					"text":"File3",
					"attributes":{
						"p1":"value1",
						"p2":"value2",
						"lll":"default.aspx"
					},
					"checked":true,
					"iconCls":"icon-reload"
				},{
			"id": 8,
					"text":"Async Folder",
					"state":"closed"
				}]
			}]
               }
	       ]

// = {"basic":[{"id":"1","parentid":"-1","text":"基本功能","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"2","parentid":"-1","text":"反窃密数据维护","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"3","parentid":"-1","text":"总体查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"4","parentid":"-1","text":"攻击统计查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"5","parentid":"-1","text":"IP查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"6","parentid":"-1","text":"非中国国家攻击查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"7","parentid":"-1","text":"同源攻击","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"8","parentid":"-1","text":"系统字典","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"9","parentid":"-1","text":"系统管理","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]}
/*var _tree_dynamic = {"basic":[
                       {"id":"1","parentid":"-1","text":"基本功能","state":"closed","iconCls":"",
                       "attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                    "children":[{"id":"10","parentid":"1","text":"密码修改","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                                                {"id":"11","parentid":"1","text":"退出","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},
                       {"id":"2","parentid":"-1","text":"反窃密数据维护","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                   "children":[{"id":"12","parentid":"2","text":"反窃密数据导入","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},
                       {"id":"3","parentid":"-1","text":"总体查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"4","parentid":"-1","text":"攻击统计查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"5","parentid":"-1","text":"IP查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"6","parentid":"-1","text":"非中国国家攻击查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"7","parentid":"-1","text":"同源攻击","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"8","parentid":"-1","text":"系统字典","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                       {"id":"9","parentid":"-1","text":"系统管理","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]}
var _tree_dynamic =  {"basic":[
                    {"id":"1","parentid":"-1","text":"基本功能","state":"closed","iconCls":"",
                    "attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                 "children":[{"id":"10"},"parentid":"1"},"text":"密码修改"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},
                                             {"id":"11"},"parentid":"1"},"text":"退出"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},
                    {"id":"2","parentid":"-1","text":"反窃密数据维护","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                 "children":[{"id":"12"},"parentid":"2"},"text":"反窃密数据导入"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},
                    {"id":"3","parentid":"-1","text":"总体查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                 "children":[{"id":"13"},"parentid":"3"},"text":"反窃密数据查询"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},
                    {"id":"4","parentid":"-1","text":"攻击统计查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
                                 "children":[{"id":"14"},"parentid":"4"},"text":"反复攻击比对"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"15"},"parentid":"4"},"text":"反复攻击政府机关比对"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"16"},"parentid":"4"},"text":"国外反复攻击政府机关比对"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"17"},"parentid":"4"},"text":"非中国国家攻击"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},{"id":"5","parentid":"-1","text":"IP查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"18"},"parentid":"5"},"text":"IP地址查询"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},{"id":"6","parentid":"-1","text":"非中国国家攻击查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"19"},"parentid":"6"},"text":"国外攻击查询"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},{"id":"7","parentid":"-1","text":"同源攻击","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"20"},"parentid":"7"},"text":"同源多目标攻击"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"21"},"parentid":"7"},"text":"同源政府多目标攻击"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},{"id":"8","parentid":"-1","text":"系统字典","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"22"},"parentid":"8"},"text":"政府机关数据仓库"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]},{"id":"9","parentid":"-1","text":"系统管理","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"23"},"parentid":"9"},"text":"用户管理"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"24"},"parentid":"9"},"text":"权限管理"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"25"},"parentid":"9"},"text":"数据库连接设置"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"26"},"parentid":"9"},"text":"IP转化"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""},{"id":"27"},"parentid":"9"},"text":"导入测试"},"state":"closed"},"iconCls":""},"attributes":{"url":"default.aspx"}},"checked":""},"isFolder":""},"isLeaf":""},"orderNum":""}]}]}




var _tree_dynamic = {"basic":[{"id":"1","parentid":"-1","text":"基本功能","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"10","parentid":"1","text":"密码修改","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"11","parentid":"1","text":"退出","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},{"id":"2","parentid":"-1","text":"反窃密数据维护","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"","children":[{"id":"12","parentid":"2","text":"反窃密数据导入","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},{"id":"3","parentid":"-1","text":"总体查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"4","parentid":"-1","text":"攻击统计查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"5","parentid":"-1","text":"IP查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"6","parentid":"-1","text":"非中国国家攻击查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"7","parentid":"-1","text":"同源攻击","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"8","parentid":"-1","text":"系统字典","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},{"id":"9","parentid":"-1","text":"系统管理","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]}

_tree_dynamic = {"basic":[
{"id":"1","parentid":"-1","text":"基本功能","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
"children":[{"id":"10","parentid":"1","text":"密码修改","state":"closed","iconCls":"","attributes":{"url":""},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
             "children":[{"id":"13","parentid":"10","text":"测试3级菜单1","state":"","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""},
                         {"id":"14","parentid":"10","text":"测试3级菜单2","state":"","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},
	    {"id":"11","parentid":"1","text":"退出","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},
{"id":"2","parentid":"-1","text":"反窃密数据维护","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":"",
            "children":[{"id":"12","parentid":"2","text":"反窃密数据导入","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]},
{"id":"3","parentid":"-1","text":"总体查询","state":"closed","iconCls":"","attributes":{"url":"default.aspx"},"checked":"","isFolder":"","isLeaf":"","orderNum":""}]}
*/
        function arrayToJson(o) { 
            var r = []; 
            if (typeof o == "string") return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\""; 
            if (typeof o == "object") { 
            if (!o.sort) { 
            for (var i in o) 
            r.push(i + ":" + arrayToJson(o[i])); 
            if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) { 
            r.push("toString:" + o.toString.toString()); 
            } 
            r = "{" + r.join() + "}"; 
            } else { 
            for (var i = 0; i < o.length; i++) { 
            r.push(arrayToJson(o[i])); 
            } 
            r = "[" + r.join() + "]"; 
            } 
            return r; 
            } 
            return o.toString(); 
        } 

        function arrTojson(arr){
            var i,jsonstr;
            jsonstr="[{";
            for(i=0;i<arr.length;i++){
                jsonstr += "\"" + arr[i] + "\""+ ":" + "\"" + arr[i] + "\",";
            }
            jsonstr = jsonstr.substring(0,jsonstr.lastIndexOf(','));
            jsonstr += "}]";
            return jsonstr;
        }
         /*
       //绑定tabs的右键菜单
        $("#maintab").tabs({
            onContextMenu : function (e, title) {
	            e.preventDefault();
	            $('#tabsMenu').menu('show', {
		            left : e.pageX,
		            top : e.pageY
	            }).data("tabTitle", title);
            }
        });
    	
        //实例化menu的onClick事件
        $("#tabsMenu").menu({
            onClick : function (item) {
	            CloseTab(this, item.name);
            }
        });
    	
        //几个关闭事件的实现
        function CloseTab(menu, type) {
            var curTabTitle = $(menu).data("tabTitle");
            var tabs = $("#maintab");
    		
            if (type === "close") {
	            tabs.tabs("close", curTabTitle);
	            return;
            }
    		
            var allTabs = tabs.tabs("maintab");
            var closeTabsTitle = [];
    		
            $.each(allTabs, function () {
	            var opt = $(this).panel("options");
	            if (opt.closable && opt.title != curTabTitle && type === "Other") {
		            closeTabsTitle.push(opt.title);
	            } else if (opt.closable && type === "All") {
		            closeTabsTitle.push(opt.title);
	            }
            });
    		
            for (var i = 0; i < closeTabsTitle.length; i++) {
	            tabs.tabs("close", closeTabsTitle[i]);
            }
        }*/
        


    //释放iframe内存
    /*$.fn.panel.defaults = $.extend({},$.fn.panel.defaults,{onBeforeDestroy:function(){
        var frame=$('iframe', this);
        if(frame.length>0){
            frame[0].contentWindow.document.write('');
            frame[0].contentWindow.close();
            frame.remove();
            if($.browser.msie){
	            CollectGarbage();
            }
        }
        }
    });*/
    
    
    //datagridajax传输方式
// 	function InitGrid(){
//      $("#Gird").datagrid({
//        url:'',
//        loadMsg:'',
//        columns:[[]],
//        ....
//      });
//     }

// 	function GetData(url){
//         $.ajax({
//          url:url,
//          type:"post",
//          data:'...',
//         dataType:'json',
//         success:function(json){
//          $("#Grid").datagrid("loadData",json);
//          }
//         });
//        }

//    function replaceUrl(){ 
//      GetData(url);
//    }
   //-------------------------------
   
   
           





