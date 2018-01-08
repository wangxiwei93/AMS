<%@page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net" %>
<%-- <script src="${ctx}/js/jquery-easyui/jquery.easyui.min.js"></script> --%>

<%@ include file="/WEB-INF/views/head_n.jsp" %>
<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css">

	<div class="panel panel-default">
  		<div class="panel-heading" style="width:1528px;height:48px;"> 
  		    <div class="" style="display: inline-block;width: 100%;">
				<div class="pull-right" >
<%--         		<c:if test="${(!empty userPrivilege['40000101'])}">      --%>

				<form class="form-inline" role="form" id="queryform" name="queryform" action="${ctx}/user/show.do"  method="post">  
				
				<div class="btn-group">
  					<button type="button" class="btn btn-primary" onclick="">我方Excel导入</button>
  				</div>
  				<div class="btn-group">
  					<button type="button" class="btn btn-primary" onclick="">Excel导入</button>
  				</div>
<%--    				</c:if>  --%>
<%-- 				<c:if test="${(!empty userPrivilege['40000101'])}"> --%>
<!-- 				<div class="btn-group"> -->
<%--   					<button type="button" class="btn btn-primary" onclick="gotourl('${ctx}/user/add.do?page=${page}')">新增用户</button> --%>
<!--   				</div> -->
					<div class="btn-group">
		  				<button id="newBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#ProductModal" onclick="newUser()">新增用户</button>
		  			</div>
<%--   				</c:if> --%>
  				<c:if test="${(!empty userPrivilege['40000102'])}">
  				<div class="btn-group">
  					<button type="button" class="btn btn-primary" onclick="edit()">编辑用户</button>
  				</div>
  				</c:if>
<!--   				<div class="btn-group"> -->
<!--   					<button type="button" class="btn btn-primary" onclick="">新增项目负责人员</button> -->
<!--   				</div> -->
<!--   				<div class="btn-group"> -->
<!--   					<button type="button" class="btn btn-primary" onclick="">编辑项目负责人员</button> -->
<!--   				</div> -->
  				<c:if test="${(!empty userPrivilege['40000105'])}">
  				<div class="btn-group">
  					<button type="button" class="btn btn-primary" onclick="disableUser()">禁用用户</button>
  				</div>
  				</c:if>
  				<c:if test="${(!empty userPrivilege['40000103'])}">
  				<div class="btn-group">
  					<button type="button" class="btn btn-primary" onclick="reSetPwd()">重置密码</button>
  				</div>
  				</c:if>
  				<c:if test="${(!empty userPrivilege['40000104'])}">
  				<div class="btn-group">
  					<button type="button" class="btn btn-danger" onclick="deleteUser()">删除</button>
  				</div>
  				</c:if>
  				</form>
  			</div> 
  			 <h5>  系统    > 用户管理 </h5>
  			 </div>
  		</div>
  		
  		<div class="panel-body">
  			<div class="btn-group">
  			<form class="form-inline" role="form" id="queryform" name="queryform" action="${ctx}/user/show.do"  method="post">  		
  			<div class="btn-group">
  				<input id="phone" name="phone" type="text" class="form-control" placeholder="请输入用户电话" value="${phone}">
  			</div>
  			<div class="btn-group">
  				<input id="realName" name="realName" type="text" class="form-control" placeholder="请输入用户真实姓名" value="${realName}">
  			</div>
  			
  			<div class="form-group">
			    <div class="col-sm-4">
			      <select id="company" name="company" class="form-control" onchange="CompanySelect(this)">
			      <option value="">―请选择公司―</option> 
					      			<c:forEach var="item" items="${companynames}">
										<option value="${item}">${item}</option>
								    </c:forEach> 
				  </select>
			    </div>
			  </div>
