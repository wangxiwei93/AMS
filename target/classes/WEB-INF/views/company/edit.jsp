<%@page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net" %>

<%@ include file="/WEB-INF/views/head_n.jsp" %>
<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css">
<div class="panel panel-default">
  		<div class="panel-heading">
			<div class="pull-right">
				<a class="btn btn-primary" href="${ctx}/company/list.do?page=${page}" role="button">返回</a>
			</div>
			<c:choose>
				<c:when test="${company.id!=null}">
			    	<h5>编辑-<strong>${company.companyname}</strong></h5>
			   	</c:when>
			    <c:otherwise>
			    	<h5>新增</h5>
			   	</c:otherwise>
			</c:choose>
  		</div>
  		<div class="panel-body">
    		
			<form:form id="companyForm" name="companyForm" class="form-horizontal" role="form" method="post" enctype="multipart/form-data" >
				<input id="id" name="id" type="hidden" value="${company.id}" >
<%-- 				<input id="menuIds" name="menuIds" type="hidden" value="${role.menuIds}" > --%>
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">公司名称</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="companyname" name="companyname" placeholder="公司名称" value="${company.companyname}">
			    </div>
			  </div>
			  
			   <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">法人代表</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="companyrep" name="companyrep" placeholder="法人代表" value="${company.companyrep}">
			    </div>
			  </div>
			  
			     <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">英文名称</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="englishname" name="englishname" placeholder="英文名称" value="${company.englishname}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">名称拼音</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="namespell" name="namespell" placeholder="名称拼音" value="${company.namespell}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">纳税人识别号</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="identifynum" name="identifynum" placeholder="纳税人识别号" value="${company.identifynum}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">工商注册号</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="regnum" name="regnum" placeholder="工商注册号" value="${company.regnum}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">组织机构代码</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="organizationcode" name="organizationcode" placeholder="组织机构代码" value="${company.organizationcode}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">行业</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="trade" name="trade" placeholder="行业" value="${company.trade}">
			    </div>
			  </div>
			  
		
			  
			    <div class="form-group">
			  		<label for="title" class="col-sm-2 control-label">状态</label>
			  		<div class="col-sm-4">
			  		 <select id="status" name="status" class="form-control" >			    
			      		<option value="有效" selected="selected" >有效</option>
						<option value="无效" selected="selected" >无效</option>
				  </select>
				   </div>
			    </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">联系人姓名（客户商务）</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="contactname" name="contactname" placeholder="联系人姓名（客户商务）" value="${company.contactname}">
			    </div>
			  </div>
			  
			   <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">联系人手机</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="contactphone" name="contactphone" placeholder="联系人手机" value="${company.contactphone}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">联系人固定电话</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="contactfixedphone" name="contactfixedphone" placeholder="联系人固定电话" value="${company.contactfixedphone}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">电子邮件</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="email" name="email" placeholder="电子邮件" value="${company.email}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">销售人员</label>
			    <div class="col-sm-4">
				    <select id="salename" name="salename" class="form-control" onchange="specieSelChange(this)">
				      <option value="">--请选择公司销售人员姓名--</option> 
						      			<c:forEach var="item" items="${users}">
											<option value="${item}">${item}</option>
									    </c:forEach> 
					  </select>
			   
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">国家（地区）</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="country" name="country" placeholder="国家（地区）" value="${company.country}">
			    </div>
			  </div>
			  
			   <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">省（州）</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="province" name="province" placeholder="省（州）" value="${company.province}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">市（县）</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="city" name="city" placeholder="市（县）" value="${company.city}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">地址</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="address" name="address" placeholder="地址" value="${company.address}">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">邮政编码</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="邮政编码" value="${company.zipcode}">
			    </div>
			  </div>
			  
			  
			  
<!-- 			  <div class="form-group"> -->
<!-- 			    <label for="url" class="col-sm-2 control-label">权限菜单</label> -->
<!-- 			    <div class="col-sm-4"> -->
<!-- 			    	<div class="input-group"> -->
<%-- 			    		 <input type="text" class="form-control" id="menuNames" name="menuNames" readonly placeholder="请选择权限菜单" value="${role.menuNames}" > --%>
<!-- 					      <span class="input-group-btn"> -->
<!-- 					        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#mytree">选择<span class="caret"></span></button> -->
<!-- 					      </span> -->
<!-- 			    	</div> -->
<!-- 			    </div> -->
<!-- 			  </div> -->

<!-- 			 <div class="form-group"> -->
<!-- 			    <label for="url" class="col-sm-2 control-label">备注</label> -->
<!-- 			    <div class="col-sm-5"> -->
<%-- 			      <textarea id="remark" name="remark" class="form-control" rows="5">${role.remark}</textarea> --%>
<!-- 			    </div> -->
<!-- 			  </div> -->
			  
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button id="savebtn" name="savebtn" type="button" class="btn btn-primary" 
			      		onclick="save('#companyForm', 'save.do', g_ctx + '/company/list.do?page=${page}')">保存</button>
			    </div>
			  </div>
			  
			</form:form>
    		
  		</div>
</div>

<!-- <div class="modal fade" id="mytree" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!--   <div class="modal-dialog"> -->
<!--     <div class="modal-content" style="width: 300px;"> -->
<!--       <div class="modal-header"> -->
<!--         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> -->
<!--         <h4 class="modal-title" id="myModalLabel">选择菜单</h4> -->
<!--       </div> -->
<!--       <div class="modal-body"> -->
<!--         <ul id="treeDemo" class="ztree"></ul> -->
<!--       </div> -->
<!--       <div class="modal-footer"> -->
<!--         <button type="button" class="btn btn-primary" onclick="select()">选择</button> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->

<%@ include file="/WEB-INF/views/common/myModal.jsp" %>
<script src="${ctx}/js/common.js"></script>		
<script src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>	

<SCRIPT type="text/javascript">
		<!--
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
		//-->
	</SCRIPT>	
<%@ include file="/WEB-INF/views/foot_n.jsp" %>

