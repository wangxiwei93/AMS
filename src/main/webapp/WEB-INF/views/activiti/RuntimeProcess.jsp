<%@ page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page import="com.routon.plcloud.common.decorator.PageLinkDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

	<div class="container" style="width: 1560px; height: 50px" >
	<p>
		<font size="3" color="blue">销售助理新建项目→系统管理员审核→客户商务人员申请→销售助理审核→客户商务人员审核→财务审核→客户商务人员分配账号→客户项目负责人员上传授权清单→项目技术人员确定软件产品及版本号→项目管理人员审核→终端授权</font>
	</p>
	
	<ul id="tab" class="nav nav-pills">
  		<li id="tab1" value="1" role="presentation" class="active"><a href="#"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> 运行中流程</a></li>
  		<li id="tab2" value="2" role="presentation"><a href="#"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> 已结束流程</a></li>
	</ul>
	<div id="container">
	<div id="content1" style="z-index: 1;">
		<display:table name="${List}" id="curPage" class="table table-striped" sort="external" partialList="false"
			requestURI="show.do"
			decorator="com.routon.plcloud.common.decorator.PageLinkDecorator"
			export="false">
			<display:column title="项目" sortable="true" style="width:5%;" ></display:column>
			<display:column title="申请人" sortable="true" style="width:5%;" ></display:column>
			<display:column title="任务创建时间" sortable="true"  style="width:5%;" ></display:column>
			<display:column title="授权数量" sortable="true"  style="width:5%;" ></display:column>
			<display:column title="结束时间" sortable="true"  style="width:5%;" ></display:column>
			<display:column title="流程ID" sortable="true" property="id" style="width:5%;" ></display:column>
			<display:column title="实例ID"  property="processInstanceId"  sortable="true"  style="width:5%;" maxLength="50"></display:column>
			<display:column title="任务名称"  property="processDefinitionId" sortable="true"  style="width:5%;"></display:column>
			<display:column title="代办事项"  property="name"  sortable="true"  style="width:9%;"></display:column>
			<display:column title="操作" property="button" sortable="true"  style="width:8%;" >${curPage_rowNum}, ${curPage.processDefinitionId}, ${curPage.processInstanceId}</display:column>
		</display:table>
	</div>
	<div id="content2" style="display:none;">
		<p>已结束流程还在开发中...</p>
	</div>
	</div>
	
	<script>
	function finisheTask(obj){
		var id = $(obj).parents('tr').find('.process-id').text();
		$.ajax({
			url:'${base}activiti/finisheTask.do',
			type:'post',
			data:{  taskId : id },
			async:false,
			success:function(data){
				if(data == "success"){
					alert("流程已启动");
				}
			}
		});
	}
	
	function showStartupProcessDialog(obj) {
		var id = $(obj).parents('tr').find('.process-id').text();
		var taskname = $(obj).parents('tr').find('.process-name').text();
		var html = "<input id = \"input1\" type=\"text\" name=\"processid\" value=\""+ id +"\">&nbsp<input id = \"input2\" type=\"text\" name=\"taskname\" value=\""+ taskname +"\"></input></input></br></br><button id=\"startup1\" onclick=\"finisheTaskapprove(this)\" >同意</button>&nbsp&nbsp&nbsp&nbsp&nbsp<button id=\"startup2\" onclick=\"finisheTaskdisaprove(this)\" >不同意</button>";
	    BootstrapDialog.show({
	        title: '审核任务',
	        message: html
	    })
	}
	
	function finisheTaskapprove(obj){
		var id = $("#input1").val();
		$.ajax({
			url:'${base}activiti/finisheTaskCondition.do',
			type:'post',
			data:{  taskId : id , pass : true},
			async:false,
			success:function(data){
				if(data == "success"){
					alert("任务已通过");
				}
			}
		});
	}
	
	function finisheTaskdisaprove(obj){
		var id = $("#input2").val();
		$.ajax({
			url:'${base}activiti/finisheTaskCondition.do',
			type:'post',
			data:{  taskId : id , pass : false},
			async:false,
			success:function(data){
				if(data == "success"){
					alert("任务否决");
				}
			}
		});
	}

// 	$("#tab>li").click(function(){
// 		//console.log(this);
// 		/* $("#content"+$(this).val()).attr('style','z-index:1').siblings("div").removeAttr("style"); */
// 		$("#content"+$(this).val()).attr('style','display:inline').siblings("div").attr('style', 'display:none');
// 		$("#tab"+$(this).val()).attr('class','active').siblings("li").removeAttr("class");
// 		});         
	
	$("#tab1").click(function(){

		$("#content1").attr('style','display:inline');
		$("#content2").attr('style','display:none');
		$("#tab1").attr('class','active');
		$("#tab2").removeAttr("class");
	}); 
	
	$("#tab2").click(function(){

		$("#content2").attr('style','display:inline');
		$("#content1").attr('style','display:none');
		$("#tab2").attr('class','active');
		$("#tab1").removeAttr("class");
	}); 
	
</script>
<script src="${ctx}/js/bootstrap-dialog.min.js"></script>
<script src="${ctx}/js/jquery-easyui/jquery.easyui.min.js"></script>
