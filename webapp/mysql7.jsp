<%@ page language="java"
	import="java.io.*,java.sql.*,javax.sql.*,javax.naming.*,jodd.example.test.*"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	/** JDBC connect to Mysql **/
	try     
	{     
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String url="jdbc:mysql://192.168.190.68:3306/world?rewriteBatchedStatements=true";
		String user="bbs";
		String password="123456";
		Connection   conn=   DriverManager.getConnection(url,user,password);
		conn.setAutoCommit(false);

		int	stmt_type=1;
		long start_time = System.currentTimeMillis();			
		LogManager lmng = new LogManager("D:\\data7", true);  
		
		if (stmt_type==1)
		{ 
			String pbase_sql="select * from posts where postid>=26400115 and postid<29000000 and  deltag=0 "
					+ "order by postid limit ?,?";
				PreparedStatement  prepared_stmt=conn.prepareStatement(pbase_sql);				
				int batch=1000;
				for(int i=0;i<=4000;i++){
					
					prepared_stmt.setInt(1, i*batch);
					prepared_stmt.setInt(2, batch);				
					ResultSet rs=prepared_stmt.executeQuery();
					while(rs.next())
					{
						String content=rs.getString("content");
						String sa = java.net.URLEncoder.encode(content, "utf-8");						
						String sr=HttpRequest.sendPost("http://filter.chnedu.com/SensitiveServlet", "content="+sa);						
						if(sr.trim().equals("1")){		
							lmng.log(rs.getInt("postid")+"", true);
						}
					}									
					conn.commit();
					System.out.println("正在执行mysql7第"+i*batch+"条记录！");
					
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
						System.out.println("正在执行mysql7第"+i+"条记录！");
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