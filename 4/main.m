clear;
[W, vocab] = load_docword('.', 'nips');
[WW, Dtf, Didf] = tf_idf(W);


[U, S, V] = svds(WW, 20);
new_WW = U * S * V';

idc = 0;
for i = 1:length(vocab)
	if strcmp(vocab{i}, 'circuit')
		idc = i
	end
end

score = new_WW(:, idc);
[v, idx] = sort(score, 'descend');

num_doc = 5;
num_word = 10;
for i = 1:num_doc
	show_top_words(WW(idx(i), :), vocab, num_word);
end
