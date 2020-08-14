%getTree.m

%Called by: NearestButton(),RandomButton()
%Calls: distFormula(),min(),max(),getDist()
%Inputs: data(table),LatO(double),LongO(double),Mode(string),r(double)
%Returns: Lat(double),Long(double),Address(cell),URL(string)

%{
getTree takes 4 or 5 inputs. The 4 which are always passed are 1 table, 2
doubles, and 1 string. The fifth input which is only given when the
RandomButton pressed is an int. If only 4 inputs are given, then that means
the NearestButton has been pressed. At the end, an file treeInfo.dat is
opened to which the coordinates and address of the tree returned are
appended.

If NearestButton is pressed, then all the tree coordinate values given in
the table are passed to the distFormula() and an array of distances is
returned. Then a file named length.dat is opened and the value of num and 
the length of distances is written to it. From that array, num amount of 
the smallest values indexes are found using the c function MIN which writes 
the indexes to the file indexes.dat. Those indexes are then retrieved and the used
used to get the coordinates of the corresponding trees from data which are then passed to
getDist() which returns an array of values. This array is then written to the file exactDist.dat
which is then read by the c function exactDist which returns the index of
the smallest value with which the values needed are found. 

If RandomButton is pressed, then just the tree coordinate values in the
table at index r are taken which are then passed to getDist() and the
distance, address, and URL are returned.
%}

function [Lat,Long,Address,Distance,Time,URL]=getTree(varargin)
   
    %Set N to the number of inputs
    N=nargin;
    
    %num is the amount of values that are sent to getDist() (Google API)
    num=5;
    
    %This function always has 4 inputs, but only sometimes has 5
    
    %data is set equal to the first input
    data=varargin{1};
    
    %LatO is set equal to the second input
    LatO=varargin{2};
    
    %LongO is set equal to the third input
    LongO=varargin{3};
    
    %Mode is set equal to the fourth input
    Mode=varargin{4};
    
    %4 Inputs means NearestButton called getTree()
    if N==4
        %Find num Closest Trees first
        
        %Calls distFormula, passing all data of all trees in data
        D=distFormula(LatO,LongO,data{:,2},data{:,1});
        
        %len is set to the length of D
        len=length(D); %int
                
        %Opens length.dat to write to it
        fid=fopen("length.dat",'w');
        %Checks if length.dat opened successfully
        if fid == -1
            %Displays error message is not opened successfully 
            disp('Error, file failed to open')
        else
            %Inputs len into length.dat
            fprintf(fid,"%d ",len);
            %Inputs num into length.dat
            fprintf(fid,"%d",num);
        end
        %Closes length.dat
        fc=fclose(fid);
        %Checks if length.dat closed successfully
        if fc == -1
            disp('Error, file failed to close')
        end
        
        %Opens distances.dat to write to it
        fid=fopen("distances.dat",'w');
        %Checks if distances.dat opened successfully
        if fid == -1
            %Displays error message if not opened successfully
            disp('Error, file failed to open')
        else
            %Traverses D
            for i=1:length(D)
                %Writes values of D into distances.d
                fprintf(fid,"%f ",D(i));
            end
        end
        %Closes distances.dat
        fc=fclose(fid);
        %Checks if distances.dat closed successfully
        if fc == -1
            %Displays error message if not closed successfully
            disp('Error, file failed to close')
        end
        
        %Executes the C code to calculate Num minimums which are put in a
        %file name indexes.dat
        system("./MIN");
        
        %Opens indexes.dat to read from
        fid=fopen("indexes.dat",'r');
        %Checks if indexes.dat opened successfully
        if fid == -1
            %Displays error message if not opened successfully
            disp('Error, file failed to open')
        else
            %Preallocates cell array of size 1 by num
            small=cell(1,num);
            %Traverses indexes.dat
            for i=1:num
                %Reads each index and assigns it to small
                small{i}=fgetl(fid);
            end
        end
        %Closes distances.dat
        fc=fclose(fid);
        %Checks if distances.dat closed successfully
        if fc == -1
            %Displays error message if not closed successfully
            disp('Error, file failed to close')
        end        
        
        %Converts the small to a matrix of integers from cell of strings
        small=cellfun(@str2num,small);
                
        %Calls getDist(), passing the values in data with indexes in small 
        [dist,address,time,URL]=getDist(LatO,LongO,data{small(:),2},data{small(:),1},Mode);
        
        %Opens exactDist.dat to write to it
        fid=fopen("exactDist.dat",'w');
        %Checks if exactDist.dat opened successfully
        if fid == -1
            %Displays error message if not opened successfully
            disp('Error, file failed to open')
        else
            %Traverses dist
            for i=1:length(dist)
                %Writes values of dist into distances.d
                fprintf(fid,"%f ",dist(i));
            end
        end
        %Closes exactDist.dat
        fc=fclose(fid);
        %Checks if exactDist.dat closed successfully
        if fc == -1
            %Displays error message if not closed successfully
            disp('Error, file failed to close')
        end
        
        %Calls the C min function which returns index of smallest value in
        %dist
        distIndex=system("./exactMIN");
                
        %Lat is set equal to latitude value in data with index
        %small(distIndex)
        Lat=data{small(distIndex),2};
        
        %Long is set equal to longitude value in data with index
        %small(distIndex)
        Long=data{small(distIndex),1};
        
        %Gets Address and Distance
        Address=address(distIndex);
        Distance=dist(distIndex);
        Time=time{distIndex};
        
    %5 inputs means RandomButton called getTree()
    elseif N==5
        
        %r is set equal to the fifth input
        r=varargin{5};
        
        %Lat is set equal to latitude value at r index in data
        Lat=data{r,2};
        
        %Long is set equal to longitude value at r index in data
        Long=data{r,1};
        
        %Calls getDist() to get distance, address, and URL of random tree
        [Distance,Address,Time,URL]=getDist(LatO,LongO,Lat,Long,Mode);
        Time=Time{1};
    end
    
    %Opens treeInfo.dat to append data to it
    fid=fopen("treeInfo.dat",'a');
    %Checks if treeInfo.dat opened successfully
    if fid == -1
        %Displays error message if not opened successfully 
        disp('Error, file failed to open')
    else
        %Prints Lat,Long,and Address which is casted to a string
        fprintf(fid,"%s,%s,%s\n",Lat,Long,char(Address));
    end
    %Closes treeInfo.dat
    fc=fclose(fid);
    %Checks is treeInfo.dat closed successfully
    if fc == -1
        %Displays error messagle if not closed successfully
        disp('Error, file failed to close')
    end    
end