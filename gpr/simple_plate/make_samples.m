% とりあえずの学習データをランダムに作りたい
makesamples('simple_plate_0.csv', 1);

function samples = makesamples(filename, numheader)

    data = readmatrix(filename, "NumHeaderLines", numheader);
    % 区間(0, 1)の一様分布からの乱数をもとの平板データに足す
    x = (randn(length(data), 7, 10) - 0.5);
    samples = zeros(length(data), 7, length(x(1,1,:)));
    for i = 1:1:length(x(1,1,:))
        samples(:,1,i) = data(:,1); % 横軸ようの時間考慮
        samples(:,2:8,i) = data(:, 2:8) + x(:,:,i);
        sample = array2table(samples(:,:,i));
        sample.Properties.VariableNames(1:8) = ...
            {'t', 'q0', 'q1', 'q2', 'q3', 'x_cowell', 'y_cowell', 'z_cowell'};
        savename = strcat('simple_plate_', num2str(i), '.csv');
        writetable(sample, savename);
    end

end