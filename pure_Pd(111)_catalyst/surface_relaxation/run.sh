#!/bin/bash

###DIR="/users/aafshar4/data/aafshar4/local/q-e-qe-6.3"

PSEUDO_DIR="./pseudo-gbrv-pbe/"
#EXCT_PW="$DIR/bin/pw.x"
#EXCT_PH="$DIR/bin/ph.x"
#EXCT_DIR="$DIR/bin"
EXCT_PW="/gpfs/runtime/opt/quantumespresso/6.6/bin/pw.x"
EXCT_PH="/gpfs/runtime/opt/quantumespresso/6.6/bin/ph.x"
EXCT_DIR="/gpfs/runtime/opt/quantumespresso/6.6/bin"
MPI_CMD="srun --mpi=pmix -n 72"

a="4.0"
c="30.0"
PREFIX="Pd_relax"
ECUTWFC=30
ECUTRHO=350
KPTSX=4
KPTSY=4
KPTSZ=1
KPTSXX=40
KPTSYY=40
KPTSZZ=1

OUTDIR="/users/aafshar4/scratch/"

#------------------------------RLX------------------------
# self-consistent calculation
cat > $PREFIX.rlx_vdw.in <<EOF
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
    max_seconds = 150000,
    etot_conv_thr = 1.0d-4,
    forc_conv_thr = 1.0d-3,
 /
 &system
    ibrav=0,
!    celldm(1)=7.55890453,
!    a = $a,
!    c = $c,
    nat=72,
    ntyp=1,
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
!     Hubbard_U(1)=7.0,
!    lspinorb= .true.,
!    noncolin= .true.,
 /
 &electrons
    diagonalization = 'david',
    mixing_mode = 'plain',
    mixing_beta = 0.3,
    conv_thr =  1.0d-6,
    electron_maxstep = 200,
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
!   cell_dofree = '2Dxy',
/
ATOMIC_SPECIES
    Pd 106.420 pd_pbe_v1.4.uspp.F.UPF
ATOMIC_POSITIONS angstrom
Pd    0.000000    0.000000    0.000000
Pd    0.000000    0.000000    6.912615
Pd    0.000000    2.822063    0.000000
Pd    0.000000    2.822063    6.912615
Pd    0.000000    5.644126    0.000000
Pd    0.000000    5.644126    6.912615
Pd    4.887957    0.000000    0.000000
Pd    4.887957    0.000000    6.912615
Pd    4.887957    2.822063    0.000000
Pd    4.887957    2.822063    6.912615
Pd    4.887957    5.644126    0.000000
Pd    4.887957    5.644126    6.912615
Pd    9.775913    0.000000    0.000000
Pd    9.775913    0.000000    6.912615
Pd    9.775913    2.822063    0.000000
Pd    9.775913    2.822063    6.912615
Pd    9.775913    5.644126    0.000000
Pd    9.775913    5.644126    6.912615
Pd    4.073297    1.411032    2.304205
Pd    4.073297    4.233095    2.304205
Pd    4.073297    7.055158    2.304205
Pd    8.961254    1.411032    2.304205
Pd    8.961254    4.233095    2.304205
Pd    8.961254    7.055158    2.304205
Pd   13.849210    1.411032    2.304205
Pd   13.849210    4.233095    2.304205
Pd   13.849210    7.055158    2.304205
Pd    1.629319    0.000000    2.304205
Pd    1.629319    2.822063    2.304205
Pd    1.629319    5.644126    2.304205
Pd    6.517276    0.000000    2.304205
Pd    6.517276    2.822063    2.304205
Pd    6.517276    5.644126    2.304205
Pd   11.405232    0.000000    2.304205
Pd   11.405232    2.822063    2.304205
Pd   11.405232    5.644126    2.304205
Pd    3.258638    0.000000    4.608410
Pd    3.258638    2.822063    4.608410
Pd    3.258638    5.644126    4.608410
Pd    8.146594    0.000000    4.608410
Pd    8.146594    2.822063    4.608410
Pd    8.146594    5.644126    4.608410
Pd   13.034551    0.000000    4.608410
Pd   13.034551    2.822063    4.608410
Pd   13.034551    5.644126    4.608410
Pd    0.814659    1.411032    4.608410
Pd    0.814659    4.233095    4.608410
Pd    0.814659    7.055158    4.608410
Pd    5.702616    1.411032    4.608410
Pd    5.702616    4.233095    4.608410
Pd    5.702616    7.055158    4.608410
Pd   10.590573    1.411032    4.608410
Pd   10.590573    4.233095    4.608410
Pd   10.590573    7.055158    4.608410
Pd    2.443978    1.411032    0.000000
Pd    2.443978    1.411032    6.912615
Pd    2.443978    4.233095    0.000000
Pd    2.443978    4.233095    6.912615
Pd    2.443978    7.055158    0.000000
Pd    2.443978    7.055158    6.912615
Pd    7.331935    1.411032    0.000000
Pd    7.331935    1.411032    6.912615
Pd    7.331935    4.233095    0.000000
Pd    7.331935    4.233095    6.912615
Pd    7.331935    7.055158    0.000000
Pd    7.331935    7.055158    6.912615
Pd   12.219892    1.411032    0.000000
Pd   12.219892    1.411032    6.912615
Pd   12.219892    4.233095    0.000000
Pd   12.219892    4.233095    6.912615
Pd   12.219892    7.055158    0.000000
Pd   12.219892    7.055158    6.912615     
CELL_PARAMETERS angstrom
        14.663880000         0.0000000000         0.0000000000
        0.0000000000         8.4661800000         0.0000000000
        0.0000000000         0.0000000000         27.000000000
K_POINTS automatic
 $KPTSX $KPTSY $KPTSZ 0 0 0
EOF

$MPI_CMD $EXCT_PW < $PREFIX.rlx_vdw.in > $PREFIX.rlx_vdw.out

echo $i >>rlx_vdw_summary.out
grep ! $PREFIX.rlx_vdw.out >>rlx_vdw_summary.out
grep Fermi $PREFIX.rlx_vdw.out >>rlx_vdw_summary.out
