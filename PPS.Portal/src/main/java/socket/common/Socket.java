package socket.common;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.websocket.server.ServerEndpoint;
import common.HttpSessionConfigurator;
import common.ISocket;
import common.IWorkflow;
import common.JsonConverter;
import common.LoggerManager;
import common.Util;
import common.Workflow;
import contoller.LoginContoller;
import entity.NavigateNode;
import entity.WebSocketNode;
import entity.WebSocketResult;
import model.User;
import reference.CardMaster;
import reference.CardRoleCache;

@ServerEndpoint(value = "/socket", configurator = HttpSessionConfigurator.class)
public class Socket extends ISocket {
	private static Map<String, IWorkflow> flyweight = new HashMap<>();
	private static Map<String, Map<String, Method>> flyweight2 = new HashMap<>();

	public void main(WebSocketNode node) {
		WebSocketResult ret = null;
		try {
			ret = getExecute(IWorkflow.Login, IWorkflow.Init, node);
			sendMessage(IWorkflow.Login, IWorkflow.Init, ret.getData(), node.getSession());
			if (Util.StringEquals(ret.getData(), LoginContoller.NG)) {
				return;
			}
			if (!isRoleCheck(node.getControl(), node)) {
				JsonObjectBuilder obj = Json.createObjectBuilder();
				obj.add("type", "danger");
				obj.add("msg", "You don't have permission.");
				sendMessage(IWorkflow.Login, IWorkflow.Permission, obj.build().toString(), node.getSession());
				return;
			}
			ret = getExecute(node.getControl(), node.getAction(), node);
			List<NavigateNode> navi = ret.getNavigate();
			if (navi != null) {
				sendMessage("navigate", IWorkflow.Init, JsonConverter.create(navi), node.getSession());
			}
			sendMessage(ret);
		} catch (Throwable e) {
			LoggerManager.getLogger(Socket.class).error(e);
		}
	}

	private WebSocketResult getExecute(String control, String action, WebSocketNode node) throws Throwable {
		Method mthd = getMethod(control, action);
		IWorkflow clz = getClass(control);

		return (WebSocketResult) mthd.invoke(clz, node);
	}

	private boolean isRoleCheck(String control, WebSocketNode node) throws Throwable {
		User user = getUserinfo(node.getSession()).getUser();
		IWorkflow clz = getClass(control);
		Workflow anno = clz.getClass().getDeclaredAnnotation(Workflow.class);
		if (anno.cardrole().isEmpty()) {
			return true;
		}
		return CardRoleCache.hasPermission(user, CardMaster.getDao().getCard(anno.cardrole()));
	}

	private Method getMethod(String control, String action) throws Throwable {
		IWorkflow clz = getClass(control);
		if (!flyweight2.containsKey(control)) {
			flyweight2.put(control, new HashMap<>());
		}
		Map<String, Method> sub = flyweight2.get(control);

		if (!sub.containsKey(action)) {
			sub.put(action, clz.getClass().getDeclaredMethod(action, WebSocketNode.class));
		}
		return sub.get(action);
	}

	private IWorkflow getClass(String control) throws Throwable {
		if (control == null || control.length() < 1) {
			return null;
		}
		if (!flyweight.containsKey(control)) {
			Class<?> clz = SocketBundleSet.getList().stream().filter(x -> {
				Workflow anno = x.getDeclaredAnnotation(Workflow.class);
				if (anno != null && control.equals(anno.name())) {
					return true;
				}
				return false;
			}).findFirst().get();
			if (clz == null) {
				return null;
			}
			flyweight.put(control, (IWorkflow) clz.newInstance());
		}
		return flyweight.get(control);
	}
}
