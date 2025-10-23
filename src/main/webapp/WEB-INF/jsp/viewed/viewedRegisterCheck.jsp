<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Genre, model.Star" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 登録確認</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>登録内容の確認</h2>

    <p><strong>タイトル：</strong> ${title}</p>
    <p><strong>評価：</strong> ${star.label}</p>
    <p><strong>ジャンル：</strong>
    <%
        List<Genre> genres = (List<Genre>) request.getAttribute("genres");
        for (Genre genre : genres) {
            out.print(genre.getName() + " ");
        }
    %>
    </p>
    <p><strong>レビュー：</strong><br>${review}</p>

    <form action="ViewedRegisterServlet" method="post">
        <input type="hidden" name="title" value="${title}">
        <input type="hidden" name="starId" value="${star.id}">
        <input type="hidden" name="review" value="${review}">
    <%
        for (Genre genre : genres) {
    %>
        <input type="hidden" name="genreIds" value="<%= genre.getId() %>">
    <%
        }
    %>
        <input type="submit" value="登録">
    </form>

    <form action="${pageContext.request.contextPath}/ViewedRegisterServlet" method="post">
    	<input type="hidden" name="step" value="修正">
	    <input type="hidden" name="title" value="${title}">
		<input type="hidden" name="starId" value="${star.id}">
		<input type="hidden" name="review" value="${review}">
<%
    for (Genre genre : genres) {
%>
   		<input type="hidden" name="genreIds" value="<%= genre.getId() %>">
<%
    }
%>
    	<input type="submit" value="戻る">
	</form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>