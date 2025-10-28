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
	<div class="work-link">
    <form action="${pageContext.request.contextPath}/ViewedRegisterServlet" method="post" >
        
        
            <label for="title">〇タイトル</label><br>
            <div class="input-wrapper">
            <input type="text" id="title" name="title" class="input-large" required >
        	</div>
        <br>

        
            <label>〇ジャンル（複数選択可）</label><br>
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
            %><br><br>
      

        
            <label for="starId">〇5段階評価</label>
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
        

        <div><br>
            <label for="review">〇感想</label><br>
            <div class="input-wrapper">
            <textarea id="review" name="review" class="textarea-large" required></textarea>
        	</div>
        </div>
	</div>
        <div class="btn-group">
            <input type="submit" value="登録する" class="nav_btn">
            <a href="${pageContext.request.contextPath}/ViewedListServlet" class="nav_btn">一覧に戻る</a>
        </div>
    </form>

    <!-- フッター -->
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>