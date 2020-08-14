%distFormula.m

%Called by: getTree()
%Calls: N/A
%Inputs: LatO(double),LongO(double),LatD(double),LongD(double)
%Returns: dist(double)

%{
distFormula takes 4 doubles as inputs. It then puts those 4 doubles into
the distance formula which is a form of the pythagorean theorem. It then
returns 1 double.
%}

function dist=distFormula(LatO,LongO,LatD,LongD)
    
    %Calculates distance and assigns it to variable dist
    dist=sqrt((LatD-LatO).^2+(LongD-LongO).^2);
    
end %End of function