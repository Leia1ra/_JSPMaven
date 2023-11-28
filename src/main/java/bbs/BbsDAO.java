package bbs;

import JDBC.DBConnection;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO extends DBConnection {
    public BbsDAO() {
        DBConnect();
    }
    public String getDate(){
        String SQL = "SELECT NOW()";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            rs = p.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류
    }

    public int getNext(){
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            rs = p.executeQuery();
            if(rs.next()){
                // System.out.println(rs.getInt(1)+1);
                return rs.getInt(1) + 1; // 마지막 bbsID + 1를 리턴
            }
            return 1; // 첫번째 게시물인 경우
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int write(String bbsTitle, String userID, String bbsContent){
        String SQL = "INSERT INTO BBS VALUES (?,?,?,?,?,?)";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            p.setInt(1, getNext());
            p.setString(2,bbsTitle);
            p.setString(3,userID);
            p.setString(4,getDate());
            p.setString(5,bbsContent);
            p.setInt(6,1);
            return p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    public ArrayList<Bbs> getList(int pageNumber){
        String SQL = "SELECT * FROM BBS " +
                "WHERE bbsID < ? AND bbsAvailable = 1 " +
                "ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            // getNext() : 다음에 작성될 글의 번호를 의미
            //
            p.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = p.executeQuery();
            while(rs.next()){
                Bbs bbs = new Bbs();
                bbs.setBbsID        (rs.getInt(1));
                bbs.setBbsTitle     (rs.getString(2));
                bbs.setUserID       (rs.getString(3));
                bbs.setBbsDate      (rs.getString(4));
                bbs.setBbsContent   (rs.getString(5));
                bbs.setBbsAvailable (rs.getInt(6));
                list.add(bbs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list; // 데이터베이스 오류
    }
    public boolean nextPage(int pageNumber){
        // 다음페이지 활성화를 위해 존재 여부 확인
        String SQL = "SELECT * FROM BBS " +
                "WHERE bbsID < ? AND bbsAvailable = 1 " +
                "ORDER BY bbsID DESC LIMIT 10";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            p.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = p.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 게시판
    public Bbs getBbs(int bbsID){
        String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            p.setInt(1, bbsID);
            rs = p.executeQuery();
            if(rs.next()){
                Bbs bbs = new Bbs();
                bbs.setBbsID        (rs.getInt(1));
                bbs.setBbsTitle     (rs.getString(2));
                bbs.setUserID       (rs.getString(3));
                bbs.setBbsDate      (rs.getString(4));
                bbs.setBbsContent   (rs.getString(5));
                bbs.setBbsAvailable (rs.getInt(6));
                return bbs;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public int update(int bbsID, String bbsTitle, String bbsContent){
        String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            p.setString(1,bbsTitle);
            p.setString(2,bbsContent);
            p.setInt(3,bbsID);
            return p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    public int delete(int bbsID){
        String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
        try{
            PreparedStatement p = con.prepareStatement(SQL);
            p.setInt(1, bbsID);
            return p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
}






















