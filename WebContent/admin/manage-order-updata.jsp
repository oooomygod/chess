<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ page import="java.util.*"%>
<%@ page import="com.cyf.dao.*" %>
<%@ page import="com.cyf.bean.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
    <meta charset="GB18030">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>二手书网站后台管理界面</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*媒体查询，小屏幕（平板，大于等于768px）*/
        @media (min-width:768px){
            #leftbar{
                width:240px;
                margin:55px 0px 0px 0px;
                position:absolute;
                /*z-index:1;*/
                height:500px;
                /*background:#B9DEF0;*/
            }
            .page-right{
                background:#ddd;
                margin:-5px 0px 0px 245px;
            }
        }
        /* */
        .left-dh{
            margin: 10px 0px;
        }
        @media (max-width:768px){
            body{
                background:#777;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default navbar-static-top">
    <div class="navbar-header">
        <a href="#" class="navbar-brand">二手书网站后台管理</a>
        <button class="navbar-toggle" data-toggle="collapse" data-target="#login">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <button class="navbar-toggle" data-toggle="collapse" data-target="#leftbar">
            <span>设置</span>
        </button>
    </div>
    <ul class="nav navbar-nav navbar-right navbar-collapse collapse" id="login" style="margin:0px 20px 0px 0px;">
       <c:set var="username" scope="session" value="${currentUser.userName}"/>
		<c:choose>
		 <c:when test="${not empty username}">
		    <li><a href="#"><span class="badge" >当前用户：</span>${currentUser.userName}</a></li>
		    </c:when>
		    <c:otherwise>
		    <li><a href="#"><span class="badge">当前用户：</span>未登录${currentUser.userName}</a></li>
		    </c:otherwise>
		</c:choose>
        <li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					用户 <b class="caret"></b>
				</a>
				<ul class="dropdown-menu">
					<li><a href="http://localhost:8080/bookstore/user/user-update.jsp">个人中心</a></li>
					<li class="divider"></li>
					<li><a href="http://localhost:8080/bookstore/login.jsp">登录</a></li>
					<li class="divider"></li>
					<li><a href="http://localhost:8080/bookstore/logout">退出登录</a></li>
				</ul>
			</li>
    </ul>
    <div class="navbar-collapse collapse" id="leftbar">
        <ul class="nav" id="mz">
            <li class="panel panel-default">
                <a href="#lanmu" data-toggle="collapse" data-parent="#mz">订单管理<span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
                <ul class="panel-collapse collapse nav" id="lanmu">
	                <li><a href="manage-order-updata.jsp">订单修改</a></li>
	                <li><a href="manage-order-delete.jsp">订单删除</a></li>
                    <li><a href="OrderAdminServlet">订单浏览</a></li>
                </ul>
            </li>
            <li class="panel panel-default">
                <a href="#la" data-toggle="collapse" data-parent="#mz">用户管理<span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
                <ul class="panel-collapse collapse nav" id="la">
	                <li><a href="manage-user-delete.jsp">用户信息删除</a></li>
                    <li><a href="userselectServlet">用户信息浏览</a></li>
                </ul>
            </li>
            <li class="panel panel-default">
                <a href="#l" data-toggle="collapse" data-parent="#mz">书籍管理<span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
                <ul class="panel-collapse collapse nav" id="l">
	                <li><a href="manage-book-delete.jsp">书籍删除</a></li>
                    <li><a href="bookselectServlet">书籍信息浏览</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<!--右边主要区域 -->
<div class="page-right">
    <ol class="breadcrumb">
        <li><a href="#">首页管理</a></li>
        <li><a href="#">后台功能</a></li>
        <li><a href="#">订单浏览</a></li>
    </ol>    
    <div class="row">
        <div class="col-sm-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    订单管理
                </div>
               <c:choose>
	            <c:when test="${empty orderlist}">
	                <h3 class="text-center">没有订单记录 </h3>
	            </c:when>
	            <c:otherwise>
                <div class="panel-body">
                <form class="form-inline" action="OrderAdminServlet" method="get">
                    <table class="table table-striped table-hover table-responsive">
                        <thead>
                    <tr>
                        <th>订单id</th>
                        <th>用户id</th>
                        <th>用户名</th>
                        <th>书id</th>
                        <th>书名</th>
                        <th>购买数量</th>
                        <th>价格</th>
                        <th>下单时间</th>
                        <th>订单状态</th>
                        <th>操作</th>
                        
                    </tr>
                    </thead>
                    <tbody>
                    <form class="form-inline"  method="get">
                    <c:forEach items="${orderlist}" var="list" varStatus="status">
                        <tr>
                            <td>${list.id}</td>
                            <td>${list.userid}</td>
                            <td>${list.username}</td>
                            <td>${list.bookid}</td>
                            <td>${list.bookname}</td>
                            <td>${list.count}</td>
                            <td>${list.price}</td>
                            <td>${list.time}</td>
                             <td>
                            <div class="form-group">
							<select class="form-control" id="statu" name="statu">
									<option  value="下单"  <c:if test="${ list.status == '下单' }">selected</c:if>>下单</option>
									<option  value="发货"  <c:if test="${ list.status == '发货' }">selected</c:if>>发货</option>
									<option  value="到货"  <c:if test="${ list.status == '到货' }">selected</c:if>>到货</option>
								</select>
							</div></td>
							<%
							
							String statu = request.getParameter("statu");
							
							System.out.print(statu);
							%>
							<td><a href="OrderupdateServlet?order_statu=<%=statu%>&order_id=${list.id}">修改</a></td>
                        </tr>
                    </c:forEach> 
                    </form>            
                    </tbody>
                    </table>
                    </form>
                </div>
                </c:otherwise>
             </c:choose>
            </div>
        </div>
    </div>
</div>
</html>