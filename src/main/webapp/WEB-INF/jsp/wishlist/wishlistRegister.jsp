<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Genre" %>

<%
    String id = (String) request.getAttribute("id");
    String title = (String) request.getAttribute("title");
    String[] genreIds = (String[]) request.getAttribute("genreIds");
    String memo = (String) request.getAttribute("memo");

    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    if (genres == null) {
        genres = new ArrayList<>();
    }

    List<String> selectedList = genreIds != null ? Arrays.asList(genreIds) : Collections.emptyList();
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
    <% request.setAttribute("pageName", "wish"); %>
    <jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>観たい作品を登録</h2>
    <div class="work-link">
    <form action="${pageContext.request.contextPath}/WishlistRegisterServlet" method="post">
        <label>〇タイトル</label><br>
        <input type="text" name="title" value="<%= title != null ? title : "" %>" required class="input-large"><br><br>


        <label>〇ジャンル（複数選択可）</label><br>
        <% for (Genre genre : genres) {
            boolean checked = selectedList.contains(String.valueOf(genre.getId()));
        %>
            <label>
                <input type="checkbox" name="genre" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
                <%= genre.getName() %>
            </label>
        <% } %><br><br>

        <label>〇あらすじ・メモ</label><br>
        <textarea name="memo" class="textarea-large"><%= memo != null ? memo : "" %></textarea><br><br>


        <input type="hidden" name="id" value="<%= id != null ? id : "" %>">
	</div>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/WishListServlet" class="btn">戻る</a>
            <input type="submit" name="step" value="確認" class="btn">
        </div>
    </form>
    

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>