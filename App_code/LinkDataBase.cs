using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using julia.web;

namespace julia.web
{
	/// <summary>
	/// LinkDataBase 的摘要说明。
	/// </summary>
	public class LinkDataBase
	{
		public static string strSQL;
		//		private string strSQL2;
		//与SQL Server的连接字符串设置

//      private string autoconnect =  "Auto Translate=True;Integrated Security=SSPI;User ID=sa;Data Source=localhost;Tag with column collation when possible=False;Initial Catalog=STEST;Use Procedure for Prepare=1;Provider="SQLOLEDB.1";Persist Security Info=False;Workstation ID=PEKING;Use Encryption for Data=False;Packet Size=4096"
//		public string connectionString = "Server=localhost;database=stest;User Id = sa; Password='sa'";
        public string connectionString = "Server=127.0.0.1;database=juliadb;User Id = sa; Password= 'sa'";
        //public string connectionString = frm_login.strConn;
		//与数据库的连接
		private SqlConnection myConnection;
		private SqlCommand myCommand;
		private SqlCommandBuilder sqlCmdBld;
		private DataSet ds = new DataSet();
		private SqlDataAdapter da;
		
		public LinkDataBase()
		{
			//
			// TODO: 在此处添加构造函数逻辑
			//
            //da.UpdateCommand.CommandTimeout = 300;
            //da.SelectCommand.CommandTimeout = 300;
            //da.UpdateBatchSize = 0;
            
            
		}

		//____________________________________________________________________________________________________
		
