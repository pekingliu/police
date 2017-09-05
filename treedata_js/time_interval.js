// JScript 文件

          var d,d1,timeinterval, timeinterval1;;

  //获取开始时间
  function showTime(){
     d = new Date();                               
     var s = "";
     s += d.getYear() + "-";                       
     s += (d.getMonth() + 1)   +   "-";            
     s += d.getDate() + " ";                       
     s += d.getHours() + ":";                      
     s += d.getMinutes() + ":";                     
     s += d.getSeconds() + ":";                    
     s += d.getMilliseconds();                      
//     timeinterval += timeinterval + s;
//   
//     document.getElementById("starttime").value = s;    
//     document.getElementById("endtime").value = "";     
//     document.getElementById("interval").value = "";    
  }

  //获取结束时间
  function showTime2(){
     d1 = new Date();   
     var s1 = "";
     s1 += d1.getYear() + "-";   
     s1 += (d1.getMonth() + 1) + "-";  
     s1 += d1.getDate() + " "; 
     s1 += d1.getHours() + ":";
     s1 += d1.getMinutes() + ":";
     s1 += d1.getSeconds() + ":";
     s1 += d1.getMilliseconds();
//     timeinterval1 += timeinterval1 + s1; 
//     document.getElementById("endtime").value = s1;
//     document.getElementById("interval").value = ""; 
  }

  //计算时间差
  function showInterval(){
  
   var sjc = ((d1.getTime()-d.getTime())/1000);
     if(sjc <= 0){
       alert("结束时间不能比开始时间早！"); 
    }else{
       timeinterval = sjc;
//       document.getElementById("interval").value = sjc + "秒";
       alert("sjc"+sjc);    
    }
  }