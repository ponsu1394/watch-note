<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Genre" %>
<%
    String title = (String) request.getAttribute("title");
    String memo = (String) request.getAttribute("memo");
    String idStr = (String) request.getAttribute("id");
    int id = Integer.parseInt(idStr);
    String[] genreIds = (String[]) request.getAttribute("genreIds");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
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
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
<
    <h2>編集内容の確認</h2>

    <p><strong>タイトル：</strong><%= title %></p>
    <p><strong>ジャンル：</strong>
<%
    if (genreIds != null && genres != null) {
        Set<String> selectedIds = new HashSet<>(Arrays.asList(genreIds));
        boolean hasGenre = false;
        for (Genre genre : genres) {
            if (selectedIds.contains(String.valueOf(genre.getId()))) {
                out.print(genre.getName() + " ");
                hasGenre = true;
            }
        }
        if (!hasGenre) {
            out.print("ジャンルなし");
        }
    } else {
        out.print("ジャンルなし");
    }
%>
	</p>
    <p><strong>メモ：</strong><br><%= memo != null ? memo.replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %></p>

    <!-- 更新確定フォーム -->
    <form action="${pageContext.request.contextPath}/WishlistEditServlet" method="post">
        <input type="hidden" name="step" value="update">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <input type="hidden" name="memo" value="<%= memo %>">
        <% if (genreIds != null) {
            for (String gid : genreIds) {
        %>
            <input type="hidden" name="genreIds" value="<%= gid %>">
        <% }} %>
        <input type="submit" value="登録" class="nav_btn">
    </form>

    <!-- 修正フォーム -->
    <form action="${pageContext.request.contextPath}/WishlistEditServlet" method="post">
        <input type="hidden" name="step" value="back">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="title" value="<%= title %>">
        <input type="hidden" name="memo" value="<%= memo %>">
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