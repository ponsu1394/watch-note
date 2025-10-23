<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Genre, model.Star" %>
<%
    String title = (String) request.getAttribute("title");
    String review = (String) request.getAttribute("review");
    int starId = (Integer) request.getAttribute("starId");
    int id = (Integer) request.getAttribute("id");
    String[] genreIds = (String[]) request.getAttribute("genreIds");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    Star star = (Star) request.getAttribute("star");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 編集内容の確認</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>編集内容の確認</h2>

    <p><strong>タイトル：</strong><%= title %></p>
    <p><strong>評価：</strong><%= star.getLabel() %></p>
    <p><strong>ジャンル：</strong>
        <%
            Set<Integer> selectedIds = new HashSet<>();
            if (genreIds != null) {
                for (String gid : genreIds) {
                    selectedIds.add(Integer.parseInt(gid));
                }
            }
            for (Genre genre : genres) {
                if (selectedIds.contains(genre.getId())) {
                    out.print(genre.getName() + " ");
                }
            }
        %>
    </p>
    <p><strong>感想：</strong><br><%= review %></p>

    <!-- 更新確定フォーム -->
    <form action="${pageContext.request.contextPath}/ViewedEditServlet" method="post">
        <input type="hidden" name="step" value="update">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <input type="hidden" name="starId" value="<%= starId %>">
        <input type="hidden" name="review" value="<%= review %>">
        <% if (genreIds != null) {
            for (String gid : genreIds) {
        %>
            <input type="hidden" name="genreIds" value="<%= gid %>">
        <% }} %>
        <input type="submit" value="登録" class="nav_btn">
    </form>

    <!-- 修正フォーム -->
    <form action="${pageContext.request.contextPath}/ViewedEditServlet" method="post">
        <input type="hidden" name="step" value="back">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <input type="hidden" name="starId" value="<%= starId %>">
        <input type="hidden" name="review" value="<%= review %>">
        <% if (genreIds != null) {
            for (String gid : genreIds) {
        %>
            <input type="hidden" name="genreIds" value="<%= gid %>">
        <% }} %>
        <input type="submit" value="戻る" class="nav_btn">
    </form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>