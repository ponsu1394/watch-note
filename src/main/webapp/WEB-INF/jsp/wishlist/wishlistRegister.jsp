<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Collections" %>
<%@ page import="model.Genre" %>

<%
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 観たい作品登録フォーム</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />

	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>観たい作品を登録</h2>
    <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post">
    	<input type="hidden" name="step" value="確認">
    	
    <label>タイトル:</label><br>
    <input type="text" name="title" value="<%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %>" required><br><br>

    <label>ジャンル（複数選択可）:</label><br>
	<%
	    String[] selectedGenreIds = (String[]) request.getAttribute("genreIds");
	    List<String> selectedList = selectedGenreIds != null ? Arrays.asList(selectedGenreIds) : Collections.emptyList();
	    for (Genre genre : genres) {
	        boolean checked = selectedList.contains(String.valueOf(genre.getId()));
	%>
	    <label>
	        <input type="checkbox" name="genre" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
	        <%= genre.getName() %>
	    </label><br>
	<%
	    }
	%>


    <label>メモ:</label><br>
    <textarea name="memo" rows="6" cols="50"><%= request.getAttribute("memo") != null ? request.getAttribute("memo") : "" %></textarea><br>

    <input type="submit" value="確認" class="nav_btn">
</form>
    <br>
    <form action="${pageContext.request.contextPath}/WishListServlet" method="get">
        <input type="submit" value="戻る" class="nav_btn">
    </form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>