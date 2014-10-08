#include <stdio.h>

int nomalOutput();
int tiltOutput();
int evenOutput();
int wordOutput();

int main(void)
{
  char word[] = "What time is it now?";
  int i;

  nomalOutput(word);
  tiltOutput(word);
  evenOutput(word);
  wordOutput(word);

  return 0;
}

int nomalOutput(char word[])
{
  int i;

  printf("no1:\n");
  for(i = 0 ; word[i] != '\0';i++)
    {
      printf("%c",word[i]);
    }
  
  printf("\n");

  
  return 0;
}

int tiltOutput(char word[])
{
  int i;
  int j;

  printf("no2:\n");
  for(i = 0 ; word[i] != '\0';i++)
    {
      for(j = 0;j < i;j++)
	{
	  printf(" ");
	}
      printf("%c\n",word[i]);
    }
  
  printf("\n");

  
  return 0;
}

int evenOutput(char word[])
{
  int i;
  int j;

  printf("no3:\n");
  for(i = 0 ; word[i] != '\0';i++)
    {
      if((i+1)%2==0)
	{
	  printf(" ");
	}else
	{
	  printf("%c",word[i]);
	}
    }
  
  printf("\n");

  
  return 0;
}

int wordOutput(char word[])
{
  int i;
  int spscount; //space(空行)をカウント


  printf("no4:\n");

  printf("INput a word number=");
  scanf("%d",&spscount);

  for(i = 0 ; word[i] != '\0';i++)
    {
      if(spscount == 1)
	{
	  printf("%c",word[i]);
	}
      if(word[i] == ' ')
	{
	  spscount--;
	}
    }
  
  printf("\n");

  
  return 0;
}
