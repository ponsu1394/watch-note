<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.WishlistWork" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 観たい作品一覧</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- ヘッダーをインクルード -->
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />

	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	

    <%
        List<WishlistWork> wishlist = (List<WishlistWork>) request.getAttribute("wishlist");
        if (wishlist == null || wishlist.isEmpty()) {
    %>
        <p>観たい作品が登録されていません。</p>
    <%
        } else {
    %>
        <ul>
        <%
            for (WishlistWork work : wishlist) {
        %>
            <li>
                <a href="${pageContext.request.contextPath}/WishlistDetailServlet?id=<%= work.getId() %>" class="link">
                    <div class="title">【<%= work.getTitle() %>】</div>
					<div class="genres">
					    <% if (work.getGenres() != null && !work.getGenres().isEmpty()) {
					        for (String genre : work.getGenres()) { %>
					            <span><%= genre %></span>
					    <%  }
					       } else { %>
					        ジャンルなし
					    <% } %>
					</div>       
                </a>
            </li>
        <%
            }
        %>
        </ul>
        <div class="centered">
        	<a class="btn" href="WishlistRegisterServlet">新しい作品を登録</a>
        </div>
    <%
        }
    %>

    <!-- フッターをインクルード -->
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />

</body>
</html>