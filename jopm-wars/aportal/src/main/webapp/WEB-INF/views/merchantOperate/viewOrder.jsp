<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>商户操作-查看订单</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<META http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript"
	src="${ctx}/template/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="${ctx}/template/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx}/template/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/js/index/index.js"></script>
<script type="text/javascript"
	src="${ctx}/template/common/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function getTotal() {
	var beginDate =  $('#beginDate').val();
	var endDate =  $('#endDate').val();
	var merchantId =  $('#merchantId').val();
	
    $.ajax({  
	    data:{
			beginDate:beginDate,
			endDate:endDate,
			merchantId:merchantId
		 },
		type:'post',
		cache:false,
		dataType:'text',
        url : "${ctx}/merchantOperate/total",
        success : function(result) {  
            $('#total').val(result);
        }
    });
}

function exportExcel() {
	var merchantId =  $('#merchantId').val();
	var beginDate =  $('#beginDate').val();
	var endDate =  $('#endDate').val();
	location.href= '${ctx}/merchantOperate/excel?merchantId='+merchantId+'&beginDate=' + beginDate+'&endDate=' + endDate;
}
</script>
<link
	href="${ctx}/template/jquery-easyui-1.4.1/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/template/jquery-easyui-1.4.1/themes/icon.css"
	rel="stylesheet" type="text/css" />
<!-- bootstrap & fontawesome -->
<link rel="stylesheet"
	href="${ctx}/template/ace/assets/css/bootstrap.css" />
<link rel="stylesheet"
	href="${ctx}/template/ace/assets/css/font-awesome.css" />

<!-- page specific plugin styles -->

<!-- text fonts -->
<link rel="stylesheet"
	href="${ctx}/template/ace/assets/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/template/ace/assets/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />
<link rel="stylesheet" href="${ctx}/template/ace/assets/css/ace-ie7.css" />

<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx}/template/ace/assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx}/template/ace/assets/css/ace-ie.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="${ctx}/template/ace/assets/js/ace-extra.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
		<script src="${ctx}/template/ace/assets/js/html5shiv.js"></script>
		<script src="${ctx}/template/ace/assets/js/respond.js"></script>
		<![endif]-->
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<!-- #section:basics/content.breadcrumbs -->
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> 商户操作 <span
							class="noshow jt">></span></li>
						<li class="active">查看订单</li>
					</ul>
					<!-- /.breadcrumb -->
				</div>

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">

					<!--搜索-->
					<div class="row">
						<div class="table-container">
							<span class="labeltxt fl">商户：</span> <select name="merchantId"
								id="merchantId" onchange="" class="form-control fl"
								style="width: 150px; float: left;">
								<c:choose>
									<c:when test="${fn:length(merchantList) > 0}">
										<c:forEach items="${merchantList}" var="option">
											<option value="${option.value}">${option.text}</option>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<option value=""></option>
									</c:otherwise>
								</c:choose>
							</select>
								
							<span class="labeltxt fl">开始时间：</span> <input id="beginDate"
								name="beginDate" type="text"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-{%M-3}-%d',maxDate:'#F{$dp.$D(\'beginDate\')|| \'%y-%M-%d\'}'});"
								value="${beginDate}" class="fl form-text" /> <span
								class="labeltxt fl">结束时间：</span> <input id="endDate"
								name="endDate" type="text"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endDate\') || \'%y-{%M-3}-%d\'}',maxDate:'%y-%M-%d'});"
								value="${endDate}" class="fl form-text" /> <input
								class="btn btn-sm btn-primary no-border" type="button"
								value="查询充值总额" onClick="getTotal()" /> <input
								class="btn btn-sm btn-primary no-border" type="button"
								value="导出充值明细" onClick="exportExcel()" />
							<hr>
							充值总额为：<input id="total" class="easyui-validatebox" /> 元
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>