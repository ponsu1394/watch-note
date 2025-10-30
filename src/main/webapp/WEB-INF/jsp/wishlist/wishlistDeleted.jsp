<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 削除完了</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />    
	<div class="work">
    	<p>「<%= request.getAttribute("title") %>」<br>を削除しました。</p>
    </div>
	<div class="btn-group">
    <form action="${pageContext.request.contextPath}/WishListServlet" method="get">
        <input type="submit" value="観たい作品一覧へ" class="nav_btn">
    </form>
	</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>