<!-- 			  	<div class="form-group"> -->
<!-- 			    <div class="col-sm-4"> -->
<!-- 			      <select id="project" name="project" class="form-control"  > -->
<!-- 			      <option value="">―请选择项目―</option>  -->
<%-- 						<c:forEach var="itemproject" items = "$(projectnames)"> --%>
<%-- 							<option value = "${itemproject}">${itemproject}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 				  </select> -->
<!-- 			    </div> -->
<!-- 			  </div> -->
			  
  			<div class="btn-group">
  				<button type="submit" class="btn btn-primary" >查询</button>
  			</div>
  			</form>
  			</div>
<!-- 			<div class="pull-right"> -->
<%-- 				<c:if test="${(!empty userPrivilege['40000101'])}"> --%>
<!-- 				<div class="btn-group"> -->
<%--   					<button type="button" class="btn btn-primary" onclick="gotourl('${ctx}/user/add.do?page=${page}')">新增</button> --%>
<!--   				</div> -->
<%--   				</c:if> --%>
<%--   				<c:if test="${(!empty userPrivilege['40000102'])}"> --%>
<!--   				<div class="btn-group"> -->
<!--   					<button type="button" class="btn btn-primary" onclick="edit()">编辑</button> -->
<!--   				</div> -->
<%--   				</c:if> --%>
<%--   				<c:if test="${(!empty userPrivilege['40000103'])}"> --%>
<!--   				<div class="btn-group"> -->
<!--   					<button type="button" class="btn btn-primary" onclick="reSetPwd()">重置密码</button> -->
<!--   				</div> -->
<%--   				</c:if> --%>
<%--   				<c:if test="${(!empty userPrivilege['40000104'])}"> --%>
<!--   				<div class="btn-group"> -->
<!--   					<button type="button" class="btn btn-danger" onclick="deleteUser()">删除</button> -->
<!--   				</div> -->
<%--   				</c:if> --%>
<!--   			</div>  -->
  		</div>
  		
  		  		
		<!-- table -->
		<display:table name="requestScope.pageList" id="curPage" class="table table-striped" sort="external"
			requestURI="show.do"
			decorator="com.routon.plcloud.common.decorator.PageDecorator"
			export="false">
			<display:column property="id" title="<%=PageCheckboxDecorator.getTitle(pageContext)%>" decorator="com.routon.plcloud.common.decorator.PageCheckboxDecorator" media="html" style="width:2%;"/>
			<display:column title="ID"  property="id"  sortable="true"  style="width:5%;" />
<%-- 			<display:column title="登录名" sortable="true"  property="userName" style="width:10%;"> --%>
<%-- 			</display:column> --%>
			<display:column title="电话" sortable="true"  property="phone" style="width:10%;">
			</display:column>
			<display:column title="姓名" sortable="true"  property="realName" style="width:5%;">
			</display:column>
			<display:column title="角色" sortable="true"  property="name" style="width:10%;">
			</display:column>
			<display:column title="身份证号" sortable="true"  property="idcard" style="width:10%;">
			</display:column>
			<display:column title="公司" sortable="true"  property="company" style="width:15%;">
			</display:column>
<%-- 			<display:column title="项目" sortable="true"  property="project" style="width:10%;"> --%>
<%-- 			</display:column> --%>
			<display:column title="部门" sortable="true"  property="department" style="width:5%;">
			</display:column>
			<display:column title="创建时间"  property="createTime"  sortable="true"  style="width:15%;" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
			<display:column title="修改时间"  property="modifyTime"  sortable="true"  style="width:15%;" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
			<display:column title="状态" sortable="true"  sortProperty="status" style="width:5%;">
				<c:choose>
					<c:when test="${curPage.status == 1}">
					有效
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${curPage.status == 0}">
					无效
					</c:when>
				</c:choose>
			</display:column>
		</display:table>
	</div>	
<!-- 模态框（Modal） -->
<div class="modal fade" id="ProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" >
        <div class="modal-content" style="width: 400px;">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">用户信息</h4>
            </div>
            <div class="modal-body">
            	<form class="form-horizontal" role="form" id="productForm" name="productForm" method='post' action='${ctx}/user/add.do'>
