<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Genre" %>

<%
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String[] genreIds = request.getParameterValues("genre");
    String memo = request.getParameter("memo");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    List<String> selectedList = genreIds != null ? Arrays.asList(genreIds) : Collections.emptyList();
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
	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>登録内容の確認</h2>

    <p><strong>タイトル:</strong> <%= title %></p>

    <p><strong>ジャンル:</strong><br>
    <% for (Genre genre : genres) {
           if (selectedList.contains(String.valueOf(genre.getId()))) { %>
        <%= genre.getName() %><br>
    <%   }
       } %>
    </p>

    <p><strong>メモ:</strong><br>
    <pre><%= memo != null ? memo.replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %></pre></p>

    <!-- 更新処理へ -->
    <form action="${pageContext.request.contextPath}/WishlistRegisterCheckServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <% for (String gid : selectedList) { %>
            <input type="hidden" name="genre" value="<%= gid %>">
        <% } %>
        <input type="hidden" name="memo" value="<%= memo %>">
        <input type="submit" value="更新する" class="nav_btn">
    </form>

    <!-- 修正に戻る -->
    <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post">
        <input type="hidden" name="step" value="修正">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <% for (String gid : selectedList) { %>
            <input type="hidden" name="genre" value="<%= gid %>">
        <% } %>
        <input type="hidden" name="memo" value="<%= memo %>">
        <input type="submit" value="修正する" class="nav_btn">
    </form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>