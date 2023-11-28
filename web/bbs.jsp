<%--
  Created by IntelliJ IDEA.
  User: leia_ira
  Date: 8/19/23
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html" charset = UTF-8>
  <meta name="viewport" content="width = device-width" inital-scale="1">
  <link rel="stylesheet" href="css/bootstrap.css">
  <title>JSP 게시판 웹사이트</title>
  <style type="text/css">
    a, a:hover{
      color: black;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <%
    /* 현재 세션을 확인*/
    String userID = null;
    if(session.getAttribute("userID") != null){
      userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if(request.getParameter("pageNumber") != null){
      pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
  %>
  <nav class="navbar navbar-default">
    <div class="navbar-header">
      <button
              type="button" class="navbar-toggle collapsed"
              data-toggle="collapse" data-targe="#bs-example-navbar-collapse-1"
              aria-expanded="false">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="main.jsp">메인</a></li>
        <li class="active"><a href="bbs.jsp">게시판</a></li>
      </ul>
      <%
        if(userID == null){
      %>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
            <a href="#"
               class="dropdown-toggle"
               data-toggle="dropdown"
               role="button"
               aria-haspopup="true"
               aria-expanded="false">
              접속하기 <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="Login.jsp">로그인</a></li>
              <li><a href="Join.jsp">회원가입</a></li>
            </ul>
          </li>
        </ul>
      <%
        } else {
      %>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
            <a href="#"
               class="dropdown-toggle"
               data-toggle="dropdown"
               role="button"
               aria-haspopup="true"
               aria-expanded="false">
              회원관리 <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="LogoutAction.jsp">로그아웃</a></li>
            </ul>
          </li>
        </ul>
      <%
        }
      %>
    </div>
  </nav>

  <div class="container">
    <div class="row">
      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
        <thead>
        <tr>
          <th style="background-color: #eeeeee; text-align: center;">번호</th>
          <th style="background-color: #eeeeee; text-align: center;">제목</th>
          <th style="background-color: #eeeeee; text-align: center;">작성자</th>
          <th style="background-color: #eeeeee; text-align: center;">작성일</th>
        </tr>
        </thead>
        <tbody>
        <%
          BbsDAO bbsDAO = new BbsDAO();
          ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
          for(int i = 0; i< list.size(); i++){
        %>
        <tr>
          <td><%= list.get(i).getBbsID()%></td>
          <td>
            <a href="View.jsp?bbsID=<%= list.get(i).getBbsID() %>">
              <%= list.get(i).getBbsTitle() /*특수문자 처리 + 크로스 사이트 스크립팅 XSS해킹 방어책*/
                      .replaceAll(" ","&nbsp;")
                      .replaceAll("<", "&lt;")
                      .replaceAll(">", "&gt")
                      .replaceAll("\n","<br>")
              %>
            </a>
          </td>
          <td><%= list.get(i).getUserID()%></td>
          <td>
            <%=
              list.get(i).getBbsDate().substring(0,11) +
              list.get(i).getBbsDate().substring(11,13) + "시 " +
              list.get(i).getBbsDate().substring(14,16) + "분"
            %>
          </td>
        </tr>
        <%
          }
        %>
        </tbody>

      </table>
      <% /*1페이지가 아니라면 이전탭 활성화*/
        if(pageNumber != 1){
      %>
      <a href="bbs.jsp?pageNumber=<%= pageNumber -1 %>" class="btn btn-success btn-arrow-Left">이전</a>
      <% /*BbsDAO.nextPage 메서드의 인자인 (지금페이지번호 + 1)인 다음페이지 인자값을 넘겨주고 확인함*/
        }if(bbsDAO.nextPage(pageNumber + 1)){
      %>
      <a href="bbs.jsp?pageNumber=<%= pageNumber +1 %>" class="btn btn-success btn-arrow-Right">다음</a>
      <%
        }
      %>
      <a href="Write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</body>
</html>
