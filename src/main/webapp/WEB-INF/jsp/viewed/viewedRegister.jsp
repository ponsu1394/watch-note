<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Genre, model.Star" %>
<%
    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
    List<Star> stars = (List<Star>) request.getAttribute("stars");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 観た作品登録フォーム</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- ヘッダー -->
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>観た作品を登録</h2>

    <form action="${pageContext.request.contextPath}/ViewedRegisterServlet" method="post">
        <div class="form-group">
            <label for="title">タイトル</label><br>
            <input type="text" id="title" name="title" required>
        </div><br>

        <div class="form-group">
            
            <%
                if (genres != null) {
                    for (Genre genre : genres) {
            %>
                <label>
                    <input type="checkbox" name="genreIds" value="<%= genre.getId() %>">
                    <%= genre.getName() %>
                </label>
            <%
                    }
                } else {
            %>
                <p>ジャンル情報が取得できませんでした。</p>
            <%
                }
            %>
        </div>

        <div class="form-group">
            <label for="starId">5段階評価:</label>
            <select id="starId" name="starId" required>
                <%
                    if (stars != null) {
                        for (Star star : stars) {
                %>
                    <option value="<%= star.getId() %>"><%= star.getLabel() %></option>
                <%
                        }
                    } else {
                %>
                    <option disabled>評価情報が取得できません</option>
                <%
                    }
                %>
            </select>
        </div>

        <div>
            <label for="review">感想:</label><br>
            <textarea id="review" name="review" rows="6" cols="50" required></textarea>
        </div>

        <div class="form-group">
            <input type="submit" value="登録する" class="nav_btn"">
            <a href="${pageContext.request.contextPath}/ViewedListServlet" class="nav_btn"">一覧に戻る</a>
        </div>
    </form>

    <!-- フッター -->
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>