<!-- 	            	 <div id="assignRole" class="form-group"> -->
	            	 		<input id="updateId" name="updateId" type="hidden">   
	            	 		<input id="projectIds" name="projectIds" type="hidden" value="${user.projectIds}" >
							<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;color:red;">姓名:</label>		
 								   <div class="col-sm-9" style="padding-left: 0px">					
							  		  <input type="text" class="form-control" id="realname" name="realname" placeholder="用户姓名"  >	
							  	  </div>
							</div>	
							<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;">身份证号:</label>		
 								   <div class="col-sm-9" style="padding-left: 0px">					
							  		   <input type="text" class="form-control" id="idcard" name="idcard" value="${user.idcard}"  placeholder="身份证号码" >	
							  	  </div>
							</div>					   
<!-- 							     <label for="name">身份证号:</label> -->
<%-- 								    <input type="text" class="form-control" id="idcard" name="idcard" value="${user.idcard}"  placeholder="身份证号码" > --%>
							<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;color:red;">电话号码:</label>		
 								   <div class="col-sm-9" style="padding-left: 0px">					
							  		   <input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="电话号码" >  
							  	  </div>
							</div>
<!-- 								 <label for="name">电话号码:</label> -->
<!-- 								    <input type="text" class="form-control" id="phone1" name="phone1" placeholder="电话号码" >   -->
							<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;color:red;">公司:</label>		
 								   <div class="col-sm-9" style="padding-left: 0px">					
							  		   <select class="form-control" id="companynames" name="companynames">
							      			<option value="">―请选择―</option>
							      			<c:forEach var="item" items="${companynames}">
												<option value="${item}">${item}</option>
										    </c:forEach> 
							      		</select> 
							  	  </div>
							</div>
<!-- 								 <label for="name">公司:</label> -->
<!-- 								 <select class="form-control" id="companynames" name="companynames"> -->
<!-- 					      			<option value="">―请选择―</option> -->
<%-- 					      			<c:forEach var="item" items="${companynames}"> --%>
<%-- 										<option value="${item}">${item}</option> --%>
<%-- 								    </c:forEach>  --%>
<!-- 					      		</select>    -->

							<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;">部门:</label>		
 								   <div class="col-sm-9" style="padding-left: 0px">					
							  		  <input type="text" class="form-control" id="department" name="department" placeholder="部门" >  
							  	  </div>
							</div>

<!-- 					      		 <label for="name">部门:</label> -->
<!-- 								    <input type="text" class="form-control" id="department" name="department" placeholder="部门" >   -->


						  <div id="assignRole" class="form-group" style="margin-right: 0px;"> 
					      		<label for="title"class="col-sm-3  control-label"  style="padding-left: 5px;padding-right: 5px;color:red;" >权限角色:</label>
					      		 <div class="col-sm-9" style="padding-left: 0px">	
					      		<c:forEach items="${roles}" var="role" varStatus="wl"> 
							    	<label class="checkbox-inline" style="margin-left: 0px;margin-right: 10px;">
<%-- 							    		<c:choose> --%>
<%-- 							    			<c:when test="${role.checked }"> --%>
<%-- 							    				<input type="checkbox" id="roleId${wl.index}" checked="checked" name="roleIds" value="${role.id}">${role.name} --%>
<%-- 							    			</c:when> --%>
<%-- 							    			<c:otherwise> --%>
							    				<input type="checkbox" id="roleId${role.id}" name="roleIds" value="${role.id}">${role.name}
