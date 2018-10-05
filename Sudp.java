import java.net.*;
import java.io.*;
public class Sudp
{
	public static void main(String args[]) throws IOException
	{
		DatagramSocket ds = new DatagramSocket();
		InetAddress ip = InetAddress.getByName("localhost");
		System.out.println(ip);
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		int port = 2345;
		String msg;
		while(true)
		{
			msg=br.readLine();
			DatagramPacket dp=new DatagramPacket(msg.getBytes(),msg.length(),ip,port);
			if(!msg.equals("quit"))
				ds.send(dp);
			else
				break;
		}
	}
}
