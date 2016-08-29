function pvals_corr=plot_perm(Data,time,lim,time_int)
% *********************************************************************
% Date: Octobre 2014            Programm� par: D. Bolger
% Function to carry out a permutation test with correction fdr entre
% deux vecteur de donn�es (le grande moyen pour deux conditions 
% sujets).
% La fonction cherche les pointes temporelles o� les p-values sont <=0.05
% et les pointes temporelles o� les p-values sont <0.05 et <0.06. Ces
% pointes temporelles sont marqu�es en rouge et verts, respectivement. 
% Data:  matrice (Time X 2) 
% time: time vector
% lim: d�termine � quelle niveau dans le plot les p-values sont pr�sent�.
% On peut le d�finir pour que la repr�sentation des p-values ne g�ne pas la
% reste du plot, e.g. 4.
% Output:
% pvals_corr = vecteur de permutation p-values (m�me taille que le vecteur time). 
%**************************************************************************************
ti=find(time>=time(1) & time<time_int(1));
[t,df,pvals]=statcond(Data,'mode','perm','naccu',5000);  %calculated with a default number of 1000 random partitions
pvals_corr=fdr(pvals);   % fdr correction of permutation p-values
pvals_corr(ti)=1;
xi=find(pvals_corr<=0.05);
xi2=find(pvals_corr>0.05 & pvals_corr<=0.06);
X=zeros(length(time),1);
X2=zeros(length(time),1);

X(xi)=lim;
i=find(X==0);
X(i)=NaN;

X2(xi2)=lim;
i1=find(X2 ==0);
X2(i1)=NaN;

p5=plot(gca,time,X,'ro');
hold on
p6=plot(gca,time,X2,'go');

end

