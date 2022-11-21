#!/bin/bash

DIR="/users/lspragu1/data/lspragu1/local/q-e-qe-6.3"

PSEUDO_DIR="./pseudo-gbrv-pbe/"
#EXCT_PW="$DIR/bin/pw.x"
#EXCT_PH="$DIR/bin/ph.x"
#EXCT_DIR="$DIR/bin"
EXCT_PW="/gpfs/runtime/opt/quantumespresso/6.6/bin/pw.x"
EXCT_PH="/gpfs/runtime/opt/quantumespresso/6.6/bin/ph.x"
EXCT_DIR="/gpfs/runtime/opt/quantumespresso/6.6/bin"
MPI_CMD="srun --mpi=pmix -n 16"

a="4.0"
c="30.0"
PREFIX="CuPd_rlx_1st_PBE"
ECUTWFC=60
ECUTRHO=650
KPTSX=4
KPTSY=4
KPTSZ=1
KPTSXX=40
KPTSYY=40
KPTSZZ=1

OUTDIR="/users/aafshar4/scratch/"

#------------------------------RELAX------------------------
# self-consistent calculation
cat > $PREFIX.rlx.in <<EOF
 &control
    calculation = 'relax',
    prefix = '$PREFIX',
    restart_mode='from_scratch',
!    restart_mode='restart',
    pseudo_dir ='$PSEUDO_DIR',
    outdir ='$OUTDIR',
    wf_collect=.true.,
    tstress = .true.,
    tprnfor = .true.,
    max_seconds = 135000,
    etot_conv_thr = 1.0d-7,
    forc_conv_thr = 1.0d-6,
 /
 &system
    ibrav=0,
!    celldm(1)=7.55890453,
!    a = $a,
!    c = $c,
    nat=60,
    ntyp=2,
    ecutwfc = $ECUTWFC,
    ecutrho = $ECUTRHO,
!    occupations='fixed',
    occupations='smearing',
    smearing='mp',
    degauss=0.02,
    input_dft='PBE',
!    nspin=2,
!    tot_magnetization=1.0d-20,
!    startin g_magnetization(5)=1.0d-20,
!    lda_plus_u=.true.,
!    Hubbard_U(2)=0.0,
!    lspinorb= .true.,
!    noncolin= .true.,
 /
 &electrons
    diagonalization = 'david',
    mixing_mode = 'plain',
    mixing_beta = 0.3,
    conv_thr =  1.0d-10,
    electron_maxstep = 1000,
 /
 &ions
    ion_dynamics = 'bfgs',
!    trust_radius_max=0.3,
!    trust_radius_min=1.0d-4,
 /
 &cell
    cell_dynamics = 'bfgs',
    press=0.0,
!    wmass=1.0d-5,
    cell_dofree = '2Dxy',
/
ATOMIC_SPECIES
    Cu  63.546  cu_pbe_v1.2.uspp.F.UPF
    Pd  106.42  pd_pbe_v1.4.uspp.F.UPF
ATOMIC_POSITIONS angstrom
Cu    0.0000000000    0.0000000000    0.5243847780  
Cu    2.1121280720    2.1121268850    0.5243817040  
Pd    0.0000000000    2.1121257740    1.9870915600  
Pd    2.1121268350    0.0000000000    1.9870898560  
Cu    0.0000000000    4.2242543590    0.5243813940  
Cu    2.1121280720    6.3363834740    0.5243817040  
Pd    0.0000000000    6.3363845850    1.9870915600  
Pd    2.1121234310    4.2242543590    1.9870957490  
Cu    4.2242634330    0.0000000000    0.5243805850  
Cu    6.3363823590    2.1121136200    0.5243850550  
Pd    4.2242518740    2.1121241690    1.9870930220  
Pd    6.3363823590    0.0000000000    1.9871035720  
Cu    4.2242487480    4.2242543590    0.5243805890  
Cu    6.3363823590    6.3363967390    0.5243850550  
Pd    4.2242518740    6.3363861900    1.9870930220  
Pd    6.3363823590    4.2242543590    1.9870818880  
Cu    8.4484996440    0.0000000000    0.5243805850  
Cu   10.5606366460    2.1121268850    0.5243817040  
Pd    8.4485112030    2.1121241690    1.9870930220  
Pd   10.5606328710    0.0000000000    1.9870898560  
Cu    8.4485143290    4.2242543590    0.5243805890  
Cu   10.5606366460    6.3363834740    0.5243817040  
Pd    8.4485112030    6.3363861900    1.9870930220  
Pd   10.5606412870    4.2242543590    1.9870957490  
Cu    0.0000000000    0.0000000000    3.5168364480  
Cu    2.1121230340    2.1121235160    3.5168403380  
Pd    0.0000000000    2.1121229030    5.0177650910  
Pd    2.1121215680    0.0000000000    5.0177608820  
Cu    0.0000000000    4.2242543590    3.5168442550  
Cu    2.1121230340    6.3363868430    3.5168403380  
Pd    0.0000000000    6.3363874560    5.0177650910  
Pd    2.1121293610    4.2242543590    5.0177589770  
Cu    4.2242548060    0.0000000000    3.5168440590  
Cu    6.3363823590    2.1121265030    3.5168386800  
Pd    4.2242507720    2.1121290750    5.0177557240  
Pd    6.3363823590    0.0000000000    5.0177594510  
Cu    4.2242587580    4.2242543590    3.5168335380  
Cu    6.3363823590    6.3363838560    3.5168386800  
Pd    4.2242507720    6.3363812840    5.0177557240  
Pd    6.3363823590    4.2242543590    5.0177543480  
Cu    8.4485082710    0.0000000000    3.5168440590  
Cu   10.5606416840    2.1121235160    3.5168403380  
Pd    8.4485123050    2.1121290750    5.0177557240  
Pd   10.5606381380    0.0000000000    5.0177608820  
Cu    8.4485043190    4.2242543590    3.5168335380  
Cu   10.5606416840    6.3363868430    3.5168403380  
Pd    8.4485123050    6.3363812840    5.0177557240  
Pd   10.5606353570    4.2242543590    5.0177589770  
Pd    0.0000000000    0.0000000000    6.5474996760
Pd    2.1121280720    2.1121268850    6.5474996760
Pd    0.0000000000    4.2242543590    6.5474996760
Pd    2.1121280720    6.3363834740    6.5474996760
Pd    4.2242634330    0.0000000000    6.5474996760
Pd    6.3363823590    2.1121136200    6.5474996760
Pd    4.2242487480    4.2242543590    6.5474996760
Pd    6.3363823590    6.3363967390    6.5474996760
Pd    8.4484996440    0.0000000000    6.5474996760
Pd   10.5606366460    2.1121268850    6.5474996760
Pd    8.4485143290    4.2242543590    6.5474996760
Pd   10.5606366460    6.3363834740    6.5474996760
CELL_PARAMETERS angstrom
   12.672767609    0.000000000   0.000000000
   0.0000000000    8.448521415   0.000000000
   0.0000000000    0.000000000   28.00000000
K_POINTS automatic
 $KPTSX $KPTSY $KPTSZ 0 0 0
EOF

$MPI_CMD $EXCT_PW < $PREFIX.rlx.in > $PREFIX.rlx.out

echo $i >>rlx_summary.out
grep ! $PREFIX.rlx.out >>rlx_summary.out
grep Fermi $PREFIX.rlx.out >>rlx_summary.out