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
    <div class="work-link">
        <p><span>【<%= work.getTitle() %>】</span></p>
		<p>
		    <div class="genres">
		        <% if (work.getGenres() != null && !work.getGenres().isEmpty()) {
		            for (String genre : work.getGenres()) { %>
		                <span><%= genre %></span>
		        <%  }
		           } else { %>
		            ジャンルなし
		        <% } %>
		    </div>
		</p><br>
        <p><strong>〇あらすじ・メモ</strong><br> <%= work.getMemo() != null ? work.getMemo() : "なし" %></p><br>
    </div>

    <div class="btn-group">
        <ul>
            <li><a class="btn" href="${pageContext.request.contextPath}/WishListServlet">戻る</a></li>
            <li><a class="btn" href="${pageContext.request.contextPath}/WishlistEditServlet?id=${work.id}">編集</a></li>
        </ul>
    </div>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>