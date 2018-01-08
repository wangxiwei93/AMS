<%@page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ include file="/WEB-INF/views/head_n.jsp" %>
<script src="${ctx}/js/jquery-easyui/jquery.easyui.min.js"></script>

<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>流程ID</th>
				<th>实例ID</th>
				<th>任务名称</th>
				<th>当前节点</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pageList}" var="task">
				<tr>
					<td class='process-id'>${task.id }</td>
					<td>${task.processInstanceId }</td>
					<td class='process-name'>${task.processDefinitionId }</td>
					<td>${task.name }</td>
					<td><button id="startup">结束当前任务</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<%@ include file="/WEB-INF/views/foot_n.jsp" %>