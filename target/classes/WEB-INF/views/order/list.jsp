<%@ page import="com.routon.plcloud.common.decorator.PageCheckboxDecorator"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ include file="/WEB-INF/views/head_n.jsp" %>
<%@ include file="/WEB-INF/views/activiti/RuntimeProcess.jsp" %>
	<link rel="stylesheet" href="${ctx}/css/bootstrap-datetimepicker.css">
	<script src="${ctx}/js/bootstrap-datetimepicker.js"></script>
	<script src="${ctx}/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<style> 
.aaa1{ float:left}
</style>
<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css">
	<input id="hiddenInput" type="hidden" value="${treeNodeTid}">
	<div class="panel panel-default aaa1" style="width: 300px;">
		<div class="panel-heading ">
			<h5 id="grouptitle">选择分组</h5>
		</div>
  		<div class="panel-body">
  			<ul id="treeDemo" class="ztree"></ul>
		</div> 
	</div>
	
	<div class="modal fade" id="NewOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog" style="width: 1000px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">新建订单</h4>
            </div>
            <div class="modal-body">
            	<form role="form" class="form-inline" id="orderForm" name="orderForm" method='post'>
            	<input id="hiddenInput" type="hidden" value="${treeNodeTid}">
            	<div style="width:100%;text-align:center">
            	  <div class="form-group">
            		<table width="100%">
            			<tr align="left">
                			<td style="padding-top: 5px;"><label class="form-inline">公司名称：</label></td>
                			<td style="padding-top: 5px;"><input name="companyName" value="${company.companyname}" disabled="disabled" type="text" class="form-control" style="width: 276px;" /></td>
                			<td style="padding-top: 5px;"><label class="form-inline">公司地址：</label></td>
                			<td style="padding-top: 5px;"><input name="companyAddress" value="${company.address}" disabled="disabled" type="text" class="form-control" style="width: 276px;" /></td>
                	 	</tr> 
                	 	<tr align="left">
                			<td style="padding-top: 5px;"><label class="form-inline">项目名称：</label></td>
                			<td style="padding-top: 5px; padding-right: 20px;"><input name="projectName" value="${project.projectname}" disabled="disabled" type="text" class="form-control" style="width: 276px;" /></td>
                			<td style="padding-top: 5px;"><label class="form-inline">项目地址：</label></td>
                			<td style="padding-top: 5px;"><input type="text" name="projectAddress" value="${project.projectadd}" disabled="disabled" class="form-control" style="width: 276px;" /></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;" colspan="1"><label>客户商务人员姓名：</label></td>
							<td style="padding-top: 5px;" colspan="1"><input name="costomerBusinessMan" value="${company.contactname}" type="text" disabled="disabled" class="form-control" style="width: 150px;"/></td>
                			<td style="padding-top: 5px;" colspan="1"><label>客户商务人员电话：</label></td>
                			<td style="padding-top: 5px;" colspan="1"><input name="coustomerBusinessTel" value="${company.contactphone}" type="text" disabled="disabled" class="form-control" style="width: 150px;"/></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;"><label class="form-inline">客户项目负责人员姓名：</label></td>
							<td style="padding-top: 5px;"><input name="customerProLeader" type="text" value="${project.cusprojectname}" disabled="disabled" class="form-control" style="width: 150px;"/></td>
                			<td style="padding-top: 5px;"><label class="form-inline">客户项目负责人员电话：</label></td>
                			<td style="padding-top: 5px;"><input name="customerProLeaderTel" type="text" value="${project.cusprojectphone}" disabled="disabled" class="form-control" style="width: 150px;"/></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;"><label class="form-inline">拟剩余数量：</label></td>
							<td style="padding-top: 5px;"><input name="remainingNumber" type="text" value="${project.demandquantity}" disabled="disabled" class="form-control" style="width: 150px;"/></td>
                			<td style="padding-top: 5px;"><label class="form-inline">软件ERP编码：</label></td>
                			<td style="padding-top: 5px;"><select style="width: 150px;" class="form-control" id="erpCode" name="softwareerpnumber" onchange="specieSelChange(this)">
			      			<option value="">―请选择―</option>
			      			<c:forEach var="item" items="${softwareERPcodeList}">
								<option value="${item}">${item}</option>
						    </c:forEach> 
			      		</select></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;"><label class="form-inline">产品名称及版本号：</label></td>
							<td style="padding-top: 5px;"><input id="softwaretypeversion" name="softwaretypeversion" type="text" class="form-control" style="width: 150px;"/></td>
                			<td style="padding-top: 5px;"><label class="form-inline">需求数量：</label></td>
                			<td style="padding-top: 5px;"><input name="demandquantity" type="text" class="form-control" style="width: 150px;"/></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;"><label class="form-inline">授权类型：</label></td>
							<td style="padding-top: 5px;"><select style="width: 150px;" class="form-control" id="licensetype" name="licensetype">
			      			<option value="">―请选择―</option>
			      			<option value ="在线">在线</option>
			      			<option value ="离线">离线</option> 
			      		</select></td>
                			<td style="padding-top: 5px;"><label class="form-inline">到期提醒天数：</label></td>
                			<td style="padding-top: 5px;"><input name="reminderdays" type="text" class="form-control" style="width: 150px;"/></td>
                	 	</tr>
                	 	<tr align="left">
							<td style="padding-top: 5px;"><label class="form-inline">绑定方式：</label></td>
							<td style="padding-top: 5px;"><select style="width: 150px;" class="form-control" id="bindingmode" name="bindingmode">
			      			<option value="">―请选择―</option>
			      			<option value ="机器码">机器码</option>
			      			<option value ="设备码">设备码</option>
			      			<option value ="有效期">有效期</option>
			      			<option value ="机器码+有效期">机器码+有效期</option>
			      			<option value ="设备码+有效期">设备码+有效期</option>
			      		</select></td>
                	 	</tr>
                	 	<tr align="left">
                			<td style="padding-top: 5px;" colspan="4"><label class="form-inline">有效期：</label></td>
                	 	</tr>
                	 	<tr align="left">
                	 		<td style="padding-top: 5px;" colspan="4">
                	 			<table width="100%">
                	 				<tr align="left">
                	 					<td><input type="radio" id="radio_1" name="orderActiveStatus" value="1" onclick="fix(this)"/>&nbsp;&nbsp;&nbsp;</td>
                	 					<td><input type="text" name='month_1' class="form-control note_w" style="width: 50px;"/></td>
                	 					<td>月，自合同生效之日算起</td>
                	 					<td>
                	 						<div class="btn-group" style="margin-top: 5px;margin-bottom: 5px;">
			  									<div class="input-group date form_datetime">
						    						<input size="20" type="text" id="startTimeByContract" name="startTimeByContract" class="form-control note_w" readonly placeholder="请输入合同生效日期">
						   						    <span class="input-group-addon">
						    						<span class="glyphicon glyphicon-calendar"></span>
						   							</span>
												</div>
											</div>
										</td>
                	 				</tr>
                	 				<tr align="left">
                	 					<td><input type="radio" id="radio_2" name="orderActiveStatus" value="2" onclick="fix(this)"/></td>
                	 					<td><input type="text" name='month_2' class="form-control note_w" style="width: 50px;"/></td>
                	 					<td>月，自产品激活之日算起（合同生效三个月自动视为激活）</td>
                	 					<td>
                	 						<div class="btn-group" style="margin-top: 5px;margin-bottom: 5px;">
			  									<div class="input-group date form_datetime">
						    						<input size="20" type="text" id="startTimeByActive" name="startTimeByActive" class="form-control note_w" readonly placeholder="请输入产品激活日期">
						   						    <span class="input-group-addon">
						    						<span class="glyphicon glyphicon-calendar"></span>
						   							</span>
												</div>
											</div>
                	 					</td>
                	 				</tr>
                	 				<tr align="left">
                	 					<td colspan="1"><input type="radio" id="radio_3" name="orderActiveStatus" value="3" onclick="fix(this)"/></td>
                	 					<td colspan="2">永久有效</td>
                	 					<td colspan="1">
                	 						<div class="btn-group" style="margin-top: 5px;margin-bottom: 5px;">
			  									<div class="input-group date form_datetime">
						    						<input size="20" type="text" id="startDate_createTime" name="startDate_createTime" class="form-control note_w" readonly placeholder="请输入产品激活日期">
						   						    <span class="input-group-addon">
						    						<span class="glyphicon glyphicon-calendar"></span>
						   							</span>
												</div>
											</div>
                	 					</td>
                	 				</tr>
                	 			</table>
							</td>
                	 	</tr>
                	 	<tr align="left">
            				<td style="padding-top: 5px;" colspan="4"><label class="form-inline">补充说明：</label></td>
            			</tr>
            		</table>
            		<textarea name="remarks" rows="3" cols="100"></textarea>					  
  				   </div>
  				 </div>
            	</form>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="save('#orderForm', '${base}order/save.do', '${base}order/show.do?page=${page}')">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
	
	<div class="panel panel-default aaa1" style="width: 1222px;margin-left: 5px;">
		<div class="panel-heading" style="padding: 0px;height: 57px;">
	  			<div class="col-sm-8" style="width: 1250px;margin-top: 10px;">
	  				<input size="20" type="text" id="productName" name="productName" value="${productName}" placeholder="请输入订单号" style="width: 226px;padding-bottom: 0px;padding-top: 0px;height: 34px;">
		  			<button id= "queryBtn" type="submit" class="btn btn-primary" >查询</button>
		  			<button id= "newBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#NewOrderModal" disabled="disabled">新建订单</button>
		  			<button id= "detailBtn" type="button" class="btn btn-primary" disabled="disabled" onclick="addGroup()">订单详情</button>
		  			<button id= "orderAuthBtn" type="button" class="btn btn-primary" disabled="disabled" onclick="addGroup()">订单审核</button>
		  			<button id= "closeBtn" type="button" class="btn btn-danger"disabled="disabled" onclick="addGroup()">关闭订单</button>
	  			</div>
  		</div>
  		<display:table name="${pageList}" id="curPage" class="table table-striped" sort="external"
			requestURI="show.do"
			decorator="com.routon.plcloud.common.decorator.PageLinkDecorator"
			export="false">
			<display:column property="id" title="<%=PageCheckboxDecorator.getTitle(pageContext)%>" decorator="com.routon.plcloud.common.decorator.PageCheckboxDecorator"  style="width:2%;"/>
			<display:column title="订单号" property="ordernum" sortable="true" style="width:5%;" ></display:column>
			<display:column title="软件ERP编码" property="softwareerpnumber" sortable="true" style="width:5%;" ></display:column>
			<display:column title="软件名称及版本号" property="softwaretypeversion" sortable="true" style="width:5%;" ></display:column>
			<display:column title="需求数量" property="demandquantity" sortable="true" style="width:5%;" ></display:column>
			<display:column title="已发售数量" sortable="true" style="width:5%;" ></display:column>
			<display:column title="在线数量"  sortable="true" style="width:5%;" ></display:column>
			<display:column title="离线数量"  sortable="true" style="width:5%;" ></display:column>
			<display:column title="授权类型"  property="licensetype" sortable="true" style="width:5%;" ></display:column>
			<display:column title="生成时间" property="createtime" sortable="true" style="width:5%;" decorator="com.routon.plcloud.common.decorator.PageDateTimeDecorator"></display:column>
		</display:table>
	</div>
