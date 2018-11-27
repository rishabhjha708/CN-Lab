import java.security.*;
import java.math.*;
import java.io.*;

public class rsa {
		
		BigInteger n,p,q,phi,d,e;
		public rsa(int bits)
		{
			int bitlen;
			bitlen=bits;
			SecureRandom r =new SecureRandom();
			p=new BigInteger(bitlen/2,100,r);
			System.out.println(p);
			q=new BigInteger(bitlen/2,100,r);
			System.out.println(q);
			n=p.multiply(q);
			phi=(p.subtract(BigInteger.ONE)).multiply(q.subtract(BigInteger.ONE));
			e=new BigInteger(bitlen/2,100,r);
			while(e.compareTo(BigInteger.ONE)>0 && e.compareTo(phi)<0)	
				{
					if(phi.gcd(e).equals(BigInteger.ONE))
						{
							break;
						}
					e=new BigInteger(bitlen/2,100,r);
				}
			System.out.println(e);
			d=e.modInverse(phi);
			System.out.println(d);
		}
		
		public synchronized BigInteger encrypt(BigInteger Message)
		{
			return Message.modPow(e,n);
		}
		public synchronized BigInteger decrypt(BigInteger Message)
		{
			return Message.modPow(d,n);
		}
		public static void main(String args[])throws IOException
		{
			rsa rsa=new rsa(1024);
			BufferedReader br =new BufferedReader(new InputStreamReader(System.in));
			String text1,text2;
			BigInteger plaintext,ciphertext;
			System.out.println("Enter plain text");
			text1=br.readLine();
			plaintext=new BigInteger(text1.getBytes());
			System.out.println("Enter cipher text");
			ciphertext=rsa.encrypt(plaintext);
			System.out.println(ciphertext);
			plaintext=rsa.decrypt(ciphertext);
			text2=new String(plaintext.toByteArray());
			System.out.println("plain text after decryption is: "+text2);
		}
}			
			





