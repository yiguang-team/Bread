package com.yiguang.payment.activiti.util;

import java.util.List;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.junit.Test;

public class ActivitiUtil {

	ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
	
	/**
	 * 部署流程定义
	 */
	@Test
	public void deploymentProcessDefinition() {
		// 与流程定义和部署对象相关的service
		Deployment deployment = processEngine.getRepositoryService().createDeployment() // 创建一个部署对象
																						// /Activiti-test/src/main/resources/diagrams
				.name("下单流程") // 添加部署的名称
				.addClasspathResource("diagrams/merchantOrder.bpmn")// 从classpath的资源中加载，一次只能加载一个
				.addClasspathResource("diagrams/merchantOrder.png")// 从classpath的资源中加载，一次只能加载一个
				.deploy();// 完成部署
		System.out.println("部署ID：" + deployment.getName());
		System.out.println("部署名称：" + deployment.getId());
	}

	/**
	 * 启动流程实例
	 */
	@Test
	public void startProcessInstance() {
		// 流程定义的key
		String processDefinitionKey = "activitiOrder";
		ProcessInstance processInstance = processEngine.getRuntimeService()// 与正在执行的流程实例与执行对象相关的Service
				.startProcessInstanceByKey(processDefinitionKey);// 使用流程定义的key启动流程实例，key对应bpmn文件中id的属性值

		System.out.println("流程实例ID:" + processInstance.getId()); // 流程实例id 
		System.out.println("流程定义ID:" + processInstance.getProcessDefinitionId()); // 流程定义id
																					
	}

	/**
	 * 查询当前人的个人任务
	 */
	@Test
	public void findMyPersonTask() {
		String assignee = "张三";
		List<Task> list = processEngine.getTaskService() // 与正在执行的任务管理相关的service
				.createTaskQuery() // 创建任务管理查询对象
				.taskAssignee(assignee) // 指定个人任务查询，指定办理人
				.list();
		if (list != null && list.size() > 0) {
			for (Task task : list) {
				System.out.println("任务ID：" + task.getId()); // 12504
				System.out.println("任务名称：" + task.getName()); // 提交申请
				System.out.println("任务的创建时间：" + task.getCreateTime()); 
				System.out.println("任务的办理人：" + task.getAssignee());
			}
		}
	}

	/**
	 * 完成我的任务
	 */
	@Test
	public void completeMyPersonalTask() {
		// 任务ID 7504
		String taskId = "12504";
		processEngine.getTaskService().complete(taskId);
		System.out.println("完成任务：任务ID:" + taskId);
	}

}
