<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.WishlistWork" %>
<%@ page import="java.util.*, java.util.ArrayList, model.Genre" %>
<%
    WishlistWork work = (WishlistWork) request.getAttribute("work");
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
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />    

    <h2>観たい作品の詳細</h2>
    <div class="detail-box">
        <p><strong>タイトル:</strong> <%= work.getTitle() %></p>
        <p><strong>ジャンル:</strong> <%= work.getGenres() != null && !work.getGenres().isEmpty() ? String.join(", ", work.getGenres()) : "ジャンルなし" %></p>
        <p><strong>メモ:</strong> <%= work.getMemo() != null ? work.getMemo() : "なし" %></p>
    </div>

    <div>
        <ul>
            <li><a class="btn" href="${pageContext.request.contextPath}/WishListServlet">戻る</a></li>
            <li><a class="btn" href="${pageContext.request.contextPath}/WishlistEditServlet?id=${work.id}">編集</a></li>
        </ul>
    </div>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>