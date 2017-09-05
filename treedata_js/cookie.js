// JScript 文件

////JS操作cookies方法!
////写cookies
//function setCookie(name,value)
//{
//    var Days = 30;
//    var exp = new Date(); 
//    exp.setTime(exp.getTime() + Days*24*60*60*1000);
//    document.cookie = name + ”=”+ escape (value) + ”;expires=” + exp.toGMTString();
//}
////读取cookies
//function getCookie(name)
//{
//    var arr,reg=new RegExp(”(^| )”+name+”=([^;]*)(;|$)”);
//    if(arr=document.cookie.match(reg)) return unescape(arr[2]);
//    else return null;
//}
////删除cookies
//function delCookie(name)
//{
//    var exp = new Date();
//    exp.setTime(exp.getTime() - 1);
//    var cval=getCookie(name);
//    if(cval!=null) document.cookie= name + ”=”+cval+”;expires=”+exp.toGMTString();
//}
////使用示例
////setCookie(”name”,”hayden”);
////alert(getCookie(”name”));
////如果需要设定自定义过期时间
////那么把上面的setCookie　函数换成下面两个函数就ok;
////程序代码
//function setCookie(name,value,time){
//    var strsec = getsec(time);
//    var exp = new Date();
//    exp.setTime(exp.getTime() + strsec*1);
//    document.cookie = name + ”=”+ escape (value) + ”;expires=” + exp.toGMTString();
//}
//function getsec(str){
//    alert(str);
//    var str1=str.substring(1,str.length)*1; 
//    var str2=str.substring(0,1); 
//    if (str2==”s”){
//    return str1*1000;
//    }else if (str2==”h”){
//    return str1*60*60*1000;
//    }else if (str2==”d”){
//    return str1*24*60*60*1000;
//    }
//}
////这是有设定过期时间的使用示例：
////s20是代表20秒
////h是指小时，如12小时则是：h12
////d是天数，30天则：d30
////暂时只写了这三种
////setCookie(”name”,”hayden”,”s20″);

////文章来自中国建站：http://www.jz123.cn/text/1515014.html


/**//************************************************************************

|    函数名称： setCookie                                                |
|    函数功能： 设置cookie函数                                            |
|    入口参数： name：cookie名称；value：cookie 值                        |
|    维护记录： RainBow(创建）                                            |
|    版权所有： (C) 2006-2007                    |
|    编写时间： 2007年9月13 日 21:00                                        |
*************************************************************************/
function setCookie(name, value) 
{ 
    var argv = setCookie.arguments; 
    var argc = setCookie.arguments.length; 
    var expires = (argc > 2) ? argv[2] : null; 
    if(expires!=null) 
    { 
        var LargeExpDate = new Date (); 
        LargeExpDate.setTime(LargeExpDate.getTime() + (expires*1000*3600*24));         
    } 
    document.cookie = name + "=" + escape (value)+((expires == null) ? "" : ("; expires=" +LargeExpDate.toGMTString()))+"; path=" + "/"; 
}
/**//************************************************************************
|    函数名称： getCookie                                                |
|    函数功能： 读取cookie函数                                            |
|    入口参数： Name：cookie名称                                            |
|    维护记录： RainBow(创建）                                            |
|    版权所有： (C) 2006-2007                    |
|    编写时间： 2007年9月13 日 21:02                                        |
*************************************************************************/
function getCookie(Name) 
{ 
    var search = Name + "=" ;
    if(document.cookie.length > 0) 
    { 
        offset = document.cookie.indexOf(search) 
        if(offset != -1) 
        { 
            offset += search.length 
            end = document.cookie.indexOf(";", offset) 
            if(end == -1) end = document.cookie.length 
            return unescape(document.cookie.substring(offset, end)) 
        } 
        else return ""; 
    } 
} 

/**//************************************************************************
|    函数名称： deleteCookie                                            |
|    函数功能： 删除cookie函数                                            |
|    入口参数： Name：cookie名称                                        |
|    维护记录： RainBow(创建）                                        |
|    版权所有： (C) 2006-2007                 |
|    编写时间： 2007年9月15 日 18:10                                    |
*************************************************************************/    
function delCookie(name) 
{ 
     var expdate = new Date(); 
     expdate.setTime(expdate.getTime() - (86400 * 1000 * 1)); 
     setCookie(name, "", expdate); 
} 

