%drawMap.m

%Called by: MapButton
%Calls: N/A
%Inputs: data(table)
%Returns: N/A

%{
drawMap take 1 table as an input. It the plots data from the table using
'.' as a marker and sets the color of the marker to green.
%}

function drawMap(data)

    %Creates figure
    figure

    %Plots the values from data, sets size to 0.5, sets color to green,
    %sets marker to '.'
    scatter(data{1:height(data),1},data{1:height(data),2},0.5,[0.31, 0.85, 0.40],'.');
    legend('Tree');
end