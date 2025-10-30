<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WatchNote 編集完了</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	<div  class="work">
    	<p>登録が完了しました。</p>
    </div>
    <div  class="btn-group">
    	<a class="nav_btn" href="${pageContext.request.contextPath}/ViewedListServlet">観た作品一覧へ</a>
	</div>
	<jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
	
</body>
</html>