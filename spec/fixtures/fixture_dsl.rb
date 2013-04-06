collection "foo"
out "bar"
verbose true

__END__
@@ map
function () { emit(this.id, this.count); }
@@ reduce
function (key, values) { return 0; }
