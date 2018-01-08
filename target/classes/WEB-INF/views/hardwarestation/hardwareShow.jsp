<%@ page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page import="com.routon.plcloud.common.decorator.PageLinkDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ include file="/WEB-INF/views/head_n.jsp" %>
<%@ include file="/WEB-INF/views/activiti/RuntimeProcess.jsp" %>
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
		  			<form class="form-inline" role="form" id="queryform" name="queryform" action="${ctx}/hardwarestation/list.do"  method="post">  		
		  				<div class="btn-group" style="margin-top: 5px;margin-bottom: 5px;">
		  					<input size="20" type="text" id="HardwarestationName" name="HardwarestationName" value="${HardwarestationName}" class="form-control" placeholder="请输入硬件平台名称">
		  				</div>
		  				<div class="btn-group">
		  					<button id="queryBtn" type="submit" class="btn btn-primary" >查询</button>
		  				</div>
		  			<div class="btn-group">
		  				<button id="newBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#HardwarestationModal" onclick="newHardware()">新增</button>
		  			</div>
		  				<button id= "editBtn" type="button" class="btn btn-primary" onclick="edit()">编辑</button>
		  				<button id= "deleteBtn" type="button" class="btn btn-danger" onclick="delHardware()">删除</button>
		  			</form>
	  			</div>
  			</div> 
  		</div>
		<display:table name="${pageList}" id="curPage" class="table table-striped" sort="external"
			requestURI="list.do"
			decorator="com.routon.plcloud.common.decorator.PageLinkDecorator"
			export="false">
			<display:column property="id" title="<%=PageCheckboxDecorator.getTitle(pageContext)%>" decorator="com.routon.plcloud.common.decorator.PageCheckboxDecorator"  style="width:2%;"/>
			<display:column title="ID"  property="id"  sortable="true"  style="width:5%;" />
			<display:column title="硬件平台" property="hardwarestationName" sortable="true" style="width:5%;" ></display:column>
			<display:column title="适配操作系统" property="detailofOsnames" sortable="true" style="width:5%;" >
				<!-- <button id= "query" type="button" class="btn btn-primary" onclick="query()">查看</button> -->
				<!-- <a href="#" onclick="query()">查看</a> -->
			</display:column>
			<display:column title="创建时间"  property="createtime"  sortable="true"  style="width:5%;" maxLength="50" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
			<display:column title="修改时间"  property="moditytime" sortable="true"  style="width:5%;" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
		</display:table>
</div>

<div class="modal fade" id="opsystemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" style="width: 400px;">
        <div class="modal-content">
            <div class="modal-body">
           		<!--  windows7,IOS,android -->
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="HardwarestationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" style="width: 400px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">硬件平台管理</h4>
            </div>
            <div class="modal-body">
            	<form role="form" id="hardwareForm" name="hardwareForm" method='post' action='${ctx}/hardwarestation/add.do'>
            		<div class="form-group">
            			<input id="updateId" name="updateId" type="hidden">
    					<label for="name">硬件平台名称</label>
    					<input type="text" class="form-control" id="hardwarestationName" name="hardwarestationName">
    					<label for="url" >适配操作系统</label>
					      <c:forEach items="${opsystems}" var="opsystem" varStatus="wl"> 
							 <label class="checkbox-inline" style="margin-left: 0px;margin-right: 10px;">
							    <input type="checkbox" id="opsystemId${opsystem.id}" name="opsystemIds" value="${opsystem.id}">${opsystem.operatingsystemname}
							 </label>
						  </c:forEach>
  					</div>
            	</form>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="save('#hardwareForm', '${base}hardwarestation/add.do', '${base}hardwarestation/list.do?page=${page}')">保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
</div>
<script>

	$(document).ready(function() {
    	ToolTip.init({
        	delay: 400,
        	fadeDuration: 250,
        	fontSize: '1.0em',
       	 	theme: 'light',
       	 	textColor: '#757575',
        	shadowColor: '#000',
        	fontFamily: "'Roboto-Medium', 'Roboto-Regular', Arial"
    	});
	});
	
	function newHardware(){
		$("#hardwarestationName").val("");
		$("#opsystemIds").val("");
	}

	/* function query(){
		alert("显示操作系统");
		
		$('#opsystemModal').modal('show');
		
		$.ajax({
			url:'${base}hardwarestation/queryAllOpsystem.do',
			type:'post',
			data:{ id : selectedIds },
			async:false,
			success:function(str){ 
				var hardware= str.obj;
				var opsystems= str.obj1;
			}
		});
		
	} */
	
	function hoverEventD(obj){
		
		var idString = $(obj).attr("id");
		var id = idString.substring(8);
		var reuslt = "";
		var arr = new Array();
		
		$.ajax({
			url:'${base}hardwarestation/queryAllOpsystem.do',
			type:'post',
			data:{ hardwarestationId : id },
			async:false,
			success:function(data){
				for(var i = 0; i < data.length; i++){
					arr.push(data[i]);
				}
				var str=arr.join(",");
				$("#popoverD" + id).popover().mousemove(function() {  
					$("#popoverD" + id).attr('data-content', str);
			    });  
			}
		}); 

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
		$('#HardwarestationModal').modal('show');
		
		$.ajax({
			url:'${base}hardwarestation/querybyId.do',
			type:'post',
			data:{ id : selectedIds },
			async:false,
			success:function(str){ 
				var hardware= str.obj;
				var opsystems= str.obj1;
				$("#updateId").val(hardware.id);
				$("#hardwarestationName").val(hardware.hardwarestationName);
				if (opsystems != null && opsystems.length > 0) {
					var i = 0;
					for (i = 0 ; i < opsystems.length; i++){
						if(opsystems[i].checked == true){				
						    $("#opsystemId"+opsystems[i].id).attr('checked',true);
							continue;
						}
					}			
				}
			}
		});
	}
	
	function delHardware(){
		var selectedIds = getCheckedRowValue("");
		if(selectedIds==""){
			alert("至少选择一个删除!");
			return false;
		}
		del(selectedIds,'${ctx}/hardwarestation/delete.do', g_ctx + '/hardwarestation/list.do?page=${page}');
	}
</script>
<script src="${ctx}/js/tooltip.js"></script>
<script src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap-multiselect.js"></script>
<link rel="stylesheet" href="${ctx}/css/bootstrap-multiselect.css" type="text/css"/>
<%@ include file="/WEB-INF/views/common/myModal.jsp" %>
<%@ include file="/WEB-INF/views/foot_n.jsp" %>