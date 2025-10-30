<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.ViewedWork" %>
<%@ page import="java.time.format.DateTimeFormatter" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- リンク -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>WatchNote 観た作品一覧</title>
    
</head>
<body>
	
	<!-- ヘッダーをインクルード -->
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
    
    
    <%
        List<ViewedWork> works = (List<ViewedWork>) request.getAttribute("works");
        if (works == null || works.isEmpty()) {
    %>
        <p>表示する作品がありません。</p>
    <%
        } else {
    %>
        <ul>
        <%
            for (ViewedWork work : works) {
        %>
            <li  class="link">
            	<a href="${pageContext.request.contextPath}/ViewedDetailServlet?id=<%= work.getId() %>">
                <div class="title">【<%= work.getTitle() %>】</div>
                <div class="info-row">
					 <div class="label"><%= work.getStarLabel() %></div>
					 <div class="genres">
						    <% if (work.getGenres() != null && !work.getGenres().isEmpty()) {
						        for (String genre : work.getGenres()) { %>
						            <span><%= genre %></span>
						    <%  }
						       } else { %>
						        ジャンルなし
						    <% } %>
					</div>
				</div>

                </a>
            </li>
        <%
            }
        %>
        </ul>
        <div class="centered">
  			<a class="nav_btn" href="ViewedRegisterServlet">新しい作品を登録</a>
		</div>
    <%
        }
    %>
    
    <!-- フッターをインクルード -->
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>