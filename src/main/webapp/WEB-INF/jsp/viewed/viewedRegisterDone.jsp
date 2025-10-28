<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 登録完了</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	
    <h2>登録が完了しました</h2>
 
	<div class="btn-group">
    <form action="${pageContext.request.contextPath}/ViewedListServlet" method="get">
        <input type="submit" value="一覧へ戻る" class="nav_btn">
    </form>
	</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>