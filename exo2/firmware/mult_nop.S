.section .start;
.globl start;

nop :
	addi x0,x0,0

start:
	li t0,0x8 #t0
	li t1,0x7 #t1
	li t2,0x0 #compteur
	li t3,0x0 #resultat
	li t4,0x10 #16 pour comparer le compteur

loop:
	addi t2,t2,1 
	andi t5,t1,1 #t5 = t1 & 1
	nop
	nop
	nop # t5 n'a pas eu le temps de se mettre a jour
	beq t5,x0,pas_vrai #si ca vaut 0 on fait pas le calcul
	nop #control hazard, au moment du branchement on prend une décision sur un truc qui a pas ete maj encore. Pour éviter de fetch l'incrémentation de t3
	nop
	add t3,t3,t0
pas_vrai :
	slli t0,t0,1
	srli t1,t1,1
	bne t2,t4,loop


lab :  j  lab
#control hazard ! So NOP for jump instruction. Je gère le controle hazard lié au jump
	nop

.end start



