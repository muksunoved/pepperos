#include "printf.h"
#include "screen.h"
#include "types.h"
#include "pci.h"

int main(void) {   
    clear_screen();
    printf("\n>>> Hello World!\n");
    PCIScan();

    return 0;
}

