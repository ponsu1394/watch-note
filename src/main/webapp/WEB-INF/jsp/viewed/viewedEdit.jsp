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
    <% request.setAttribute("pageName", "viewed"); %>
    <jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>作品の編集</h2>
    <div class="work-link">
        <!-- 入力フォーム -->
        <form id="editForm">
            <label>〇タイトル</label><br>
            <div class="input-wrapper">
                <input type="text" id="titleInput" name="title" value="<%= work.getTitle() %>" class="input-large" required>
            </div><br>

            <label>〇ジャンル（複数選択可）</label><br>
            <% for (Genre genre : genres) {
                boolean checked = selectedGenreIds.contains(genre.getId());
            %>
                <label>
                    <input type="checkbox" name="genreIds" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
                    <%= genre.getName() %>
                </label>
            <% } %>
            <br><br>

            <label>〇5段階評価</label>
            <select id="starIdInput" name="starId">
                <% for (Star star : stars) {
                    boolean selected = star.getId() == work.getStarId();
                %>
                    <option value="<%= star.getId() %>" <%= selected ? "selected" : "" %>><%= star.getLabel() %></option>
                <% } %>
            </select><br><br>

            <label>〇感想</label><br>
            <div class="input-wrapper">
                <textarea id="reviewInput" name="review" class="textarea-large" required><%= work.getReview() %></textarea>
            </div><br>
        </form>

        <!-- 削除ボタン -->
        <div class="btn-group">
            <form action="${pageContext.request.contextPath}/ViewedDeleteCheckServlet" method="post">
                <input type="hidden" name="id" value="<%= work.getId() %>">
                <input type="submit" value="削除" class="btn">
            </form>
        </div>
    </div>

    <!-- 戻る・確認ボタン -->
    <div class="btn-group">
        <form action="${pageContext.request.contextPath}/ViewedDetailServlet" method="get">
            <input type="hidden" name="id" value="<%= work.getId() %>">
            <input type="submit" value="戻る" class="btn">
        </form>

        <!-- 確認ボタン用 hidden フォーム -->
        <form id="confirmForm" action="${pageContext.request.contextPath}/ViewedEditCheckServlet" method="post">
            <input type="hidden" name="step" value="confirm">
            <input type="hidden" name="id" value="<%= work.getId() %>">
            <input type="hidden" name="title">
            <input type="hidden" name="starId">
            <input type="hidden" name="review">
            <!-- genreIds は JavaScriptで追加 -->
            <input type="submit" value="確認" class="btn">
        </form>
    </div>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />

    <!-- JavaScriptで入力値をコピー -->
    <script>
    document.querySelector('#confirmForm').addEventListener('submit', function(e) {
        const title = document.querySelector('#titleInput').value;
        const starId = document.querySelector('#starIdInput').value;
        const review = document.querySelector('#reviewInput').value;
        const genreCheckboxes = document.querySelectorAll('input[name="genreIds"]:checked');

        this.querySelector('input[name="title"]').value = title;
        this.querySelector('input[name="starId"]').value = starId;
        this.querySelector('input[name="review"]').value = review;

        // 既存の genreIds hidden input を削除
        this.querySelectorAll('input[name="genreIds"]').forEach(el => el.remove());

        // 選択されたジャンルを hidden input として追加
        genreCheckboxes.forEach(cb => {
            const hidden = document.createElement('input');
            hidden.type = 'hidden';
            hidden.name = 'genreIds';
            hidden.value = cb.value;
            this.appendChild(hidden);
        });
    });
    </script>
</body>
</html>