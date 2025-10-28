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
    <div class="work-link">
    <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post">
    	<input type="hidden" name="step" value="確認">
    	
    <label>〇タイトル</label><br>
    <div class="input-wrapper">
    	<input type="text" name="title" value="<%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %>" required><br><br>
	</div>
    <label>〇ジャンル（複数選択可）</label><br>
	<%
	    String[] selectedGenreIds = (String[]) request.getAttribute("genreIds");
	    List<String> selectedList = selectedGenreIds != null ? Arrays.asList(selectedGenreIds) : Collections.emptyList();
	    for (Genre genre : genres) {
	        boolean checked = selectedList.contains(String.valueOf(genre.getId()));
	%>
	    <label>
	        <input type="checkbox" name="genre" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
	        <%= genre.getName() %>
	    </label>
	<%
	    }
	%><br>


    <br><label>〇あらすじ・メモ</label><br>
	<div class="input-wrapper">
    <textarea name="memo"><%= request.getAttribute("memo") != null ? request.getAttribute("memo") : "" %></textarea><br>
	</div>
	</div>
	<div class="btn-group">
    <!-- 戻るボタンを先に表示 -->
    <form action="${pageContext.request.contextPath}/WishListServlet" method="get" style="display:inline;">
        <input type="submit" value="戻る" class="btn">
    </form>

    <!-- 確認ボタンを後に表示 -->
    <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post" style="display:inline;">
        <input type="hidden" name="step" value="確認">
        <input type="hidden" name="title" value="<%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %>">
        <input type="hidden" name="memo" value="<%= request.getAttribute("memo") != null ? request.getAttribute("memo") : "" %>">
        <% 
            if (selectedGenreIds != null) {
                for (String gid : selectedGenreIds) {
        %>
            <input type="hidden" name="genreIds" value="<%= gid %>">
        <% 
                }
            }
        %>
        <input type="submit" value="確認" class="btn">
    </form>
</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>