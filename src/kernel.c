#include "printf.h"
#include "screen.h"
#include "types.h"
#include "pci.h"

void DrawFractal(void);

int main(void) {   
    clear_screen();
    printf("\n>>> Hello World!\n");
    PCIScan();
    DrawFractal();

    return 0;
}

