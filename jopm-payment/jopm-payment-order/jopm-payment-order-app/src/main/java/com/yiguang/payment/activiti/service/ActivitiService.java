package com.yiguang.payment.activiti.service;

import java.util.Map;

import com.yiguang.payment.activiti.entity.WorkFlowBean;
import com.yiguang.payment.payment.order.entity.MerchantOrder;

public interface ActivitiService {

	public void  startProcessInstance(WorkFlowBean workFlowBean);//启动流程实例
	
	public void completeTask(String taskId, Map<String,Object> variables);
	
	public MerchantOrder findMerchantOrderByTaskId(String taskId);
}
