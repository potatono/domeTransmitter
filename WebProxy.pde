//import java.net.URI;
//import java.util.ArrayList;
//import java.util.Iterator;
//import org.java_websocket.WebSocket;
//import org.java_websocket.WebSocketImpl;
//import org.java_websocket.client.WebSocketClient;
//import org.java_websocket.server.WebSocketServer;
//import org.java_websocket.drafts.Draft;
//import org.java_websocket.drafts.Draft_10;
//import org.java_websocket.drafts.Draft_17;
//import org.java_websocket.drafts.Draft_75;
//import org.java_websocket.drafts.Draft_76;
//import org.java_websocket.handshake.ServerHandshake;
//import org.java_websocket.handshake.ClientHandshake;
//import java.net.InetSocketAddress;

//public class WebProxy extends Routine {
//  int ORBTICKS = 30;
//  String WSCURL = "ws://www.domestar.us:8000/dome";
//  int WSSPORT = 8000;

//  // List of color ellipses created by touching
//  ArrayList<Orb> orbs;

//  // ProxyClient connects to domestar.us to get messages from
//  // clients that cannot connect directly to this server
//  ProxyClient pc;

//  LocalServer server;

//  HashMap<String,Message> status;
  
//  void setup(PApplet parent) {
//    super.setup(parent);
  
//    orbs = new ArrayList<Orb>();
//    status = new HashMap<String,Message>();
    
//    // Setup proxy client.  New messages create new orbs.
//    pc = new ProxyClient(WSCURL) {
//        @Override
//        public void onMessage(Message message) {
//          synchronized(orbs) {
//            orbs.add(new Orb(message));
//            status.put(message.id,message);
//          }
//        }
//    }; 
    
//    // Setup server.
//    server = new LocalServer(WSSPORT) {
//      @Override
//      public void onMessage(Message message) {
//        synchronized(orbs) {
//          orbs.add(new Orb(message));
//          status.put(message.id,message);
//        }
//      }
//    };

//  }
  
//  void draw() {
//    // Draw all the orbs
//    synchronized(orbs) {
//      for (Orb o : orbs) {
//        o.draw(draw);
//      }
//    }
    
//    // Remove any orbs that have finished.
//    synchronized(orbs) {
//      for (Iterator<Orb> itr = orbs.iterator(); itr.hasNext();) {
//        Orb o = itr.next();
//        if (!o.enabled) itr.remove();
//      }
//    }
  
//    // Clear the status every now and again to wipe dead clients
//    if (frameCount % (frameRate*10) == 0) status.clear();
//  }
//}