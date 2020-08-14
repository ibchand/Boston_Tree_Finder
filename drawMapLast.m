%drawMapLast.m

%Called by: NearestButton, RandomButton
%Calls: N/A
%Inputs: data(table)
%Returns: N/A

%{
drawMapLast take 1 table as an input. It the plots data from the table using
'.' as a marker and sets the color of the marker to green. It then reads the
data from treeInfo.dat and plots a point for the last data point in
treeInfo.dat with the color blue.
%}

function drawMapLast(data,lat,long)

    %Creates figure
    figure
    hold;

    %Plots the values from data
    scatter(data{1:height(data),1},data{1:height(data),2},0.5,[0.31, 0.85, 0.40],'.');
    %Open treeInfo.dat to read data from it
    fid=fopen("treeInfo.dat",'r');
    %Checks if treeInfo.dat opened successfully
    if fid == -1
        %Displays error message is not opened successfully 
        disp('Error, file failed to open')
    else
        %N is the iteration variable
        n=1;
        %Gets the next first line from treeInfo.dat file
        aline=fgetl(fid);
        %While loop will go through treeInfo.dat to get coordinates
        while (aline ~= -1)
            %Gets Latitude
            [Lat{n},rest]=strtok(aline,',');
            %Gets Longitude
            [Long{n},rest]=strtok(rest,',');
            %Gets Address
            Address{n}=rest(1,2:end);
            %Increases n by 1
            n=n+1;
            %Gets next line
            aline=fgetl(fid);
        end
    end
    %Closes treeInfo.dat
    fclose(fid);
    %Converts strings in Lat to floats
    Lat=cellfun(@str2num,Lat);
    %Convertss strings in Long to floats
    Long=cellfun(@str2num,Long);
    %Plots last point found in treeInfo.dat
    scatter(Long(end),Lat(end),5,'b','o');
    scatter(long,lat,5,'r','o');
    legend('Tree','Your Tree','You');
end