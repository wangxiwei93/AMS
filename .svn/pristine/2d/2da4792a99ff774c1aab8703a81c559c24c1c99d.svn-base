<%@ page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ include file="/WEB-INF/views/head_n.jsp" %>
<%@ include file="/WEB-INF/views/activiti/RuntimeProcess.jsp" %>

<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css">

<div style="
    width: 1520px;
    padding-left: 0px;
    margin-left: 0px;
    margin-top: 50px;
">
	<div class="panel panel-default" style="width: 1560px;">
		<div class="panel-heading " style="padding: 0px;">
  			<div class="" style="display: inline-block;width: 100%;">
  			
	  			<div class=" col-sm-8" style="width: 1530px;">
		  			<form class="form-inline" role="form" id="queryform" name="queryform" action="${ctx}/role/list.do"  method="post">  		
		  				<div class="btn-group" style="margin-top: 5px;margin-bottom: 5px;">
		  					<input size="20" type="text" id="rolename" name="rolename" value="${rolename}" class="form-control" placeholder="请输入角色名称">
		  				</div>
		  				<div class="btn-group">
		  					<button id="queryBtn" type="submit" class="btn btn-primary" >查询</button>
		  				</div>
		  			<div class="btn-group">
		  				<button id="newBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#RoleModal" onclick="newRole()">新增</button>
		  			</div>
		  				<button id= "editBtn" type="button" class="btn btn-primary" onclick="edit()">编辑</button>
		  				<button id= "deleteBtn" type="button" class="btn btn-danger" onclick="delRole()">删除</button>
		  			</form>
	  			</div>
  			</div> 
  		</div>
		<display:table name="${pageList}" id="curPage" class="table table-striped" sort="external"
			requestURI="list.do"
			export="false">
			<display:column property="id" title="<%=PageCheckboxDecorator.getTitle(pageContext)%>" decorator="com.routon.plcloud.common.decorator.PageCheckboxDecorator"  style="width:2%;"/>
			<display:column title="ID"  property="id"  sortable="true"  style="width:5%;" />
			<%-- <display:column title="序号" sortable="true" style="width:5%;" >
				<c:out value="${curPage_rowNum}"/>
			</display:column> --%>
			<display:column title="角色名称" property="name" sortable="true" style="width:5%;" ></display:column>
			<display:column title="创建时间"  property="createTime"  sortable="true"  style="width:5%;" maxLength="50" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
			<display:column title="修改时间"  property="modifyTime" sortable="true"  style="width:5%;" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
		</display:table>
</div>
<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
<!-- 模态框（Modal） -->
<div class="modal fade" id="RoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" style="width: 400px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">角色类型</h4>
            </div>
            <div class="modal-body">
            	<form role="form" id="roleForm" name="roleForm" method='post' action='${ctx}/role/add.do'>
            		<div class="form-group">
            			<input id="updateId" name="updateId" type="hidden">
            			<input id="menuIds" name="menuIds" type="hidden" value="${role.menuIds}" >
    					<label for="name">角色名称</label>
    					<!-- <input type="text" class="form-control" id="name" name="name"> -->
    					<input type="text" class="form-control" id="name" name="name" placeholder="角色名称">
    					
    					<label for="name">权限菜单</label>
    					<!-- <input type="text" class="form-control" id="menuNames" name="menuNames"> -->
    					<input type="text" class="form-control" id="menuNames" name="menuNames" readonly placeholder="请选择权限菜单" value="${role.menuNames}">
					    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#mytree">选择<span class="caret"></span></button>
					      
    					<label for="name">备注:</label>
    					<!-- <textarea id="remark" name="remark" class="form-control" rows="5"></textarea> -->
    					<textarea id="remark" name="remark" class="form-control" rows="5"></textarea>
  					</div>
            	</form>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="save('#roleForm', '${base}role/add.do', '${base}role/list.do?page=${page}')">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mytree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style="width: 300px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">选择菜单</h4>
      </div>
      <div class="modal-body">
        <ul id="treeDemo" class="ztree"></ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="select()">选择</button>
      </div>
    </div>
  </div>
</div>

</div>

<SCRIPT type="text/javascript">

		var setting = {
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

		var zNodes =${menuTreeBeans};
		
		
		var zTree;
		$(document).ready(function(){
			zTree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
			
			
		});
		
		function select(){
			var nodes = zTree.getCheckedNodes(true);
			var ids = "";
			var menuNames = "";
			for(var i=0;i<nodes.length;i++){
				if(ids==""){
					ids = nodes[i].id;
					menuNames = nodes[i].name;
				}else {
					ids +=",";
					ids +=nodes[i].id;
					
					menuNames +=",";
					menuNames +=nodes[i].name;
				}
				
			}
			
			$("#menuIds").val(ids);
			$("#menuNames").val(menuNames);
			$('#mytree').modal('hide')
		}
	
	</SCRIPT>	


<script>
	function newRole(){
		$("#name").val("");
		$("#menuNames").val("");
		$("#remark").val("");
		
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
		$('#RoleModal').modal('show');
		/* 回填input */
		$.ajax({
			url:'${base}role/querybyId.do',
			type:'post',
			data:{ id : selectedIds },
			async:false,
			success:function(data){
				$("#updateId").val(data.id);
				$("#name").val(data.name);
				$("#menuNames").val(data.menuNames);
				$("#remark").val(data.remark);
			}
		});
		/* 回填树是否checked */
		$.ajax({
			url:'${base}role/queryChecked.do',
			type:'post',
			data:{ id : selectedIds },
			async:false,
			success:function(data){
				
				var treeCheck = $.fn.zTree.getZTreeObj("treeDemo");
				
				for(var i = 0;i < data.length; i++) {
					treeCheck.checkNode(treeCheck.getNodeByParam("id", data[i], null), true, true);
				}
				
			}
		});
	}
	
	function delRole(){
		var selectedIds = getCheckedRowValue("");
		if(selectedIds==""){
			alert("至少选择一个删除!");
			return false;
		}
		/* var selectedId = selectedIds.split(",");
		if (selectedId.length != 1) {
			alert("请选择一个进行删除!");
			return false;
		} */
		del(selectedIds,'${ctx}/role/delete.do', g_ctx + '/role/list.do?page=${page}');
	}
</script>
<script src="${ctx}/js/common.js"></script>
<script src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>
<%@ include file="/WEB-INF/views/common/myModal.jsp" %>
<%@ include file="/WEB-INF/views/foot_n.jsp" %>