%drawMapDynamic.m

%Called by: MapButton
%Calls: N/A
%Inputs: data(table)
%Returns: N/A

%{
drawMapDynamic take 1 table as an input. It the plots data from the table using
'.' as a marker and sets the color of the marker to green. It then reads the
data from treeInfo.dat and sets the colors of the markers of those trees to
blue.
%}

function drawMapDynamic(data)

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
        %Calls drawMap() instead
        drawMap(data);
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
        %Closes treeInfo.dat
    fclose(fid);
    %Converts strings in Lat to floats
    Lat=cellfun(@str2num,Lat);
    %Convertss strings in Long to floats
    Long=cellfun(@str2num,Long);
    %Plots points found in treeInfo.dat
    scatter(Long,Lat,2.5,'b','o');
    legend('Tree','Discovered Trees');
    end
end