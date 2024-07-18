set title 'DOS-Bi'
set style line 6 lt 6 lw 2.0 lc rgb 'blue'
set xlabel 'Energía'
set ylabel 'Densidad de Estados'
plot 'borrame.txt' u 1:2 w lines ls 6
