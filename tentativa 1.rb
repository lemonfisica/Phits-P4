! -------------------
! Material definitions
! -------------------
mdata
1   - C  0.111
2   - N  0.026
3   - O  0.762
4   - H  0.101
end
mat med_eq  1.0  1,2,3,4   ! Material "tecido equivalente" com densidade 1.0 g/cm³

# -------------------
# Geometry definitions
# -------------------
cell
1  med_eq -1.0 -2        # Paralelepípedo representando o fantoma
2  0      #2              # Região fora do fantoma é "vácuo"

surface
2  box 0.0 0.0 0.0  15.0 15.0 7.5   ! Fantoma de tecido equivalente

cell
3  med_eq -1.0 -4         ! Volume sensível cilíndrico
4  cyl 0.0 0.0 -6.5 0.5 0.1   ! Cilindro localizado dentro do fantoma

#-------------------
#Source definitions
#-------------------
source
s-type   2                ! Tipo: feixe
s-part   neutron          ! Partícula: nêutrons
energy   1.0              ! Energia de 1 MeV
dir      -1 0 0           ! Feixe na direção oposta ao eixo +Z
pos-d    flat  -15.0 15.0 -15.0 15.0   ! Distribuição de posição cobrindo o fantoma
ang-d    none             ! Distribuição angular paralela

#-------------------
#Scoring definitions
# -------------------
tally
f  4  3                   ! Fluência no cilindro sensível
d-unit  fluence           ! Unidade de fluência
particle neutron          ! Apenas para nêutrons
out    Hp10Flux.txt       ! Arquivo de saída para fluência

tally
f  4  3                   ! Dose absorvida no cilindro sensível
d-unit dose               ! Unidade de dose
particle neutron          ! Apenas para nêutrons
out    Hp10Dose.txt       ! Arquivo de saída para dose absorvida

#-------------------
#Neutron physics
#-------------------
neutron
nuclide-data JENDL4.0     ! Tabelas de interação de nêutrons de alta precisão
phys      QGSP_BIC_AllHP  ! Físicas de transporte

#-------------------
#Simulation settings
#-------------------
parameter
nps       1.0E8           ! Número de histórias
maxcas    1000000         ! Número máximo de casamentos de partículas

#-------------------
#Visualization (opcional)
#-------------------
vis
axis      on
size      1024 768
zoom      1.0
