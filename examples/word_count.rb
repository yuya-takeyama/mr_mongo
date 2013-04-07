set :collection, 'texts'
set :out, {inline: 'word_counts'}

__END__

@@ map
function () {
  this.text.split(/\s+/).forEach(function (word) {
    emit(word, {count: 1});
  });
}

@@ reduce
function (key, values) {
  var count = 0;

  values.forEach(function (value) {
    count += value.count;
  });

  return {count: count};
}
