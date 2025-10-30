<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Star, model.Genre, model.WishlistWork" %>
<%
    WishlistWork work = (WishlistWork) request.getAttribute("work");
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");

    Object genreIdsObj = request.getAttribute("genreIds");
    List<Integer> selectedGenreIds = new ArrayList<>();

    if (genreIdsObj instanceof List) {
        selectedGenreIds = (List<Integer>) genreIdsObj;
    } else if (genreIdsObj instanceof String[]) {
        for (String idStr : (String[]) genreIdsObj) {
            try {
                selectedGenreIds.add(Integer.parseInt(idStr));
            } catch (NumberFormatException e) {
                // 無効なIDはスキップ（必要ならログ出力）
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 編集</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />

    <h2>観たい作品を編集</h2>
<div class="work-link">
    <!-- 編集フォーム -->
<form action="${pageContext.request.contextPath}/WishlistEditCheckServlet" method="post">
    <input type="hidden" name="step" value="confirm">
    <input type="hidden" name="id" value="<%= work.getId() %>">

    <label>〇タイトル</label><br>
    <input type="text" name="title" value="<%= work.getTitle() %>" required class="input-large"><br><br>

    <label>〇ジャンル（複数選択可）</label><br>
    <% for (Genre genre : genres) {
        boolean checked = selectedGenreIds.contains(genre.getId()); %>
        <label>
            <input type="checkbox" name="genreIds" value="<%= genre.getId() %>" <%= checked ? "checked" : "" %>>
            <%= genre.getName() %>
        </label>
    <% } %>
    <br><br>

    <label>〇メモ</label><br>
    <textarea name="memo" class="textarea-large"><%= work.getMemo() != null ? work.getMemo() : "" %></textarea><br><br>

    <!-- ボタン配置 -->
    <div class="btn-group">
        <!-- 削除ボタン -->
        <button type="button" class="btn" onclick="document.getElementById('deleteForm').submit();">
            削除
        </button>
    </div>
	</div>
    <div class="btn-group">
        <!-- 戻るボタン -->
        <button type="button" class="btn" onclick="document.getElementById('backForm').submit();">
            戻る
        </button>

        <!-- 確認ボタン（submit） -->
        <input type="submit" value="確認" class="btn">
    </div>
</form>

		<!-- 削除用フォーム（非表示） -->
		<form id="deleteForm" action="${pageContext.request.contextPath}/WishlistDeleteCheckServlet" method="post" style="display:none;">
		    <input type="hidden" name="id" value="<%= work.getId() %>">
		    <input type="hidden" name="title" value="<%= work.getTitle() %>">
		</form>
		
		<!-- 戻る用フォーム（非表示） -->
		<form id="backForm" action="${pageContext.request.contextPath}/WishlistDetailServlet" method="get" style="display:none;">
		    <input type="hidden" name="id" value="<%= work.getId() %>">
		</form>
	
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>