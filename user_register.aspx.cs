using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;


namespace julia.web
{
    public partial class user_register : System.Web.UI.Page
    {
        public static string strSQL;
        //		private string strSQL2;
        //与SQL Server的连接字符串设置

        //      private string autoconnect =  "Auto Translate=True;Integrated Security=SSPI;User ID=sa;Data Source=localhost;Tag with column collation when possible=False;Initial Catalog=STEST;Use Procedure for Prepare=1;Provider="SQLOLEDB.1";Persist Security Info=False;Workstation ID=PEKING;Use Encryption for Data=False;Packet Size=4096"
        public string connectionString = "Server=localhost;database=juliadb;uid=sa;pwd=sa";
        //		public string connectionString = "Server=172.16.8.251;database=stest;User Id = sa; Password= 'SDSTC'";
        //public string connectionString = frm_login.strConn;
        //与数据库的连接
        private SqlConnection myConnection;
        private SqlCommand myCommand;
        private SqlCommandBuilder sqlCmdBld;
        private DataSet ds = new DataSet();
        private SqlDataAdapter da;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //检索数据库数据(传字符串,直接操作数据库)
        public DataTable SelectDataBase(string tempStrSQL)
        {
            this.myConnection = new SqlConnection(connectionString);
            DataSet tempDataSet = new DataSet();
            this.da = new SqlDataAdapter(tempStrSQL, this.myConnection);
            this.da.Fill(tempDataSet);
            return tempDataSet.Tables[0];
        }

        //数据库数据更新(传字符串，直接操作数据库)
        public int UpdateDataBase(string tempStrSQL)
        {
            this.myConnection = new SqlConnection(connectionString);
            //使用Command之前一定要先打开连接,后关闭连接,而DataAdapter则会自动打开关闭连接
            myConnection.Open();
            SqlCommand tempSqlCommand = new SqlCommand(tempStrSQL, this.myConnection);
            int intNumber = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
            myConnection.Close();
            return intNumber;
        }

        //数据库数据更新---事务处理(传多字符串，直接操作数据库，失败后回滚)
        public bool UpdateDataBase_transaction(string sql_r, string sql_l, string sql_c, string sql_s)
        {
            this.myConnection = new SqlConnection(connectionString);
            //使用Command之前一定要先打开连接,后关闭连接,而DataAdapter则会自动打开关闭连接
            myConnection.Open();
            //SqlCommand command = myConnection.CreateCommand();
            SqlCommand tempSqlCommand = new SqlCommand();//(tempStrSQL, this.myConnection);
            SqlTransaction transaction;
            transaction = myConnection.BeginTransaction("SampleTransaction");
            tempSqlCommand.Connection = myConnection;
            tempSqlCommand.Transaction = transaction;

            try
            {
                tempSqlCommand.CommandText = sql_r;
                int tempr = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                tempSqlCommand.CommandText = sql_l;
                int templ = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                tempSqlCommand.CommandText = sql_c;
                int tempc = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                tempSqlCommand.CommandText = sql_s;
                int temps = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                return false;
            }
        }

        //数据库数据更新---事务处理(传多字符串，直接操作数据库，失败后回滚)
        public bool UpdateDataBase_transaction_1(string sql_r)
        {
            this.myConnection = new SqlConnection(connectionString);
            //使用Command之前一定要先打开连接,后关闭连接,而DataAdapter则会自动打开关闭连接
            myConnection.Open();
            //SqlCommand command = myConnection.CreateCommand();
            SqlCommand tempSqlCommand = new SqlCommand();//(tempStrSQL, this.myConnection);
            SqlTransaction transaction;
            transaction = myConnection.BeginTransaction("SampleTransaction");
            tempSqlCommand.Connection = myConnection;
            tempSqlCommand.Transaction = transaction;

            try
            {
                tempSqlCommand.CommandText = sql_r;
                int tempr = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                //tempSqlCommand.CommandText = sql_l;
                //int templ = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                //tempSqlCommand.CommandText = sql_c;
                //int tempc = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                //tempSqlCommand.CommandText = sql_s;
                //int temps = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
                transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                return false;
            }
        }

        public long MaxColumnValue(string tempStrSQL)
        {
            //			strSQL = tempStrSQL;
            this.myConnection = new SqlConnection(connectionString);
            this.myConnection.Open();
            long intNum;
            this.myCommand = new SqlCommand(tempStrSQL, this.myConnection);
            if (this.myCommand.ExecuteScalar() == DBNull.Value)
            {
                intNum = 0;
            }
            else
            {
                intNum = Convert.ToInt32(this.myCommand.ExecuteScalar().ToString());
            }
            //			Double to int conversion can overflow.
            //          intVal = System.Convert.ToInt32(doubleVal);
            myConnection.Close();
            return intNum;
        }

