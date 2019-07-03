function rt = MatchedFilter(st)
    ht = st(end:-1:1);
    rt = conv(st, ht);
end
