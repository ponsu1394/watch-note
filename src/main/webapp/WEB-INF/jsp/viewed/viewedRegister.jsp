<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Genre, model.Star" %>
<%
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    List<Star> stars = (List<Star>) request.getAttribute("stars");
    String[] selectedGenreIds = (String[]) request.getAttribute("genreIds");
    String title = request.getAttribute("title") != null ? (String) request.getAttribute("title") : "";
    String review = request.getAttribute("review") != null ? (String) request.getAttribute("review") : "";
    String starIdStr = request.getAttribute("starId") != null ? request.getAttribute("starId").toString() : "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 観た作品登録フォーム</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <% request.setAttribute("pageName", "viewed"); %>
    <jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>観た作品を登録</h2>
    <div class="work-link">
    <form action="${pageContext.request.contextPath}/ViewedRegisterCheckServlet" method="post">
        <input type="hidden" name="step" value="確認">

        <label for="title">〇タイトル</label><br>
        <div class="input-wrapper">
            <input type="text" id="title" name="title" class="input-large" required value="<%= title %>">
        </div><br>

        <label>〇ジャンル（複数選択可）</label><br>
        <% for (Genre genre : genres) {
            boolean checked = false;
            if (selectedGenreIds != null) {
                for (String gid : selectedGenreIds) {
                    if (gid.equals(String.valueOf(genre.getId()))) {
                        checked = true;
                        break;
                    }
                }
            }
        %>
            <label>
                <input type="checkbox" name="genreIds" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
                <%= genre.getName() %>
            </label>
        <% } %>
        <br><br>

        <label for="starId">〇5段階評価</label>
        <select id="starId" name="starId" required>
            <% for (Star star : stars) {
                String selected = starIdStr.equals(String.valueOf(star.getId())) ? "selected" : "";
            %>
                <option value="<%= star.getId() %>" <%= selected %>><%= star.getLabel() %></option>
            <% } %>
        </select>

        <div><br>
            <label for="review">〇感想</label><br>
            <div class="input-wrapper">
                <textarea id="review" name="review" class="textarea-large" required><%= review %></textarea>
            </div>
        </div>
    </div>
    <div class="btn-group">
    	<a href="${pageContext.request.contextPath}/ViewedListServlet" class="btn">戻る</a>
        <input type="submit" value="確認" class="btn">        
    </div>
    </form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>