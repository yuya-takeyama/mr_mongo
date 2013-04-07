set :collection, "foo"
set :out, "bar"
set :verbose

__END__
@@ map
function () { emit(this.id, this.count); }
@@ reduce
function (key, values) { return 0; }
