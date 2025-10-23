<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ViewedWork" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    ViewedWork work = (ViewedWork) request.getAttribute("work");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote <%= work.getTitle() %> - 詳細</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />    

    	<p class="updated-date"><strong>更新日:</strong> <%= work.getUpdatedAt().format(formatter) %></p>
    <div class="work-link">
        <p>【 <%= work.getTitle() %>】</p>
        <p> <%= work.getGenres() != null ? String.join(", ", work.getGenres()) : "ジャンルなし" %></p><br>
        <p>〇おすすめ度</p>
         <div class="label"><%= work.getStarLabel() %></div>
       
        <p>〇感想</p> <p><%= work.getReview() %></p>
    </div>
	
	<div>
  <ul class="btn-group">
    <li><a class="btn" href="${pageContext.request.contextPath}/ViewedListServlet">戻る</a></li>
    <li><a class="btn" href="${pageContext.request.contextPath}/ViewedEditServlet?id=${work.id}">編集</a></li>
  </ul>
</div>
	
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>