#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head)
{
    // MY SOLUTION HERE
    if(head == NULL) 
        return 0;
    node *hare = head, *tortoise = head;
    while (1)
    {
        if (hare->next == NULL || hare->next->next == NULL)
            return 0;
        hare = hare->next->next;
        tortoise = tortoise->next;
        if (tortoise == hare)
            return 1;
    }
    return 0;
}