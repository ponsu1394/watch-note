<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Star, model.Genre, model.ViewedWork" %>
<%
    ViewedWork work = (ViewedWork) request.getAttribute("work");
    List<Star> stars = (List<Star>) request.getAttribute("stars");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    List<Integer> selectedGenreIds = (List<Integer>) request.getAttribute("genreIds");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 作品の編集</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>作品の編集</h2>
	<div class="work-link">
    <form action="${pageContext.request.contextPath}/ViewedEditCheckServlet" method="post">
        <input type="hidden" name="step" value="confirm">

        <label>〇タイトル</label><br>
        <div class="input-wrapper">
        	<input type="text" name="title" value="<%= work.getTitle() %>" class="input-large" required>
		</div><br>

        <label>〇ジャンル（複数選択可）</label><br>
        <%
            for (Genre genre : genres) {
                boolean checked = selectedGenreIds.contains(genre.getId());
        %>
            <label>
                <input type="checkbox" name="genreIds" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
                <%= genre.getName() %>
            </label>
        <%
            }
        %>
        <br><br>
        <label>〇5段階評価</label>
        <select name="starId">
        <%
            for (Star star : stars) {
                boolean selected = star.getId() == work.getStarId();
        %>
            <option value="<%= star.getId() %>" <%= selected ? "selected" : "" %>><%= star.getLabel() %></option>
        <%
            }
        %>
        </select><br><br>

        <label>〇感想</label><br>
        <div class="input-wrapper">
 			 <textarea name="review" class="textarea-large" required><%= work.getReview() %></textarea>
		</div><br>

        <input type="hidden" name="id" value="<%= work.getId() %>">
	</form>

		<div  class="btn-group">
	    <form action="${pageContext.request.contextPath}/ViewedDeleteCheckServlet" method="post">
	    	<input type="hidden" name="id" value="<%= work.getId() %>">
	    	<input type="submit" value="削除" class="btn">
		</form>
		</div>
	</div>
	<div  class="btn-group">
	
	<form action="${pageContext.request.contextPath}/ViewedDetailServlet" method="get">
        <input type="hidden" name="id" value="<%= work.getId() %>">
        <input type="submit" value="戻る" class="btn">
    </form>
	
	<form action="${pageContext.request.contextPath}/ViewedEditCheckServlet" method="post">
	    <input type="hidden" name="step" value="confirm">
	    <input type="hidden" name="id" value="<%= work.getId() %>">
	    <input type="hidden" name="title" value="<%= work.getTitle() %>">
	    <input type="hidden" name="starId" value="<%= work.getStarId() %>">
	    <input type="hidden" name="review" value="<%= work.getReview() %>">
	    <% for (Integer gid : selectedGenreIds) { %>
	        <input type="hidden" name="genreIds" value="<%= gid %>">
	    <% } %>
    	<input type="submit" value="確認" class="btn">
	</form>
	
	</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>