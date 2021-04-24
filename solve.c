#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>


int main()
{
    printf("Enter your text:")
    char s[];
    char s1[];
    int counter1 = 0, counter2 = 0;

    gets_s(s);
    puts(s);

    for (int i = 0; s[i] != '\0'; i++)
    {
        if ((s[i] >= 65) && (s[i] <= 90))
        {
            counter1++;
        }
        else
        {
            if ((s[i] >= 97) && (s[i] <= 122))
            {
                counter2++;
            }
        }
    }

    if (counter1 == counter2)
    {
        s1 = condition_1(s);
    }
    else
    {
        s1 = condition_2(s);
    }

    puts(s1);
    return 0;
}

char condition_1(char s)
{
    for (int i = 0; s[i] != '\0'; i++)
    {
        s[i] = s[i] + 32;
    }
    return s;
}

char condition_2(char s)
{
    int coun = 0, j = 1;
    char s1[];
    s1[0] = s[0];
    for (int i = 1; s[i] != '\0'; i++)
    {
        if (s[i] != s[i - 1])
        {
            s1[j] = s[i];
            j++;
        }
    }
    return s1;
}
