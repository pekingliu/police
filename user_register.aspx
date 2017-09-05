<%@ Page Language="C#" AutoEventWireup="true" CodeFile="user_register.aspx.cs" Inherits="julia.web.user_register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>用户注册</title>
    <link rel="stylesheet" rev="stylesheet" href="css/register.css" type="text/css" media="screen"
			charset='gb2312"' />
    <style type="text/css">
        .style1
        {
            width: 400px;
        }
        .style3
        {
            width: 400px;
            height: 36px;
        }
        .style4
        {
            width: 450px;
            height: 36px;
        }
        .style5
        {
            color: #0000FF;
        }
    </style>
</head>
<body bgcolor="#FFFFFF" >
    <form id="form1" runat="server"  >
    <table style="width:100%;">
        <tr>   <th colspan="4" align="center">
                </th>        
        </tr> 
        <tr>
   
        <td align="center" >   
        
        <table style="width:550px;" id="formwrapper" >
 


        <tr >
        <td align="center"  colspan="2"  >
            <asp:Image ID="Image1" runat="server"  ImageUrl=""/>
            </td>
        
        
         </tr>          <tr >
        <td align="right" class="style1"  >
            &nbsp;</td>
        <td align="left" >   &nbsp;</td>
        
         </tr>
        <tr >
        <td align="right" class="style1"  >
            用户登陆名：               
        </td>
        <td align="left" >   <asp:TextBox ID="TextName" runat="server"></asp:TextBox>
            <span class="style5">（请填写字母和数字）</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" 
                    ControlToValidate="TextName" ErrorMessage="*必须填写" ForeColor="#FF3300"></asp:RequiredFieldValidator>    
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                ControlToValidate="TextName" ErrorMessage="请填写字母和数字" 
                ValidationExpression="^\w+$"></asp:RegularExpressionValidator>
        </td>
        
         </tr>
         
        <tr>
        
       
        <td align="right" class="style1" >       
           密码：
            </td>
        
       
        <td align="left" style=" width:450px;" >   <asp:TextBox ID="Textpassword" runat="server"></asp:TextBox>      
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassWord" runat="server" ErrorMessage="*必须填写" ControlToValidate="Textpassword"></asp:RequiredFieldValidator></td>
        
         </tr>
         
        <tr><td align="right" class="style1"  > 单位名称：</td>
        <td align="left"  > 
           <asp:TextBox ID="TextPass" runat="server" AutoCompleteType="Disabled" 
                Width="348px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" runat="server" 
                    ControlToValidate="TextPass" ErrorMessage="*必须填写" ForeColor="Red"></asp:RequiredFieldValidator> &nbsp;</td>
        </tr>
        <tr><td align="right" class="style1"  >联系人(上机人)：</td>
            <td align="left"  >       
               <asp:TextBox ID="TextTrueName" runat="server"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextTrueName" ErrorMessage="*必须填写" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="TextTrueName" ErrorMessage="请输入中文、英文名字" 
                    ValidationExpression="^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$"></asp:RegularExpressionValidator>
               </td>
        </tr>
        <tr>
        <td align="right" class="style1"  > 邮编地址：</td>
        <td align="left"  > 
           <asp:TextBox ID="TextQuestion" runat="server" Height="23px" Width="352px"></asp:TextBox> &nbsp;<asp:RequiredFieldValidator 
                ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextQuestion" 
                ErrorMessage="*必须填写" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
         </tr>

        <tr>
        <td align="right" class="style1"  > 
            电话/传真： 
               </td>
        <td align="left"  > 
           <asp:TextBox ID="TextPhone" runat="server" Width="241px"></asp:TextBox>  &nbsp;<asp:RequiredFieldValidator 
                ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextPhone" 
                ErrorMessage="*必须填写" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="TextPhone" ErrorMessage="请输入有效的电话号码" 
                ValidationExpression="((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)|(^(d{2,4}[-_－—]?)?d{3,8}([-_－—]?d{3,8})?([-_－—]?d{1,7})?$)|(^0?1[35]d{9}$)|^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|^(((d{3}))|(d{3}-))?13[0-9]d{8}|15[89]d{8}"></asp:RegularExpressionValidator>
            </td>
         </tr>
        <tr>
        <td align="right" class="style1"  > 电子邮件：
               </td>
        <td align="left"  > 
             <asp:TextBox ID="TextEmail" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" 
                    ControlToValidate="TextEmail" ErrorMessage="*必须填写" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" 
                    runat="server" ControlToValidate="TextEmail" ErrorMessage="*格式不正确" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                 ForeColor="Red"></asp:RegularExpressionValidator>&nbsp;</td>
          </tr>

   <%--     <tr>
        <td align="right" class="style1" > 
            服务条款：</td>
        <td align="left" style=" width:450px;" >
            <asp:HyperLink ID="HyperLink1" runat="server" 
                NavigateUrl="~/用户上机承诺书.doc" Target="_blank">阅读：用户上机承诺书、</asp:HyperLink>
                <asp:HyperLink ID="HyperLink2" runat="server" 
                NavigateUrl="~/保 密 协 议 书.doc" Target="_blank">保密协议书</asp:HyperLink>
            
            </td>
         </tr>
        <tr>
        <td align="right" class="style1" > 
            &nbsp;</td>
        <td align="left" style=" width:450px;" > 
       <asp:CheckBox 
                ID="CheckBox1" runat="server" Text="同意以上协议" />
            <asp:CustomValidator ID="CustomValidator1" runat="server" 
                ErrorMessage="CustomValidator"></asp:CustomValidator>
           
         </tr>
        <tr>
        
       
        <td align="char" class="style3" >       
           
           
        
       
        <td align="left" class="style4" >       
                 
 
            <p>
                <strong>* 在提交您的注册信息时, 我们认为您已经同意了我们的服务条款.<br />
                * 这些条款可能在未经您同意的时候进行修改.</strong></p>
                 
 
            </td>
        
         </tr>--%>
  

        <tr>
        
       
        <td align="center"  colspan="2" >       
           
             <br />
                <asp:Button ID="ButtonLogin" runat="server" Text="注册" class="buttom" 
                    onclick="ButtonLogin_Click"  />
                <asp:Button ID="ButtonCancel" runat="server" OnClientClick="return regend()" onclick="ButtonCancel_Click1" class="buttom"
                   Text="取消" />
                &nbsp;</td>
        
         </tr>

        </table>
        </td>
            
            
        </tr> 
        <tr>
            <td colspan=4 align="center" >
     
            </td>
        </tr>
    </table>
    </form>
<SCRIPT language="javascript">

    function register_license() {

        /*var tttt = window.document.getElementById("chkbox").checked;
        alert(tttt);
        if (tttt) {
            var erere = window.document.getElementById("ButtonLogin");
           var fff =  document.getElementById('<%= ButtonLogin.ClientID%>').
           alert(erere);
           alert(fff);        

        } else {
            window.document.getElementById("ButtonLogin").setAttribute("Enabled", false);
        
        }   */
    
    }
    function truWebsite() {
        window.open("trustWebsite.htm");
    }
    function regend() {
        window.close();
    }

    function regWebsite() {
       // alert("准备打开注册页！！");
        //window.open("login.aspx");
        window.open("login.aspx", "_top", "toolbar=no,menubar=no,titlebar=no,directories=no,location=no,resizable=no,status=yes,fullscreen=no,top=0;left=0,width=800,height=600");
       // alert("打开注册页！！");
    }

</SCRIPT>


</body>
</html>