<%-- 							    			</c:otherwise> --%>
<%-- 							    		</c:choose> --%>
									  
									</label>
						    	</c:forEach>
						    	</div>
						   </div>
						   
						   	<div class="form-group" style="margin-right: 0px;">
 								  <label for="title" class="col-sm-3 control-label"  style="padding-left: 5px;padding-right: 5px;color:red;">项目分组:</label>		
 								   <div class="col-sm-9 input-group" style="padding-left: 0px">					
							  		  <input type="text" class="form-control " id="project_texts" style="" name="project_texts" readonly placeholder="请选择分组" value="${user.project_texts}" >
					     					 <span class="input-group-btn " >
					      					  <button class="btn btn-default" type="button" data-toggle="modal" data-target="#projectTreeModal"  >选择<span class="caret"></span></button>
					     					 </span>  
							  	  </div>
							</div>
						   
<!-- 						   <div class="btn-group"> -->
<!-- 		  				<button id="newBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#ProductModal" onclick="newUser()">新增用户</button> -->
<!-- 		  			</div> -->
						   
<!-- 						    	<label for="url" >项目分组:</label> -->
<!-- 						    	<div> -->
<%-- 						    			<input type="text" class="form-control col-sm-4 " id="group_texts" name="group_texts" readonly placeholder="请选择分组" value="${user.group_texts}" > --%>
<!-- 					     					 <span class="input-group-btn col-sm-4" > -->
<!-- 					      					  <button class="btn btn-default" type="button" onclick="openGroupTreeModal()" >选择<span class="caret"></span></button> -->
<!-- 					     					 </span> -->
<!-- 						    	</div> -->
						    	
<!-- 				 	 </div> -->
            	</form>
			</div>
            <div class="modal-footer">
<!--                 <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
                <div class="btn-group">
                <a class="btn btn-primary" href="${ctx}/user/show.do?page=${page}" role="button">返回</a>
                </div>
                <div class="btn-group">
                	<button type="button" class="btn btn-primary" onclick="saveUser()">保存   </button> 
                </div>
               
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 项目分组模态框（Modal） -->
<div class="modal fade" id="projectTreeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm" >
    <div class="modal-content" >
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">项目分组</h4>
      </div>
      <div class="modal-body" style="padding: 0px;">
      
<!--       查询项目 -->
<!--       	<div class="input-group" style="margin-top: 5px;margin-bottom: 5px;margin-left: 10px;margin-right: 10px;"> -->
<!-- 			<input id="groupName" name="groupName" type="text" class="form-control" placeholder="请输入项目名称" > -->
<!-- 			<span class="input-group-btn"> -->
<!-- 	        	<button class="btn btn-default" type="button" onclick="queryProjectTree()">查询</button> -->
<!-- 	      	</span> -->
<!-- 		</div> -->

        <ul id="projectTree" class="ztree"></ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="selectProject()">选择</button>
      </div>
    </div>
  </div>
</div>

 		
	
	<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
	
	
	
<script src="${ctx}/js/common.js"></script>
<SCRIPT type="text/javascript">

	function zTreeOnClick(event, treeId, treeNode) {
	    alert(treeNode.tId + ", " + treeNode.name);
	};

	var zNodes_group = ${projectTreeBeans};
	var setting_group = {
		check : {
			enable : true

		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			onClick: zTreeOnClick
		}
	};
	var zTree;
	$(document).ready(function(){
		zTree = $.fn.zTree.init($("#projectTree"), setting_group, zNodes_group);	
	});
	
	function selectProject(){
		var nodes = zTree.getCheckedNodes(true);
		var ids = "";
		var projectNames = "";
		for(var i=0;i<nodes.length;i++){
			if(nodes[i].isParent){
				continue;
			}
			else{
			if(ids==""){
				ids = nodes[i].id;
				projectNames = nodes[i].name;
			}else {
				ids +=",";
				ids +=nodes[i].id;
				
				projectNames +=",";
				projectNames +=nodes[i].name;
			}
		}
			
		}
		
		$("#projectIds").val(ids);
		$("#project_texts").val(projectNames);
		$('#projectTreeModal').modal('hide')
	}
	
	
	
