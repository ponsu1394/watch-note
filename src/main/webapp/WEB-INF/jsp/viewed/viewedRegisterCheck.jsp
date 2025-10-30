<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Genre, model.Star" %>

<%
    String title = (String) request.getAttribute("title");
    String review = (String) request.getAttribute("review");
    Star star = (Star) request.getAttribute("star");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 登録内容確認</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <% request.setAttribute("pageName", "viewed"); %>
    <jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>この内容でよろしいですか？</h2>
    <div class="work-link">
        <p><strong>〇タイトル</strong><br><%= title %></p><br>
        <p><strong>〇ジャンル</strong><br>
        <% for (int i = 0; i < genres.size(); i++) {
		    out.print(genres.get(i).getName());
		    if (i < genres.size() - 1) {
		        out.print(" / ");
		    }
		} %>
        </p><br>
        <p><strong>〇5段階評価</strong><br><%= star.getLabel() %></p><br>
        <p><strong>〇レビュー</strong><br><%= review %></p>
    </div>

    <div class="btn-group">
     <form action="${pageContext.request.contextPath}/ViewedRegisterCheckServlet" method="post">
	    <input type="hidden" name="step" value="修正">
	    <input type="hidden" name="title" value="<%= title %>">
	    <input type="hidden" name="starId" value="<%= star.getId() %>">
	    <input type="hidden" name="review" value="<%= review %>">
	    <% for (Genre genre : genres) { %>
	        <input type="hidden" name="genreIds" value="<%= genre.getId() %>">
	    <% } %>
	    <input type="submit" value="戻る" class="btn">
	</form>

        <form action="${pageContext.request.contextPath}/ViewedRegisterServlet" method="post">
            <input type="hidden" name="title" value="<%= title %>">
            <input type="hidden" name="starId" value="<%= star.getId() %>">
            <input type="hidden" name="review" value="<%= review %>">
            <% for (Genre genre : genres) { %>
                <input type="hidden" name="genreIds" value="<%= genre.getId() %>">
                
            <% } %>
            <input type="submit" value="登録" class="btn">
        </form>
    </div>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>