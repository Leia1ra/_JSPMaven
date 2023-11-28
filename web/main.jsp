<%--
  Created by IntelliJ IDEA.
  User: leia_ira
  Date: 8/19/23
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html" charset = UTF-8>
  <meta name="viewport" content="width = device-width" inital-scale="1">
  <link rel="stylesheet" href="css/bootstrap.css">
  <title>JSP 게시판 웹사이트</title>
</head>
<body>
  <% /*세션관리, 현재 세션값을 보유중이라면 userID 문자열에 대입시켜놓음*/
    String userID = null;
    if(session.getAttribute("userID") != null){
      userID = (String) session.getAttribute("userID");
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
        <li class="active"><a href="main.jsp">메인</a></li>
        <li><a href="bbs.jsp">게시판</a></li>
      </ul>
      <% /*세션을 보유중이지 않다면 : 로그인 혹은 회원가입을 권할 수 있도록 함*/
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
    <div class="jumbotron">
      <div class="container">
        <h1>게시판 만들기</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet eveniet explicabo facilis ipsa modi nemo non optio sunt ullam veritatis.</p>
        <p>
          <a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a>
        </p>
      </div>
    </div>
  </div>

  <div class="container">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>

      <div class="carousel-inner">
        <div class="item active">
          <img src="images/HTML.png" alt="HTML">
        </div>
        <div class="item">
          <img src="images/CSS.png" alt="CSS">
        </div>
        <div class="item">
          <img src="images/JS.png" alt="JavaScript">
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
      </a>
      <a class="right carousel-control" href="#myCarousel" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
      </a>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</body>
</html>





