</SCRIPT>		
<script>

// function CompanySelect(tem_company){
// 	var data = tem_company.value;
// 	$.ajax({
// 		type        : "POST",
// 		url         : "${base}user/selectproject.do",
// 		data        :  {data : data},
// 		contentType : "application/x-www-form-urlencoded;charset=utf-8;",
// 		dataType    : "json",
// 		cache		  : false,
// 		success: function(info) {
// 			var data = info;
// 			$("#project").html("");
// // 			<option value="">―请选择项目―</option> 
// 			$("#project").append("<option value=''>-请选择项目-</option>");
//             $.each(data, function(){
//                 $("#project").append("<option value="+this.projectname+">"+this.projectname+"</option>");
//             });
			
			
// 		}
		
		
// 	}
// 	)
// }


function newUser(){
	//document.getElementById("productForm").submit();
	$("#realname").val("");
	$("#idcard").val("");
	$("#phoneNum").val("");
	document.getElementById("companynames").value = "";
	$("#department").val("");
	$("#roleIds").val("");
	$("#project_texts").val("");
}

function checkvalue(checkValue , inputname , length){
	if(checkValue==""){
		return true;
	}
	else if(checkValue.length >= length){
		alert("您输入的" + inputname + "信息长度过长，请重新输入!");
		return false;
	}
	else{
		return true;
	}
}

function saveUser(){
	var realname = $("#realname").val().trim();
	if(realname == ""){
		alert("请输入真实姓名!");
		return false;
	}

	var idcard = $("#idcard").val().trim();
	var inputname = "身份证号码";
	var length = 50;
	checkvalue(idcard,inputname,length);
	
	
	var phoneNum = $("#phoneNum").val();
	var len = phoneNum.length;
	if(phoneNum == ""){
		alert("请输入手机号码!");
		return false;
	}
	else if(len != 11){
		alert("请输入11位数字");
		return false;
	}
	else{
		for( i = 0 ; i < len ; i++){
			if(phoneNum[i] >=0 && phoneNum[i] <= 9 && phoneNum[i] != " "){
				continue;				
			}
			else{
				alert("您输入的第"+ (i+1)+"位不是数字，请输入0—9的数字" );
				return false;
			}
		}
	}
	
	
	var companyname = $("#companynames").val();
	if(companyname == ""){
		alert("请选择一个公司!");
		return false;
	}
	
	var roleId = document.getElementsByName("roleIds");
	n = 0;
	for(i = 0;i<roleId.length;i++){
		if(roleId[i].checked){
			n++;
		}		
	}
	if(n==0){
		alert("请选择至少一个角色!");
		return false;
	}
	
// 判断项目分组不能为空....
	var project_text = $("#project_texts").val();
	if(project_text == ""){
		alert("请至少选择一个项目!");
		return false;
	}

	
	save('#productForm', '${base}user/add.do', '${base}user/show.do?page=${page}');
}


