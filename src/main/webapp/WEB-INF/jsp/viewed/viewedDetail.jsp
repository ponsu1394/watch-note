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

    <h2>作品詳細</h2>
    <div class="detail-box">
    	<p><strong>更新日:</strong> <%= work.getUpdatedAt().format(formatter) %></p>
        <p><strong>タイトル:</strong> <%= work.getTitle() %></p>
        <p><strong>評価:</strong> <%= work.getStarLabel() %></p>
        <p><strong>ジャンル:</strong> <%= work.getGenres() != null ? String.join(", ", work.getGenres()) : "ジャンルなし" %></p>
        <p><strong>レビュー:</strong> <%= work.getReview() %></p>
    </div>
	
	<div>
		<ul>
			<li><a class="btn" href="${pageContext.request.contextPath}/ViewedListServlet">戻る</a></li>
			<li><a class="btn" href="${pageContext.request.contextPath}/ViewedEditServlet?id=${work.id}">編集</a></li>	
		</ul>
		
		
	</div>
	
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>