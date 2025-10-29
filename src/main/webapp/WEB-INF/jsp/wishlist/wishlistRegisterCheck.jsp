<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Genre" %>

<%
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String[] genreIds = request.getParameterValues("genre");
    String memo = request.getParameter("memo");

    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    if (genres == null) {
        genres = new ArrayList<>();
    }

    List<String> selectedList = genreIds != null ? Arrays.asList(genreIds) : Collections.emptyList();
    List<String> selectedGenreNames = new ArrayList<>();
    for (Genre genre : genres) {
        if (selectedList.contains(String.valueOf(genre.getId()))) {
            selectedGenreNames.add(genre.getName());
        }
    }
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
    <% request.setAttribute("pageName", "wish"); %>
    <jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>この内容でよろしいですか？</h2>
    <div class="work-link">
        <p><strong>〇タイトル</strong><br><%= title %></p><br>
        <p><strong>〇ジャンル</strong><br><%= String.join(" / ", selectedGenreNames) %></p><br>
        <p><strong>〇あらすじ・メモ</strong><br><pre><%= memo != null ? memo.replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %></pre></p>
    </div>

    <div class="btn-group">
        <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post">
            <input type="hidden" name="step" value="修正">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="title" value="<%= title %>">
            <input type="hidden" name="memo" value="<%= memo %>">
            <% for (String gid : selectedList) { %>
                <input type="hidden" name="genre" value="<%= gid %>">
            <% } %>
            <input type="submit" value="戻る" class="btn">
        </form>

        <form action="${pageContext.request.contextPath}/WishlistRegisterCheckServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="title" value="<%= title %>">
            <input type="hidden" name="memo" value="<%= memo %>">
            <% for (String gid : selectedList) { %>
                <input type="hidden" name="genre" value="<%= gid %>">
            <% } %>
            <input type="submit" value="登録" class="btn">
        </form>
    </div>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>