function edit(){
	var selectedIds = getCheckedRowValue("");
	if(selectedIds==""){
		alert("请选择一个进行编辑!");
		return false;
	}
	var selectedId = selectedIds.split(",");
	if (selectedId.length != 1) {
		alert("请选择一个进行编辑!");
		return false;
	}
	$('#ProductModal').modal('show');
	


//	gotourl('${ctx}/user/querybyId.do?page=${page}&id='+selectedIds);
	$.ajax({
		url:'${base}user/querybyId.do',
		type:'post',
		data:{ id : selectedIds },
		async:false,
		success:function(str){
			//var info = eval('(' + str + ')');
			var user= str.obj;
			var roles= str.obj1;
			$("#updateId").val(user.id);
			$("#realname").val(user.realName);
			$("#idcard").val(user.idcard);
			$("#phoneNum").val(user.phone);
			document.getElementById("companynames").value = user.company;
			$("#department").val(user.department);
			$("#project_texts").val(user.project_texts);
			$("#projectIds").val(user.projectIds);
//  			$("#roleIds").val(data.roleIds);
			if (roles != null && roles.length > 0) {
				var i = 0;
				for (i = 0 ; i < roles.length; i++){
					if(roles[i].checked == true)
						{				
// 						$("#roleId"+roles[i].id).checked = true;
					    $("#roleId"+roles[i].id).attr('checked',true);
						continue;
						}
					
				}			
			}
			if(user.projectIds != null){
				var treeCheck = $.fn.zTree.getZTreeObj("projectTree");
				var nodes = treeCheck.getNodes();
				var projects = user.projectIds.split(",");
				//循环查找父节点
				for(i = 0 ; i < nodes.length ; i++){
					//循环查找子节点id
					for(j= 0 ; j < nodes[i].children.length ; j++){
						//循环查找后台传入的勾选项目节点
					   for(k = 0 ; k<projects.length ; k++ ){
						   if(nodes[i].children[j].id == projects[k]){
							   treeCheck.checkNode(nodes[i].children[j], true, true);
						   }
					   }
						
					}
					
				}
// 				var projects = user.projectIds.split(",");
// 				for( i = 0 ; i < projects.length ; i++ ){
// 					if(treeCheck.getNodeByParam("id", projects[i], null).isParent){
// 						continue;
// 					}
// 					else{
// 						treeCheck.checkNode(treeCheck.getNodeByParam("id", projects[i], null), true, true);
// 					}
					
// 				}
			}

		}
	});

}

function disableUser(){
	var selectedIds = getCheckedRowValue("");
		if(selectedIds == ""){
		alert("请至少选择一个用户进行禁用！");
		return false;
	}
	if(confirm("确认禁用该用户吗？")){
		var querydata ={};
		querydata.id = selectedIds;
		$.ajax({
			type        : "POST"
			,url         : "${ctx}/user/disableUser.do"
			,data        : querydata
			,contentType : "application/x-www-form-urlencoded;charset=utf-8;"
			,dataType    : "json"
			,cache		  : false	
			,success: function(info){
				if (info.code == 1) {
					alert("禁用用户成功!");
				}
				else if (info.code == 0) {
					alert(info.msg);
				}
				else if (info.code == -1) {
					alert("禁用用户异常!");
				}	
			}
		,error : function(XMLHttpRequest, textStatus, errorThrown) {    
			alert(XMLHttpRequest.status + textStatus);    
		} 	
		}
				
			);
	}
	
}

function reSetPwd(){
	var selectedIds = getCheckedRowValue("");
	if(selectedIds == ""){
		alert("至少选择一个用户重置密码!");
		return false;
	}
	if(confirm("确定重置密码吗?")) {
		var querydata = {};
		querydata.id = selectedIds;
		$.ajax({ 
			type        : "POST"
			,url         : "${ctx}/user/resetPwd.do"
			,data        : querydata
			,contentType : "application/x-www-form-urlencoded;charset=utf-8;"
			,dataType    : "json"
			,cache		  : false	
			,success: function(info) {
				
				if (info.code == 1) {
					alert("密码重置成功!");
				}
				else if (info.code == 0) {
					alert(info.msg);
				}
				else if (info.code == -1) {
					alert("密码重置异常!");
				}					
			}
			,error : function(XMLHttpRequest, textStatus, errorThrown) {    
				alert(XMLHttpRequest.status + textStatus);    
			} 	
		}
		);
	}
	
}

function deleteUser(){
	var selectedIds = getCheckedRowValue("");
	if(selectedIds == ""){
		alert("至少选择一个删除!");
		return false;
	}
	del(selectedIds,'${ctx}/user/delete.do', g_ctx + '/user/show.do?page=${page}');
}
</script>
<script src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>
<%@ include file="/WEB-INF/views/common/myModal.jsp" %>
<%@ include file="/WEB-INF/views/foot_n.jsp" %>