		//查找单值记录
		public long MaxColumnValue(string tempStrSQL)
		{
			//			strSQL = tempStrSQL;
			this.myConnection = new SqlConnection(connectionString);
			this.myConnection.Open();
			long intNum;
			this.myCommand = new SqlCommand(tempStrSQL,this.myConnection);
			if (this.myCommand.ExecuteScalar() == DBNull.Value)
			{
				intNum = 0;
			}
			else
			{
				intNum = System.Convert.ToInt32(this.myCommand.ExecuteScalar());
			}
			//			Double to int conversion can overflow.
			//          intVal = System.Convert.ToInt32(doubleVal);
			myConnection.Close();
			return intNum;
		}
		public long ColumnValue(string tempStrSQL)
		{
			this.myConnection = new SqlConnection(connectionString);
			this.myConnection.Open();
			long intNum;
			this.myCommand = new SqlCommand(tempStrSQL,this.myConnection);
			intNum = System.Convert.ToInt32(this.myCommand.ExecuteScalar());
			myConnection.Close();
			return intNum;
		}
		
		
		//根据输入的SQL语句检索数据库数据
		public DataSet SelectDataBase(string tempStrSQL,string tempTableName)
		{ 
			strSQL = tempStrSQL;
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(strSQL,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.ds.Clear();
			this.da.Fill(ds,tempTableName);
			return ds;//返回填充了数据的DataSet，其中数据表以tempTableName给出的字符串命名
		}

		//数据库数据更新(传DataSet和DataTable的对象)
		public DataSet UpdateDataBase(DataSet changedDataSet,string tableName)
		{
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(strSQL,this.myConnection);
            da.UpdateCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.sqlCmdBld = new SqlCommandBuilder(da);
			this.da.Update(changedDataSet,tableName);
			return changedDataSet;//返回更新了的数据库表
		}
		/////////////////////////////////  直接操作数据库(未创建该类的实例时直接用)  /////////////////////////////////////////////////////

		//检索数据库数据(传字符串,直接操作数据库)
		public DataTable SelectDataBase(string tempStrSQL)
		            {
			this.myConnection = new SqlConnection(connectionString);
			DataSet tempDataSet = new DataSet();
			this.da = new SqlDataAdapter(tempStrSQL,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.da.Fill(tempDataSet);
			return tempDataSet.Tables[0];
		}

		//数据库数据更新(传字符串，直接操作数据库)
		public int UpdateDataBase(string tempStrSQL)
		{
			this.myConnection = new SqlConnection(connectionString);
			//使用Command之前一定要先打开连接,后关闭连接,而DataAdapter则会自动打开关闭连接
			myConnection.Open();
			SqlCommand tempSqlCommand = new SqlCommand(tempStrSQL,this.myConnection);
			int intNumber = tempSqlCommand.ExecuteNonQuery();//返回数据库中影响的行数
			myConnection.Close();
			return intNumber;
		}
//===============================================operator  define==========================================
//===================add_peking=========================
		public DataSet SelectDataBase_Unclear(string tempStrSQL,string tempTableName)
		{ 
			strSQL = tempStrSQL;
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(strSQL,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
//			this.ds.Clear();
			this.da.Fill(ds,tempTableName);
			return ds;//返回填充了数据的DataSet，其中数据表以tempTableName给出的字符串命名
		}
		//数据库数据更新(传DataTable和DataTable的对象)
		public DataTable UpdateDataBase(DataTable changedDataTable)
		{
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(strSQL,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.sqlCmdBld = new SqlCommandBuilder(da);
			this.da.Update(changedDataTable);
			return changedDataTable;//返回更新了的数据库表
         }
	
		//根据输入的SQL语句检索数据库数据(重载)
		public DataSet SelectDataBase(string tempStrSQL,string tempTableName,string[] parameter,string[] paravalue)
		{ 
			
//			SqlCommand cmd;
//			strSQL = tempStrSQL;
//			this.da = new SqlDataAdapter();			
//			this.myConnection = new SqlConnection(connectionString);
//			cmd = new SqlCommand(strSQL, myConnection);
//			for (int i=0;i<parameter.Length;i++)
//			{
//				cmd.Parameters.Add(parameter[i], SqlDbType.NVarChar, 15);
//			}
//			this.da.SelectCommand = cmd;
//			this.da.SelectCommand.Parameters[0].Value = paravalue[0].ToString(); 
//			this.ds.Clear();
//			this.da.Fill(ds,tempTableName);
			return ds;//返回填充了数据的DataSet，其中数据表以tempTableName给出的字符串命名
		}
//=============================================add_hmj=========================================================
		//		----------------------shi------------------------------------
		//数据库数据更新(传DataSet、DataTable、sql的对象)
		public DataSet UpdateDataBase(DataSet changedDataSet,string tableName,string sql)
		{
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(sql,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.sqlCmdBld = new SqlCommandBuilder(da);
			this.da.Update(changedDataSet,tableName);
			return changedDataSet;//返回更新了的数据库表
		}
		
		public DataTable UpdateDataBase(DataTable table,string str)
		{
			
			this.myConnection = new SqlConnection(connectionString);
			this.da = new SqlDataAdapter(str,this.myConnection);
            da.SelectCommand.CommandTimeout = 300;
            da.UpdateBatchSize = 0;
			this.sqlCmdBld = new SqlCommandBuilder(da);
			this.da.Update(table);
			return table;//返回更新了的数据库表		
		}
		//=========================add mj====2007-01-15============================
		public int IsExist(string tempStrSQL)
		{
			strSQL = tempStrSQL;
			int isExist;
			this.myConnection = new SqlConnection(connectionString);
			this.myConnection.Open();
			this.myCommand = new SqlCommand(strSQL,this.myConnection);
			if(System.Convert.ToInt32(this.myCommand.ExecuteScalar()) == 0)
				isExist = 0;
			else
				isExist =1 ;
			this.myConnection.Close();
			return isExist;
		}

		public string SelectString(string tempStrSQL)
		{
			strSQL = tempStrSQL;
			string ResultString;
			this.myConnection = new SqlConnection(connectionString);
			this.myConnection.Open();
			this.myCommand = new SqlCommand(strSQL,this.myConnection);
			ResultString = System.Convert.ToString(this.myCommand.ExecuteScalar());
			this.myConnection.Close();
			return ResultString;
		}
	}
}
