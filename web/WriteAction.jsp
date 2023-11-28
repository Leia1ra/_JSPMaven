<%--
  Created by IntelliJ IDEA.
  User: leia_ira
  Date: 8/20/23
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- VO객체 (JSP 자바빈즈 : https://opentutorials.org/module/3569/21296) --%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<%-- setter 메소드 호출 --%>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset = UTF-8>
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null){
            userID = (String) session.getAttribute("userID");
        }
        if(userID == null){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인 후에 글을 작성하실 수 있습니다.')");
            script.println("location.href = 'Login.jsp'");
            script.println("</script>");
        } else{
            if( bbs.getBbsTitle() == null|| bbs.getBbsContent() == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                BbsDAO bbsDAO = new BbsDAO();
                int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('글쓰기에 실패하였습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href = 'bbs.jsp'");
                    script.println("</script>");
                }
            }
        }
    %>
</body>
</html>