.global _start

.data

string1:
    .string "IWjjs3CHgjLtsxwghwN2M1xf"
string2:
    .string "UYJJvOxBG92P"
curDist:
    .space 404

oldDist:
    .space 404

curDistAdd:
    .long curDist

oldDistAdd:
    .long oldDist


.text
_start:

    movl $0, %ecx #i
    for_start:
        cmpl $101, %ecx #i - 0 >= 0
        jge for_end
        
        movl %ecx, %ebx

        movl %ecx, %ebx
        movl %ebx, oldDist(, %ecx, 4)
        movl %ebx, curDist(, %ecx, 4)

        incl %ecx

        jmp for_start
    for_end:


    movl $1, %ecx #i
    for_outer:
        cmpl $101, %ecx
        jge for_outer_end
        movl curDistAdd, %edi
        movl (%edi), %edi

        movl %ecx, %edi

        movl $1, %ebx #j
        for_inner:
            cmpl $101, %ebx
            jge for_inner_end
                if:
                    subl $1, %ecx
                    subl $1, %ebx

                    movb string1(, %ecx, 1), %al
                    cmpb %al, string2(, %ebx, 1)
                    jnz else_start

                    jz continue

                    continue:
                        movl oldDistAdd, %esi
                        #movl (%esi), %esi
                        movl (%esi, %ebx, 4), %edx
                        
                        addl $1, %ecx
                        addl $1, %ebx
                        
                        movl curDistAdd, %edi
                        #movl (%edi), %edi
                        movl %edx, (%edi, %ebx, 4)

                        jmp end_else

                else_start:

                    addl $1, %ecx
                    addl $1, %ebx

                    # do the min function

                    movl oldDistAdd, %esi
                    #movl (%esi), %esi
                    movl (%esi, %ebx, 4), %edx
                    subl $1, %ebx


                    movl curDistAdd, %edi
                    #movl (%edi), %edi
                    cmpl (%edi, %ebx, 4), %edx
                    jle not_edx
                    movl (%edi, %ebx, 4), %edx
                    
                    not_edx:
                        movl oldDistAdd, %esi
                        #movl (%esi), %esi
                        cmpl (%esi, %ebx, 4), %edx
                        jle not_edx_2
                        movl (%esi, %ebx, 4), %edx

        
                    not_edx_2:

                    addl $1, %edx
                    addl $1, %ebx

                    movl curDistAdd, %edi
                    #movl (%edi), %edi

                    movl %edx, (%edi, %ebx, 4)

                    
                end_else:

            incl %ebx
            jmp for_inner
        for_inner_end:

        # do the swap function

        movl oldDistAdd, %edi
        movl curDistAdd, %esi
        movl %esi, oldDistAdd
        movl %edi, curDistAdd

        incl %ecx
        jmp for_outer
    for_outer_end:

    movl oldDistAdd, %ebx
    
    movl 96*4(%ebx), %eax



done:
    nop



# display ((int*)&curDist)[0]@100
# display ((int*)&oldDist)[0]@100
