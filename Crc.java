import java.util.*;
public class Crc {
	public static void main(String args[])
	{

	Scanner sc=new Scanner(System.in);
	int n,g,flag=0;
	
	

	System.out.println("Enter the number of bits of data");
	n=sc.nextInt();

	System.out.println("Enter the number of bits of generator");
	g=sc.nextInt();
	
	int data[]=new int[100];
	System.out.println("Enter the data bits");
	for(int i=0;i<n;i++)
	{
		data[i]=sc.nextInt();
	}
	
	int gen[]=new int[100];
	System.out.println("Enter the generator bits");
	for(int j=0;j<g;j++)
	{
		gen[j]=sc.nextInt();
	}
	
	
	for(int i=n;i<n+g-1;i++)
		data[i]=0;
	
	/*System.out.println(" the data bits");
	for(int i=0;i<n+g-1;i++)
		System.out.println(data[i]);*/
	
	int codedata[]=new int[100];
	
	codedata=div(data,gen,n,g);
	System.out.println("The code word sent by the sender");
	for(int i=0;i<n+g-1;i++)
		System.out.println(codedata[i]);
	
	int datar[]=new int[100];
	System.out.println("recieved data");
	for(int i=0;i<n+g-1;i++)
		datar[i]=sc.nextInt();
	

	int codedatar[]=new int[n+g];
	
	codedatar=div(datar,gen,n,g);
	
	for(int i=n;i<n+g-1;i++)
	{
		if(codedata[i]==0)
		{
			flag=1;
		}
		else
		{
			flag=0;
		}
	}
	if(flag==1)
		System.out.println("Correct data");
	else
		System.out.println("Incorrect data");
	
	}
	
	
	public static int[] div(int data[],int gen[],int n,int g)
	{
		int r[]=new int[n+g];
		for(int i=0;i<g;i++)
		{
			r[i]=data[i];
		}
		for(int i=0;i<n;i++)
		{
			int k=0;
			int msb=r[i];
			for(int j=i;j<g+i;j++)
			{
				if(msb==0)
				{
					r[j]=r[j]^0;
				}
				else
				{
					r[j]=r[j]^gen[k];
					k++;
				}
				r[g+i]=data[g+i];
			}
				
			
		}
		System.out.println("REMAINDER");
		for(int i=n;i<n+g-1;i++)
		{
			data[i]=r[i];
			System.out.println(data[i]);
			
		}
		return data;
	}
	}


	
	





