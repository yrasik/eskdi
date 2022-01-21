% Этот файл является файлом - сценарием пакета Matlab
% С помощью такого файла можно вести вычисления и одновременно создавать
% отчёт для LaTeX
close all;
clear all;

file_name = 'matlab_generated.tex';
fid = fopen( file_name, 'w' );

fprintf( fid, '%s\r\n', '%Этот файл создан автоматически сценарием mallab.m');
fprintf( fid, '%s\r\n', '\section{Пример работы совместно с Matlab} \label{app:matlab}');
fprintf( fid, '%s\r\n', '\sectionmark{Пример работы совместно с Matlab}');
fprintf( fid, '%s\r\n','');
fprintf( fid, '%s\r\n', 'Идея заключается в создании m--файла сценария таким образом, чтобы он выполнял следующие функции:');
fprintf( fid, '%s\r\n', '\begin{itemize}');
fprintf( fid, '%s\r\n', '\item выполнял необходимые расчёты;');
fprintf( fid, '%s\r\n', '\item строил графики и печатал их в файлы;');
fprintf( fid, '%s\r\n', '\item все пояснения к расчётам печатал в файл *.tex;');
fprintf( fid, '%s\r\n', '\item включал в этот же файл ссылки на рирсунки из Matlab;');
fprintf( fid, '%s\r\n', '\item печатал формулы в формате LaTeX.');
fprintf( fid, '%s\r\n', '\end{itemize}');
fprintf( fid, '%s\r\n','');
fprintf( fid, '%s\r\n','Один из вариантов решения представлен здесь.');

x_ = [ -4: 0.1 : 4];
y2 = x_ .^2;
y3 = x_ .^3;

syms x;
y = x .^2;
res = latex(y);
str = strcat('y=',res);

fprintf( fid, '%s\r\n', 'Формула~(\ref{matlab_eq:1}) создана оперетором Matlab latex():');
fprintf( fid, '%s\r\n', '\begin{eqnarray}');
fprintf( fid, '%s\r\n', str);
fprintf( fid, '%s\r\n', '\label{matlab_eq:1}');
fprintf( fid, '%s\r\n', '\end{eqnarray}');

fprintf( fid, '%s\r\n', 'Это может быть иногда полезно.');

fprintf( fid, '%s\r\n', '\newpage');


h = figure(1);
plot(x_, y2,'--', x_,y3,':');
grid on;
title('название');
xlabel('подпись оси х');
ylabel('подпись оси y');
legend('y=x^2','y=x^3'); 
saveas(h,'matlab_figure_001','jpg');

fprintf( fid, '%s\r\n','');
fprintf( fid, '%s\r\n', '\begin{figure}[!h]\center');
fprintf( fid, '%s\r\n', '\captionsetup{singlelinecheck=true}');
fprintf( fid, '%s\r\n', '\includegraphics*[scale=0.4]{./about/matlab/matlab_figure_001}');
fprintf( fid, '%s\r\n', '\caption{Графики функций} \label{matlab_figure_001}');
fprintf( fid, '%s\r\n', '\end{figure}');


fprintf( fid, '%s\r\n', '\newpage');
y = x .^3;
res = latex(y);
str = strcat('Простые формулы $','y=',res, '$ также можно вставлять в текст.');
fprintf( fid, '%s\r\n',str);

h = figure(2);
plot(x_, y2,'r', x_,y3,'b', 'LineWidth' , 3);
grid on;
title('название');
xlabel('подпись оси х');
ylabel('подпись оси y');
legend('y=x^2','y=x^3'); 
saveas(h,'matlab_figure_002','jpg');

fprintf( fid, '%s\r\n','');
fprintf( fid, '%s\r\n', '\begin{figure}[!h]\center');
fprintf( fid, '%s\r\n', '\captionsetup{singlelinecheck=true}');
fprintf( fid, '%s\r\n', '\includegraphics*[scale=0.4]{./about/matlab/matlab_figure_002}');
fprintf( fid, '%s\r\n', '\caption{Графики функций} \label{matlab_figure_002}');
fprintf( fid, '%s\r\n', '\end{figure}');

fprintf( fid, '%s\r\n','');
fprintf( fid, '%s\r\n', 'Ниже приведён листинг данного m--файла');
%fprintf( fid, '%s\r\n', '\lstinputlisting[style=MatlabStyle]{./about/matlab/mallab.m}');
fprintf( fid, '%s\r\n', '\inputminted[fontsize=\small, linenos, breaklines, numbersep=2mm, xleftmargin=5mm]{matlab}{./about/matlab/mallab.m}');



fclose( fid ); 