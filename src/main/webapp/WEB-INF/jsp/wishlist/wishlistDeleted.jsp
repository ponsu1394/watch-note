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

    <h2>削除完了</h2>
    <p>「<strong><%= request.getAttribute("title") %></strong>」を削除しました。</p>

    <form action="${pageContext.request.contextPath}/WishListServlet" method="get">
        <input type="submit" value="一覧に戻る" class="nav_btn">
    </form>

    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>