        protected int isName()
        {
            int i;
            String name = TextName.Text;
            if (name.Trim() != "")
            {
                SqlConnection con = new SqlConnection(connectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("select count(*) from USERS where username ='" + name + "'", con);
                return i = cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                return 1;
            }
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            //if (CheckBox1.Checked)
            //{
                String name = TextName.Text;
                string nameif = "select count(*) from USERS where username ='" + name + "'";
                long i = MaxColumnValue(nameif);
                if (i <= 0)
                {
                    if (add_new())
                    {
                        Response.Write("<script>location='welcome_print.aspx?name=" + TextName.Text + "&pass="+ Textpassword.Text+"';</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('注册失败！')<script>");
                    }

                }
                else
                {
                    Response.Write("<script>alert('用户登录名已经存在！')</script>");
                }
            //}
            //else
            //{
            //    Response.Write("<script>alert('请阅读并同意用户合作协议！')</script>");
            //}
        }

        public bool add()
        {

            //string pass = FormsAuthentication.HashPasswordForStoringInConfigFile(TextPass.Text, "MD5");
            //string sex="";
            //NewID();
            DateTime tt = new DateTime();
            tt = DateTime.Now;
            string sql = "INSERT INTO USERS (username, customer_unitname, customer_agentpersion, " +
                                             " customer_address, customer_telephone, customer_email,customer_register_flag,customer_register_datetime )" +
                                             " VALUES ('" + TextName.Text + "','" + TextPass.Text + "','" + TextTrueName.Text +
                                                    "','" + TextQuestion.Text + "','" + TextPhone.Text +
                                                    "','" + TextEmail.Text + "',0,'" + tt + "')";
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int i = Convert.ToInt32(cmd.ExecuteNonQuery());
            con.Close();
            if (i > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
            //return true;

        }
        public Guid request_guid()
        {

            Guid tempguid = System.Guid.NewGuid();
            return tempguid;
        }
        public bool add_new()
        {
            DateTime tt = new DateTime();
            tt = DateTime.Now;
            Guid customer_guid = request_guid();
            //Guid login_guid = request_guid();
            //Guid contact_guid = request_guid();
            //Guid skin_guid = request_guid();
            //网页注册用户
            string sql_reg = "INSERT INTO USERS (ocs_customerOID,username, customer_unitname, customer_agentpersion, " +
                                 " customer_address, customer_telephone, customer_email,customer_register_flag,customer_register_datetime,USERPASSWORD )" +
                                 " VALUES ('" + customer_guid + "','" + TextName.Text + "','" + TextPass.Text + "','" + TextTrueName.Text +
                                        "','" + TextQuestion.Text + "','" + TextPhone.Text +
                                        "','" + TextEmail.Text + "',1,'" + tt + "','"+Textpassword.Text+"')";
            #region 其他版本
            //登录用户
            //string maxnum = " select max(UserID) from UCML_User ";
            //long i = MaxColumnValue(maxnum);
            //i++;
            //string sql_login =
            //" INSERT INTO UCML_User " +
            //      " (UCML_UserOID,USR_LOGIN, PassWord, USER_FLG," +
            //      " PasswordFormat, IsApproved, IsLockedOut, " +
            //      " OnlineState, ucmlctID, UserID, EmployeeName,IsLogin, DDstate," +  //ucmlctid 和userid自增加
            //      " DingDangCanAddFriend, UCML_CONTACTOID)" +
            //" VALUES ('" + login_guid + "','" + TextName.Text + "','hE91mW0MvQh1ffs46bnMFA==', 1," +
            //      " 0, 0, 0, " +
            //      " 0, " + i + "," + i + ", '" + TextTrueName.Text + "', 0, 0, " +
            //      " 0,'" + contact_guid + "')";
            ////用户详细信息
            //string maxno = " select max(CON_EMP_NUM) from UCML_CONTACT ";
            //long j = MaxColumnValue(maxno);
            //j++;
            //string sql_contact =
            //         " INSERT INTO UCML_CONTACT " +
            //              " (UCML_CONTACTOID," +          //用户详细信息ID  
            //              "CON_EMP_NUM, PersonName, PERSON_TYPE, SYS_Created, " +  //CON_EMP_NUM需要自动生成
            //              " SYS_CreatedBy, " +           //创建人员登录ID
            //              " SYS_POSTN, " +               //创建人员角色   
            //              " SYS_DIVISION," +             //创建人员部门
            //              " SYS_ORG, SYS_LAST_UPD, " +   //创建人员组织机构
            //              " SYS_LAST_UPD_BY,Status, " +
            //              " UCML_UserOID, " +            //用户登录ID
            //              " UCML_DivisionOID, " +        //用户部门ID
            //              " UCML_PostOID, " +            //用户角色ID
            //              " UCML_OrganizeOID, " +        //用户组织ID
            //              " ocs_customer_FK)" +          //用户注册ID
            //        " VALUES ('" + contact_guid + "'," +
            //              "" + j + ",'" + TextName.Text + "',0,'" + tt + "'," +
            //              " '{0002281F-0000-0000-0000-00003952BBD6}', " +    //admin@keylab登录
            //              " '{000B9D90-0000-0000-0000-0000D8421017}', " +    //外部客户权限管理
            //              " '{000EE237-0000-0000-0000-0000B4725282}', " +    //企事业用户
            //              " '{000EE237-0000-0000-0000-0000B4725282}', '" + tt + "', " + //企事业用户
            //              " '{0002281F-0000-0000-0000-00003952BBD6}', 1, " +  //admin@keylab更新
            //              " '" + login_guid + "', " +     //---------------需创建----登录guid-----------
            //              " '{000EE237-0000-0000-0000-0000B4725282}', " +     //企事业用户--部门
            //              " '{0004F9CC-0000-0000-0000-0000B4735C51}', " +     //外部客户业务--仅登录下订单功能
            //              " '{000EE237-0000-0000-0000-0000B4725282}', " +     //企事业用户
            //              " '" + customer_guid + "')";       //---------------需创建---------------
            ////用户皮肤
            //string sql_skin =
            //   " INSERT INTO UCML_PersonConfig" +
            //   "       (UCML_PersonConfigOID, ItemName, ItemValue, TypeKind, UCML_User_FK)" +
            //   " VALUES ('" + skin_guid + "','SkinPath', 'Skin/Office2007/','Skin','" + login_guid + "')";
            #endregion 

            return UpdateDataBase_transaction_1(sql_reg);
        }


        protected void ButtonCancel_Click1(object sender, EventArgs e)
        {

        }
    }
}