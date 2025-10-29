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
	
    <h2>この内容でよろしいですか？</h2>
	<div class="work-link">
    <p><strong>〇タイトル</strong><br><%= title %></p><br>
    
    <p><strong>〇ジャンル</strong><br>
	<%
	    Set<Integer> selectedIds = new HashSet<>();
	    if (genreIds != null) {
	        for (String gid : genreIds) {
	            selectedIds.add(Integer.parseInt(gid));
	        }
	    }
	
	    List<String> selectedGenreNames = new ArrayList<>();
	    for (Genre genre : genres) {
	        if (selectedIds.contains(genre.getId())) {
	            selectedGenreNames.add(genre.getName());
	        }
	    }
	
	    out.print(String.join(" / ", selectedGenreNames));
	%>
</p><br>
    
    <p><strong>〇5段階評価</strong><br><%= star.getLabel() %></p><br>
    <p><strong>〇感想</strong><br><%= review %></p>
	</div>
	<div class="btn-group">


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
        <input type="submit" value="戻る" class="btn">
    </form>

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
        <input type="submit" value="登録" class="btn">
    </form>
	
	
	

   	</div>
	</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>