BEGIN{
#include <stdio.h>
c=0;
}
{
	if($1=="d")
		c++;
}
END{
	printf("No of packets dropeed: %d",c);
}
