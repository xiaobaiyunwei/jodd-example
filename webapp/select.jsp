<%@ page language="java"
	import="java.io.*,java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	/** JDBC connect to Mysql **/
	try     
	{     
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String url="jdbc:mysql://192.168.192.217:3306/test?rewriteBatchedStatements=true";
		String user="root";
		String password="cdel9999";
		Connection   conn=   DriverManager.getConnection(url,user,password);
		conn.setAutoCommit(false);
		int id=0;
		id=Integer.valueOf(request.getParameter("id"));
		ResultSet rs = null;
		int	stmt_type=1;
		long start_time = System.currentTimeMillis();		
		if (stmt_type==1)
		{ 
				String pbase_sql="select * from company where id >?";
				PreparedStatement  prepared_stmt=conn.prepareStatement(pbase_sql);
				prepared_stmt.setInt(1, id);
				out.print("sql===:"+prepared_stmt.toString()+"</br>");
				rs=prepared_stmt.executeQuery();
				int rcount=0;			
			
				while(rs.next()){			 
					int rid = rs.getInt("id");
					String name = rs.getString("name");
					out.println("序号："+rid+" 名字："+name+"</br>");
					if(rs.isLast()){
						rcount=rs.getRow();	
						out.println("总条数=====:"+rcount+"</br>"); 
					}
				}
				
				prepared_stmt.close();
		}else if(stmt_type==2){
				Statement   stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String base_sql="insert into IVR_MENU_INFO (IVR_MENU_ID,CALLER_NUMBER,CALLED_NUMBER,SSP_ID,IVR_MENU_TYPE_CODE,CHANGE_CHOICE) values (";
				String str[]={",'good'",",'great'",",'wonderful'",",'awesome'",",'fantastic'",",'beautiful'",",'perfect'",",'terrific'"};
				for(int i=1;i<=5000000;i++){
					String insert_sql="";
					int index =(int)(Math.random()*str.length);
					insert_sql=base_sql+i+",'10'"+",'8',"+i+str[index]+",'1')";			
					stmt.addBatch(insert_sql);
					if(i%1000==0){
						stmt.executeBatch();
						conn.commit();
						System.out.println("正在执行第"+i+"条记录！");
					}
				}		
				stmt.close();
		}		
		System.out.println("开始时间："+start_time);
		System.out.println("结束时间："+System.currentTimeMillis());		
		conn.close();
	}     
	catch(Exception e)
	{
		out.println(e);
	}

	%>
</body>
</html>