#set term jpeg font 'Helvetica,20'
set terminal postscript eps enhanced color font 'Helvetica,20'

#Qualitative set 2 - color blind safe
set style line 53 lt 1 lc rgb "#ff0000" lw 2 pt 1
set style line 54 lt 1 lc rgb "#2727ff" lw 2 pt 2
set style line 55 lt 1 lc rgb "#000000" lw 2 pt 3
set style line 56 lt 1 lc rgb "#984ea3" lw 2 pt 4
set style line 57 lt 1 lc rgb "#ff7f00" lw 2 pt 5
set style line 58 lt 1 lc rgb "#ffff33" lw 2 pt 6
set style line 59 lt 1 lc rgb "#a65628" lw 2 pt 7
set style line 60 lt 1 lc rgb "#f781bf" lw 2 pt 8
set style line 61 lt 2 lc rgb "#000000" lw 1.5 pt 9

set style line 101 lc rgb '#000000' lt 1 lw 3
set border 1+2+4+8 front ls 101



#Compression Ratio
set xlabel "{/Symbol e}_1 - Filler Material"
set ylabel "{/Symbol e}_2 - Particle Material"
set output "eps1_v_eps2.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 3:4 w p notitle
set term jpeg
set output "eps1_v_eps2.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol e}_1 - Filler Material"
set ylabel "{/Symbol m}_1 - Filler Material"
set output "eps1_v_mu1.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 3:5 w p notitle
set term jpeg
set output "eps1_v_mu1.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol e}_1 - Filler Material"
set ylabel "{/Symbol m}_2 - Particle Material"
set output "eps1_v_mu2.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 3:6 w p notitle
set term jpeg
set output "eps1_v_mu2.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol e}_1 - Filler Material"
set ylabel "Frequency, GHz"
set output "eps1_v_freq.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 3:7 w p notitle
set term jpeg
set output "eps1_v_freq.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol e}_1 - Filler Material"
set ylabel "Objective"
set output "eps1_v_obj.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 3:8 w p notitle
set term jpeg
set output "eps1_v_obj.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol e}_2 - Particle Material"
set ylabel "Objective"
set output "eps2_v_obj.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 4:8 w p notitle
set term jpeg
set output "eps2_v_obj.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol m}_1 - Filler Material"
set ylabel "Objective"
set output "mu1_v_obj.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 5:8 w p notitle
set term jpeg
set output "mu1_v_obj.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "{/Symbol m}_2 - Particle Material"
set ylabel "Objective"
set output "mu2_v_obj.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 6:8 w p notitle
set term jpeg
set output "mu2_v_obj.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'

#Compression Ratio
set xlabel "Frequency, GHz"
set ylabel "Objective"
set output "freq_v_obj.eps"
plot "<awk '{if($8<100){print $0}}' dnm_multidim.dat" u 7:8 w p notitle
set term jpeg
set output "freq_v_obj.jpg"
replot
set terminal postscript eps enhanced color font 'Helvetica,20'