<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
	<SCRIPT type="text/javascript">

		var setting = {
			check: {
				enable: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
	        callback: {
	            beforeClick: function(treeId, treeNode) {
	                if (treeNode.isParent) {
	                    //zTree.expandNode(treeNode);
	                    return false;
	                } else {
	                    //demoIframe.attr("src",treeNode.file + ".html");
	                    var id = treeNode.id;
	                    var url = '${base}order/show.do?projectid=' + id + '&treeNodeTid='+ treeNode.tId + '&companyid=' + treeNode.pid;
	                    document.location.href = url;
	                   
	                }
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
			
		}
		
/* 		function addGroup(){
			$('#companyName').val("精伦普利");
		} */
		
		$(document).ready(function() {
			var checkedNodetid = $('#hiddenInput').val();
			$("#" + checkedNodetid + "_a").attr('class', 'curSelectedNode');
			if(checkedNodetid == '' || checkedNodetid == null){
				return false;
			} else {
				$("#newBtn").removeAttr("disabled");
			}
			
/* 		    if(!$("input[type='checkbox']").is(':checked'))  
		    {  
		    	
		    	$("#newBtn").attr("disabled", "disabled");
				$("#detailBtn").attr("disabled", "disabled");
				$("#orderAuthBtn").attr("disabled", "disabled");
				$("#closeBtn").attr("disabled", "disabled");
		    } else{  
		    	$("#newBtn").removeAttr("disabled");
				$("#detailBtn").removeAttr("disabled");
				$("#orderAuthBtn").removeAttr("disabled");
				$("#closeBtn").removeAttr("disabled");

		    }   */

		});
		
		function specieSelChange(selBox) {
			var data = selBox.value;
			$.ajax({ 
				type        : "POST",
				url         : "${base}order/querySoftwareNameByERPcode.do",
				data        :  {erpCode : data},
				contentType : "application/x-www-form-urlencoded;charset=utf-8;",
				scriptCharset: 'utf-8',
				success: function(info) {
		            $('#softwaretypeversion').val(info);
				}
			});
		}
		
		function fix(bel){
			var result = bel.value;
			if(result == '1'){
				$('#radio_1').parent().parent().find('.note_w').removeAttr('disabled');
				$('#radio_2').parent().parent().find(".note_w").attr('disabled','disabled');
				$('#radio_3').parent().parent().find(".note_w").attr('disabled','disabled');
			} else if(result == '2'){
				$('#radio_2').parent().parent().find('.note_w').removeAttr('disabled');
				$('#radio_1').parent().parent().find(".note_w").attr('disabled','disabled');
				$('#radio_3').parent().parent().find(".note_w").attr('disabled','disabled');
			} else if(result == '3'){
				$('#radio_3').parent().parent().find('.note_w').removeAttr('disabled');
				$('#radio_1').parent().parent().find(".note_w").attr('disabled','disabled');
				$('#radio_2').parent().parent().find(".note_w").attr('disabled','disabled');
			}
		}
</SCRIPT>
<script>
$(".form_datetime").datetimepicker({
    format: "yyyy-mm-dd hh:ii:ss",
    autoclose: true,
    todayBtn: true,
   	clearBtn:true,
    language:'zh-CN',
    pickerPosition: "bottom-left"
});
</script>
<script src="${ctx}/js/common.js"></script>
<script src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>	
<%@ include file="/WEB-INF/views/foot_n.jsp" %>