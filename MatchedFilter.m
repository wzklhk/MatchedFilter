function rt = MatchedFilter(st)
    % MatchedFilter - Description
    % 匹配滤波函数
    % 
    % Syntax: rt = MatchedFilter(st)
    %
    % st 要匹配滤波的信号
    % rt 匹配滤波后的结果
    % ht 匹配滤波器系统函数
    ht = st(end:-1:1); 
    rt = conv(st, ht);
end
