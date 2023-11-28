package JDBC;

import java.io.PrintWriter;
import java.sql.*;

public class DBConnection {
    protected Connection con;
    protected PreparedStatement pstmt;
    protected ResultSet rs;

    private static final String URL = "jdbc:mysql://localhost/BBS";
    private static final String USER_NAME = "root";
    private static final String PASSWORD = "tiger1234";

    static{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이브 로딩 예외");
            e.printStackTrace();
        }
    }
    public DBConnection() {

    }

    //DB연결
    public void DBConnect(){
        try{
            con = DriverManager.getConnection(URL, USER_NAME, PASSWORD);

        } catch (SQLException e) {
            System.out.println("Connection Error : " + e.getMessage());
            e.printStackTrace();
        }
    }
    public void DBClose(){
        try{
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
        } catch (SQLException e) {
            System.out.println("닫기 에외 발생" + e.getMessage());
            e.printStackTrace();
        }
    }
}







































